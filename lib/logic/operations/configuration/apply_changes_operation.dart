import 'package:collection/collection.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/services_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/settings_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/users_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/volumes_repository.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

enum DnsUpdateOutcome { unchanged, updated, unavailable, failed }

enum ConfigurationStage { change, dns, rebuild }

OperationStep configurationStep(
  final JobDraft change, {
  final OperationStatus status = OperationStatus.queued,
  final String? jobId,
  final String? messageKey,
}) => OperationStep(
  id: change.id,
  titleKey: switch (change) {
    ChangeServerTimezoneJob() => 'jobs.change_server_timezone',
    ChangeSshSettingsJob() => 'jobs.change_ssh_settings',
    ChangeAutoUpgradeSettingsJob() => 'jobs.change_auto_upgrade_settings',
    ChangeServiceConfiguration() => 'jobs.change_service_settings',
    ServiceToggleJob(:final needToTurnOn) =>
      needToTurnOn ? 'jobs.service_turn_on' : 'jobs.service_turn_off',
    DeleteUserJob() => 'jobs.delete_user',
    CreateSSHKeyJob() => 'jobs.create_ssh_key',
    DeleteSSHKeyJob() => 'jobs.delete_ssh_key',
    RebootServerJob() => 'jobs.reboot_server',
    UpgradeServerJob() => 'jobs.start_server_upgrade',
    CollectNixGarbageJob() => 'jobs.collect_nix_garbage',
    UpdateDnsRecordsJob() => 'jobs.update_dns_records',
    _ => 'operations.kind.apply_changes',
  },
  target: switch (change) {
    ChangeServiceConfiguration(:final serviceDisplayName) => serviceDisplayName,
    ServiceToggleJob(:final service) => service.displayName,
    DeleteUserJob(:final user) ||
    CreateSSHKeyJob(:final user) ||
    DeleteSSHKeyJob(:final user) => user.login,
    _ => null,
  },
  status: status,
  jobId: jobId,
  messageKey: messageKey,
);

class ConfigurationProgress {
  const ConfigurationProgress({
    required this.stage,
    required this.status,
    this.changeId,
    this.jobId,
    this.messageKey,
  });

  factory ConfigurationProgress.fromResult(
    final ConfigurationStage stage,
    final ServerMutationResult<Object?> result, {
    final String? changeId,
  }) {
    final step = OperationStep.fromMutation(
      id: changeId ?? stage.name,
      titleKey: 'operations.kind.apply_changes',
      result: result,
    );
    return ConfigurationProgress(
      stage: stage,
      status: step.status,
      changeId: changeId,
      jobId: step.jobId,
      messageKey: step.messageKey,
    );
  }

  final ConfigurationStage stage;
  final OperationStatus status;
  final String? changeId;
  final String? jobId;
  final String? messageKey;
}

class ApplyChangesOperation {
  ApplyChangesOperation({
    required final UsersRepository users,
    required final SettingsRepository settings,
    required final ServicesRepository services,
    required final JobsRepository jobs,
    required final VolumesRepository volumes,
    required final Future<List<DnsRecord>?> Function() readDns,
    required final DnsProvider? dnsProvider,
    required final ServerDomain domain,
  }) : _users = users,
       _settings = settings,
       _services = services,
       _jobs = jobs,
       _volumes = volumes,
       _readDns = readDns,
       _dnsProvider = dnsProvider,
       _domain = domain;

  final UsersRepository _users;
  final SettingsRepository _settings;
  final ServicesRepository _services;
  final JobsRepository _jobs;
  final VolumesRepository _volumes;
  final Future<List<DnsRecord>?> Function() _readDns;
  final DnsProvider? _dnsProvider;
  final ServerDomain _domain;

  Future<void> run(
    final List<JobDraft> changes, {
    required final void Function(ConfigurationProgress) onProgress,
  }) async {
    final submitted = List<JobDraft>.unmodifiable(changes);
    void publish(final ConfigurationProgress progress) {
      final change = submitted.firstWhereOrNull(
        (final change) => change.id == progress.changeId,
      );
      OperationExecution.current?.recordStep(
        change == null
            ? OperationStep(
                id: progress.stage.name,
                titleKey: progress.stage == ConfigurationStage.dns
                    ? 'jobs.update_dns_records'
                    : 'jobs.rebuild_system',
                status: progress.status,
                jobId: progress.jobId,
                messageKey: progress.messageKey,
              )
            : configurationStep(
                change,
                status: progress.status,
                jobId: progress.jobId,
                messageKey: progress.messageKey,
              ),
      );
      onProgress(progress);
    }

    final dnsRequired = submitted.any(
      (final change) => change.requiresDnsUpdate,
    );
    final rebuildRequired = submitted.any(
      (final change) => change.requiresRebuild,
    );
    final previousDns = dnsRequired ? await readDns() : null;
    for (final change in submitted) {
      _requireAttached();
      publish(
        ConfigurationProgress(
          stage: ConfigurationStage.change,
          status: OperationStatus.running,
          changeId: change.id,
        ),
      );
      final result = await execute(change);
      publish(
        ConfigurationProgress.fromResult(
          ConfigurationStage.change,
          result,
          changeId: change.id,
        ),
      );
    }
    if (previousDns != null) {
      _requireAttached();
      publish(
        const ConfigurationProgress(
          stage: ConfigurationStage.dns,
          status: OperationStatus.running,
        ),
      );
      final dns = await updateDns(previousDns);
      publish(
        ConfigurationProgress(
          stage: ConfigurationStage.dns,
          status:
              dns == DnsUpdateOutcome.updated ||
                  dns == DnsUpdateOutcome.unchanged
              ? OperationStatus.succeeded
              : OperationStatus.failed,
          messageKey: switch (dns) {
            DnsUpdateOutcome.updated => 'jobs.dns_records_changed',
            DnsUpdateOutcome.unchanged => 'jobs.dns_records_did_not_change',
            DnsUpdateOutcome.unavailable ||
            DnsUpdateOutcome.failed => 'jobs.failed_to_load_dns_records',
          },
        ),
      );
    }
    if (rebuildRequired) {
      _requireAttached();
      publish(
        const ConfigurationProgress(
          stage: ConfigurationStage.rebuild,
          status: OperationStatus.running,
        ),
      );
      publish(
        ConfigurationProgress.fromResult(
          ConfigurationStage.rebuild,
          await apply(),
        ),
      );
    }
  }

  void _requireAttached() {
    if (!_jobs.commands.isAttached) {
      throw const OperationNotSent();
    }
  }

  Future<ServerMutationResult<Object?>> execute(final JobDraft job) {
    _requireAttached();
    return switch (job) {
      DeleteUserJob(:final user) => _users.deleteUser(user),
      CreateSSHKeyJob(:final user, :final publicKey) => _users.addSshKey(
        user,
        publicKey,
      ),
      DeleteSSHKeyJob(:final user, :final publicKey) => _users.deleteSshKey(
        user,
        publicKey,
      ),
      ServiceToggleJob(:final service, :final needToTurnOn) =>
        _services.switchService(
          serviceId: service.id,
          needTurnOn: needToTurnOn,
        ),
      ChangeAutoUpgradeSettingsJob(:final enable, :final allowReboot) =>
        _settings.setAutoUpgradeSettings(
          enable: enable,
          allowReboot: allowReboot,
        ),
      ChangeServerTimezoneJob(:final timezone) => _settings.setServerTimezone(
        timezone,
      ),
      ChangeSshSettingsJob(:final enable) => _settings.setSshSettings(
        enable: enable,
      ),
      ChangeServiceConfiguration(:final serviceId, :final settings) =>
        _services.setConfiguration(serviceId, settings),
      CollectNixGarbageJob() => _jobs.collectNixGarbage(),
      UpgradeServerJob() => _jobs.upgrade(),
      RebootServerJob() => _volumes.reboot(),
      _ => throw StateError('Unsupported client job'),
    };
  }

  Future<void> executeMaintenance(final JobDraft job) async {
    OperationExecution.current?.recordStep(
      configurationStep(job, status: OperationStatus.running),
    );
    final result = await execute(job);
    final progress = ConfigurationProgress.fromResult(
      ConfigurationStage.change,
      result,
    );
    OperationExecution.current?.recordStep(
      configurationStep(
        job,
        status: progress.status,
        jobId: progress.jobId,
        messageKey: progress.messageKey,
      ),
    );
  }

  Future<ServerMutationResult<ServerJob>> apply() {
    _requireAttached();
    return _jobs.apply();
  }

  Future<List<DnsRecord>> readDns() async {
    _requireAttached();
    try {
      final records = await _readDns();
      _requireAttached();
      return List.unmodifiable(records ?? const []);
    } on OperationNotSent {
      rethrow;
    } catch (_) {
      _requireAttached();
      return const [];
    }
  }

  Future<DnsUpdateOutcome> updateDns(final List<DnsRecord> previous) async {
    final current = await readDns();
    if (previous.isEmpty || current.isEmpty) {
      OperationExecution.current?.recordCompletion(succeeded: false);
      return DnsUpdateOutcome.unavailable;
    }
    if (const UnorderedIterableEquality<DnsRecord>().equals(
      previous,
      current,
    )) {
      OperationExecution.current?.recordCompletion(succeeded: true);
      return DnsUpdateOutcome.unchanged;
    }
    final provider = _dnsProvider;
    if (provider == null || !provider.isAuthorized) {
      OperationExecution.current?.recordCompletion(succeeded: false);
      return DnsUpdateOutcome.unavailable;
    }
    _requireAttached();
    try {
      final result = await provider.updateDnsRecords(
        newRecords: current
            .where((final record) => record.content != null)
            .toList(),
        oldRecords: previous,
        domain: _domain,
      );
      OperationExecution.current?.recordCompletion(succeeded: result.success);
      _requireAttached();
      return result.success
          ? DnsUpdateOutcome.updated
          : DnsUpdateOutcome.failed;
    } on OperationNotSent {
      rethrow;
    } catch (_) {
      _requireAttached();
      OperationExecution.current?.recordCompletion(succeeded: false);
      return DnsUpdateOutcome.failed;
    }
  }
}
