import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/cache/server_state_cache.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/connection/repositories/backups_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/devices_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/recovery_key_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/services_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/settings_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/users_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/volumes_repository.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/connection/sync/sync_scheduler.dart';

/// Owns domain stores and coordinates commands for one server connection.
class ServerConnection {
  ServerConnection({
    required this.api,
    required this.origin,
    required final ServerStateOrigin? Function() currentOrigin,
    final DateTime Function()? now,
    final CacheTimerFactory? createTimer,
  }) : _currentOrigin = currentOrigin {
    cache = ServerStateCache(api: api, now: now, createTimer: createTimer);
    final deviceStore = cache.devices;
    final jobsStore = cache.serverJobs;
    final usersStore = cache.users;
    final settingsStore = cache.settings;
    final servicesStore = cache.services;
    final backupsStore = cache.backups;
    final configStore = cache.backupConfig;
    final volumesStore = cache.volumes;
    commands = ServerCommandCoordinator(
      api: api,
      origin: origin,
      currentOrigin: () => isAttached ? origin : null,
      stores: cache.stores,
      apiVersion: cache.apiVersion,
    );
    scheduler = SyncScheduler(
      cache: cache,
      commands: commands,
      now: now,
      createTimer: createTimer,
    );
    devices = DevicesRepository(
      commands: commands,
      reader: _reader(deviceStore),
    );
    groups = _reader(cache.groups);
    recoveryKey = RecoveryKeyRepository(
      commands: commands,
      reader: _reader(cache.recoveryKeyStatus),
    );
    jobs = JobsRepository(
      commands: commands,
      reader: _reader(jobsStore),
      backupsStore: backupsStore,
      servicesStore: servicesStore,
      volumesStore: volumesStore,
      stores: cache.stores,
    );
    users = UsersRepository(commands: commands, reader: _reader(usersStore));
    settings = SettingsRepository(
      commands: commands,
      reader: _reader(settingsStore),
    );
    services = ServicesRepository(
      commands: commands,
      reader: _reader(servicesStore),
      jobs: jobs,
      volumesStore: volumesStore,
    );
    backups = BackupsRepository(
      commands: commands,
      reader: _reader(backupsStore),
      configuration: _reader(configStore),
      jobs: jobs,
      servicesStore: servicesStore,
    );
    volumes = VolumesRepository(
      commands: commands,
      reader: _reader(volumesStore),
      servicesStore: servicesStore,
    );
    for (final store in cache.stores) {
      _subscriptions.add(
        store.stream.listen((_) {
          if (isAttached) {
            _changes.add(null);
          }
        }),
      );
    }
  }

  final ServerApi api;
  final ServerStateOrigin origin;
  final ServerStateOrigin? Function() _currentOrigin;
  late final ServerStateCache cache;
  late final ServerCommandCoordinator commands;
  late final DevicesRepository devices;
  late final RecoveryKeyRepository recoveryKey;
  late final DomainReader<List<String>> groups;
  late final JobsRepository jobs;
  late final UsersRepository users;
  late final SettingsRepository settings;
  late final ServicesRepository services;
  late final BackupsRepository backups;
  late final VolumesRepository volumes;
  final _changes = StreamController<void>.broadcast();
  final _subscriptions = <StreamSubscription<Object?>>[];
  bool _disposed = false;
  late final SyncScheduler scheduler;

  void restoreFrom(final ServerConnection previous) {
    if (origin.serverId != previous.origin.serverId) {
      throw ArgumentError('Cannot restore another server.');
    }
    cache.restoreFrom(previous.cache);
    users.restoreFrom(previous.users);
    jobs.restoreFrom(previous.jobs);
  }

  Stream<void> get changes => _changes.stream;
  bool get isAttached => !_disposed && identical(_currentOrigin(), origin);

  DomainReader<T> _reader<T extends Object>(final DomainStore<T> store) {
    _checkOwner(store);
    return DomainReader(
      store: store,
      apiVersion: cache.apiVersion,
      dispatcher: scheduler,
    );
  }

  Future<RefreshResult> refresh<T extends Object>(
    final DomainStore<T> store, {
    final bool force = false,
  }) => scheduler.refresh(store, force: force);

  void _checkOwner(final DomainStore<Object> store) {
    if (!cache.stores.contains(store)) {
      throw ArgumentError('Store belongs to another connection.');
    }
  }

  /// Disposes all stores. Requests already sent to the server are not cancelled.
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    scheduler.dispose();
    commands.dispose();
    jobs.dispose();
    cache.dispose();
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    unawaited(_changes.close());
  }
}
