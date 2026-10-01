import 'dart:async';

import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/cache/server_state_cache.dart';
import 'package:selfprivacy/logic/connection/repositories/backups_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/devices_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/services_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/settings_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/users_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/volumes_repository.dart';
import 'package:selfprivacy/logic/connection/sync/operation_execution.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/connection/sync/sync_scheduler.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';

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
    volumesStore = cache.volumes;
    commands = ServerCommandCoordinator(
      api: api,
      origin: origin,
      currentOrigin: () => isAttached ? origin : null,
      stores: cache.stores,
    );
    devices = DevicesRepository(connection: this, store: deviceStore);
    jobs = JobsRepository(connection: this, store: jobsStore);
    users = UsersRepository(connection: this, store: usersStore);
    settings = SettingsRepository(connection: this, store: settingsStore);
    services = ServicesRepository(connection: this, store: servicesStore);
    backups = BackupsRepository(
      connection: this,
      store: backupsStore,
      configStore: configStore,
    );
    volumes = VolumesRepository(connection: this, store: volumesStore);
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
  late final JobsRepository jobs;
  late final UsersRepository users;
  late final SettingsRepository settings;
  late final ServicesRepository services;
  late final BackupsRepository backups;
  late final VolumesRepository volumes;
  late final DomainStore<List<ServerDiskVolume>> volumesStore;
  final _changes = StreamController<void>.broadcast();
  final _subscriptions = <StreamSubscription<Object?>>[];
  final _refreshes = <DomainStore<Object>, Completer<RefreshResult>>{};
  bool _disposed = false;
  SyncScheduler? scheduler;

  void restoreFrom(final ServerConnection previous) {
    if (origin.serverId != previous.origin.serverId) {
      throw ArgumentError('Cannot restore another server.');
    }
    cache.restoreFrom(previous.cache);
    users.restoreFrom(previous.users);
    backups.restoreFrom(previous.backups);
    jobs.restoreFrom(previous.jobs);
  }

  Stream<void> get changes => _changes.stream;
  Iterable<DomainStore<Object>> get stores => List.unmodifiable(cache.stores);
  bool get isAttached => !_disposed && identical(_currentOrigin(), origin);

  Future<ServerMutationResult<T>> mutate<T>({
    required final Iterable<DomainStore<Object>> domains,
    required final Future<ServerMutationResult<T>> Function(ServerApi) send,
    final Iterable<DomainStore<Object>> Function(ServerMutationResult<T>)?
    applyConfirmed,
  }) async {
    final result = await _mutate(
      domains: domains,
      send: (final api) {
        GraphQLDispatchGuard.current?.check();
        return send(api);
      },
      applyConfirmed: applyConfirmed,
    );
    OperationExecution.current?.record(result);
    return result;
  }

  Future<ServerMutationResult<T>> _mutate<T>({
    required final Iterable<DomainStore<Object>> domains,
    required final Future<ServerMutationResult<T>> Function(ServerApi) send,
    final Iterable<DomainStore<Object>> Function(ServerMutationResult<T>)?
    applyConfirmed,
  }) async {
    final affected = domains.toSet()..forEach(_checkOwner);
    if (isAttached && cache.apiVersion.value.data == null) {
      await _refreshVersion();
    }
    if (!isAttached ||
        affected.any(
          (final store) => store.value.support != DomainSupport.supported,
        )) {
      return ServerMutationResult<T>(
        outcome: ServerMutationOutcome.indeterminate,
        payload: const ServerMutationPayload.notExpected(),
      );
    }
    final completion = await commands
        .submit<T>(
          domains: affected,
          send: send,
          applyConfirmed: applyConfirmed,
        )
        .completion;
    if (!isAttached ||
        completion.application == CommandApplication.detached ||
        completion.application == CommandApplication.failed) {
      return ServerMutationResult<T>(
        outcome: ServerMutationOutcome.indeterminate,
        payload: const ServerMutationPayload.unreadable(),
      );
    }
    final result = completion.result!;
    return result;
  }

  Future<RefreshResult> _refreshVersion() => cache.apiVersion.refresh(
    force: cache.apiVersion.value.lastError != null,
    acceptResult: () => isAttached,
  );

  CachedValue<T> snapshot<T extends Object>(final DomainStore<T> store) {
    _checkOwner(store);
    final versionError = cache.apiVersion.value.lastError;
    return versionError == null
        ? store.value
        : store.value.copyWith(lastError: () => versionError);
  }

  void setVersion(final Version version) {
    if (!isAttached) {
      return;
    }
    cache.setVersion(version);
  }

  /// Shares pending reads per store. Returns deferred while a command owns it.
  Future<RefreshResult> refresh<T extends Object>(
    final DomainStore<T> store, {
    final bool force = false,
  }) {
    _checkOwner(store);
    if (!isAttached) {
      return Future.value(RefreshResult.disposed);
    }
    if (scheduler case final active?) {
      return active.refresh(store.name);
    }
    if (force) {
      store.requestReconciliation();
    }
    if (commands.isReserved(store)) {
      return Future.value(RefreshResult.deferred);
    }
    final active = _refreshes[store];
    if (active != null) {
      return active.future;
    }
    final completion = Completer<RefreshResult>();
    _refreshes[store] = completion;
    unawaited(_completeRead(store, force, completion));
    return completion.future;
  }

  Future<void> _completeRead(
    final DomainStore<Object> store,
    final bool force,
    final Completer<RefreshResult> completion,
  ) async {
    var result = RefreshResult.failed;
    try {
      result = await _read(store, force);
    } finally {
      _refreshes.remove(store);
      if (!completion.isCompleted) {
        completion.complete(result);
      }
    }
  }

  Future<RefreshResult> _read(
    final DomainStore<Object> store,
    final bool force,
  ) async {
    if (store != cache.apiVersion &&
        (cache.apiVersion.value.data == null ||
            cache.apiVersion.value.lastError != null)) {
      final versionResult = await _refreshVersion();
      if (!isAttached) {
        return RefreshResult.disposed;
      }
      if (versionResult != RefreshResult.applied &&
          versionResult != RefreshResult.current) {
        return versionResult;
      }
    }
    if (!isAttached) {
      return RefreshResult.disposed;
    }
    if (commands.isReserved(store)) {
      store.requestReconciliation();
      return RefreshResult.deferred;
    }
    final result = await store.refresh(
      force: force,
      acceptResult: () => isAttached,
    );
    if (!isAttached) {
      dispose();
      return RefreshResult.disposed;
    }
    return result;
  }

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
    scheduler?.dispose();
    for (final completion in _refreshes.values) {
      completion.complete(RefreshResult.disposed);
    }
    _refreshes.clear();
    commands.dispose();
    jobs.dispose();
    cache.dispose();
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    unawaited(_changes.close());
  }
}
