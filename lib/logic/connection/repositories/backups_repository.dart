import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

class BackupsRepository {
  BackupsRepository({
    required this.connection,
    required this.store,
    required this.configStore,
  }) {
    if (!connection.commands.owns(store) ||
        !connection.commands.owns(configStore)) {
      throw ArgumentError('Backup stores belong to another connection.');
    }
  }

  final ServerConnection connection;
  final DomainStore<List<Backup>> store;
  final DomainStore<BackupConfiguration> configStore;
  final _removed = <String>{};
  int _removedReadRevision = 0;

  void restoreFrom(final BackupsRepository previous) {
    _removed.addAll(previous.confirmedRemovedSnapshotIds);
    _removedReadRevision = store.readRevision;
  }

  CachedValue<List<Backup>> get value => connection.snapshot(store);
  CachedValue<BackupConfiguration> get configValue =>
      connection.snapshot(configStore);

  Set<String> get confirmedRemovedSnapshotIds {
    if (_removedReadRevision != store.readRevision) {
      _removed.clear();
      _removedReadRevision = store.readRevision;
    }
    return Set.unmodifiable(_removed);
  }

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
  }) => connection.mutate(
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

  Future<ServerMutationResult<void>> forceBackupListReload() =>
      connection.mutate(
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
  }) => connection.mutate(
    domains: [
      store,
      connection.jobs.store,
      if (restore) connection.services.store,
    ],
    send: send,
    applyConfirmed: (final result) {
      final job = result.payload.value;
      if (job == null) {
        return const [];
      }
      connection.jobs.applyConfirmed(
        job,
        affectedDomains: [store, if (restore) connection.services.store],
      );
      return [connection.jobs.store];
    },
  );

  Future<ServerMutationResult<void>> forgetSnapshot(final String snapshotId) =>
      connection.mutate(
        domains: [store],
        send: (final api) => api.forgetSnapshot(snapshotId),
        applyConfirmed: (_) {
          if (!store.patch(
            (final backups) => List.unmodifiable(
              backups.where((final backup) => backup.id != snapshotId),
            ),
          )) {
            if (_removedReadRevision != store.readRevision) {
              _removed.clear();
            }
            _removedReadRevision = store.readRevision;
            _removed.add(snapshotId);
          }
          return [store];
        },
      );
}
