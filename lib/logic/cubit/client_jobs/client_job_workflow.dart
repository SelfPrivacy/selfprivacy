import 'package:collection/collection.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/services_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/settings_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/users_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/volumes_repository.dart';
import 'package:selfprivacy/logic/connection/sync/operation_execution.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

enum DnsUpdateOutcome { unchanged, updated, unavailable, failed }

class ClientJobWorkflow {
  ClientJobWorkflow({
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

  void _requireAttached() {
    if (!_jobs.commands.isAttached) {
      throw const OperationNotSent();
    }
  }

  Future<ServerMutationResult<Object?>> execute(final ClientJob job) {
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

  Future<ServerMutationResult<ServerJob>> apply() {
    _requireAttached();
    return _jobs.apply();
  }

  Future<List<DnsRecord>> readDns() async {
    _requireAttached();
    final records = await _readDns();
    _requireAttached();
    return List.unmodifiable(records ?? const []);
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
    final result = await provider.updateDnsRecords(
      newRecords: current
          .where((final record) => record.content != null)
          .toList(),
      oldRecords: previous,
      domain: _domain,
    );
    OperationExecution.current?.recordCompletion(succeeded: result.success);
    _requireAttached();
    return result.success ? DnsUpdateOutcome.updated : DnsUpdateOutcome.failed;
  }
}
