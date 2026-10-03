import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

typedef BackupsSnapshot = ({
  CachedValue<List<Backup>> backups,
  CachedValue<BackupConfiguration> configuration,
});

class BackupsRepository {
  BackupsRepository({
    required this.commands,
    required this.reader,
    required this.configuration,
    required this.jobs,
    required this.servicesStore,
  });

  final ServerCommandCoordinator commands;
  final DomainReader<List<Backup>> reader;
  final DomainReader<BackupConfiguration> configuration;
  final JobsRepository jobs;
  final DomainStore<Object> servicesStore;
  DomainStore<List<Backup>> get store => reader.store;
  DomainStore<BackupConfiguration> get configStore => configuration.store;
  CachedValue<List<Backup>> get value => reader.value;
  CachedValue<BackupConfiguration> get configValue => configuration.value;
  BackupsSnapshot get snapshot => (backups: value, configuration: configValue);
  Stream<BackupsSnapshot> get changes =>
      Stream<BackupsSnapshot>.multi((final output) {
        void publish() {
          if (commands.isAttached) {
            output.addSync(snapshot);
          }
        }

        final backups = reader.changes.listen(
          (_) => publish(),
          onDone: output.close,
        );
        final config = configuration.changes.listen((_) => publish());
        output.onCancel = () async {
          await backups.cancel();
          await config.cancel();
        };
      }).distinct();
  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

  Future<ServerMutationResult<BackupConfiguration>> initializeRepository(
    final InitializeRepositoryInput input,
  ) => _configure(
    (final api) => api.initializeRepository(input),
    repositoryChanged: true,
  );

  Future<ServerMutationResult<BackupConfiguration>> removeRepository() =>
      _configure(
        (final api) => api.removeRepository(),
        repositoryChanged: true,
      );

  Future<ServerMutationResult<BackupConfiguration>> setAutobackupPeriod({
    final int? period,
  }) => _configure((final api) => api.setAutobackupPeriod(period: period));

  Future<ServerMutationResult<BackupConfiguration>> setAutobackupQuotas(
    final AutobackupQuotas quotas,
  ) => _configure((final api) => api.setAutobackupQuotas(quotas));

  Future<ServerMutationResult<BackupConfiguration>> _configure(
    final Future<ServerMutationResult<BackupConfiguration>> Function(ServerApi)
    send, {
    final bool repositoryChanged = false,
  }) => commands.mutate(
    domains: [configStore, if (repositoryChanged) store],
    send: send,
    applyConfirmed: (final result) {
      final config = result.payload.value;
      if (config == null) {
        return const [];
      }
      configStore.push(config);
      return [configStore];
    },
  );

  Future<ServerMutationResult<void>> forceBackupListReload() => commands.mutate(
    domains: [store],
    send: (final api) => api.forceBackupListReload(),
  );

  Future<ServerMutationResult<ServerJob>> startBackup(final String serviceId) =>
      _job((final api) => api.startBackup(serviceId));

  Future<ServerMutationResult<ServerJob>> restoreBackup(
    final String snapshotId,
    final BackupRestoreStrategy strategy,
  ) => _job(
    (final api) => api.restoreBackup(snapshotId, strategy),
    restore: true,
  );

  Future<ServerMutationResult<ServerJob>> _job(
    final Future<ServerMutationResult<ServerJob>> Function(ServerApi) send, {
    final bool restore = false,
  }) => commands.mutate(
    domains: [store, jobs.store, if (restore) servicesStore],
    send: send,
    applyConfirmed: (final result) {
      final job = result.payload.value;
      if (job == null) {
        return const [];
      }
      jobs.applyConfirmed(
        job,
        affectedDomains: [store, if (restore) servicesStore],
      );
      return [jobs.store];
    },
  );

  Future<ServerMutationResult<void>> forgetSnapshot(final String snapshotId) =>
      commands.mutate(
        domains: [store],
        send: (final api) => api.forgetSnapshot(snapshotId),
        applyConfirmed: (_) {
          store.patch(
            (final backups) => List.unmodifiable(
              backups.where((final backup) => backup.id != snapshotId),
            ),
          );
          return [store];
        },
      );
}
