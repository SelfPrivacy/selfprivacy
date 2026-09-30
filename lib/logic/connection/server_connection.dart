import 'dart:async';

import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/repositories/backups_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/devices_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/services_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/settings_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/users_repository.dart';
import 'package:selfprivacy/logic/connection/repositories/volumes_repository.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';

/// Owns domain stores and coordinates commands for one server connection.
class ServerConnection {
  ServerConnection({
    required this.api,
    required this.origin,
    required final ServerStateOrigin? Function() currentOrigin,
    final Map<DomainStore<Object>, VersionConstraint> additionalDomains =
        const {},
  }) : _currentOrigin = currentOrigin {
    final deviceStore = DomainStore<List<ApiToken>>(
      name: 'devices',
      refreshInterval: const Duration(seconds: 60),
      fetch: () => DevicesRepository.fetch(api),
    );
    _domains = {
      deviceStore: VersionConstraint.parse('>=2.3.0'),
      ...additionalDomains,
    };
    DomainStore<T> domain<T extends Object>(
      final String name,
      final Future<T> Function() fetch, {
      final int seconds = 60,
      final String version = '>=2.3.0',
    }) {
      final store = DomainStore<T>(
        name: name,
        fetch: fetch,
        refreshInterval: Duration(seconds: seconds),
      );
      _domains[store] = VersionConstraint.parse(version);
      return store;
    }

    final jobsStore = domain<List<ServerJob>>(
      'serverJobs',
      () async => List.unmodifiable(await api.getServerJobs()),
      seconds: 10,
    );
    final usersStore = domain<List<User>>(
      'users',
      () => UsersRepository.fetch(api),
    );
    final settingsStore = domain(
      'settings',
      api.getSystemSettings,
      seconds: 600,
    );
    final servicesStore = domain<List<Service>>(
      'services',
      () async => List.unmodifiable(await api.getAllServices()),
      version: '>=2.4.3',
    );
    final backupsStore = domain<List<Backup>>(
      'backups',
      () async => List.unmodifiable(await api.getBackups()),
      seconds: 120,
      version: '>=2.4.2',
    );
    final configStore = domain(
      'backupConfig',
      api.getBackupsConfiguration,
      seconds: 120,
      version: '>=2.4.2',
    );
    volumesStore = domain<List<ServerDiskVolume>>(
      'volumes',
      () async => List.unmodifiable(await api.getServerDiskVolumes()),
    );
    commands = ServerCommandCoordinator(
      api: api,
      origin: origin,
      currentOrigin: () => isAttached ? origin : null,
      stores: _domains.keys,
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
    for (final store in _domains.keys) {
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
  late final Map<DomainStore<Object>, VersionConstraint> _domains;
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
  Future<bool>? _versionRequest;
  Completer<bool>? _commandVersion;
  Version? _version;
  Object? _versionError;

  Stream<void> get changes => _changes.stream;
  Iterable<DomainStore<Object>> get stores => List.unmodifiable(_domains.keys);
  bool get isAttached => !_disposed && identical(_currentOrigin(), origin);

  Future<ServerMutationResult<T>> mutate<T>({
    required final Iterable<DomainStore<Object>> domains,
    required final Future<ServerMutationResult<T>> Function(ServerApi) send,
    final Iterable<DomainStore<Object>> Function(ServerMutationResult<T>)?
    applyConfirmed,
  }) async {
    final affected = domains.toSet()..forEach(_checkOwner);
    if (isAttached && _version == null) {
      await _prepareCommandVersion();
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
    return completion.result!;
  }

  Future<bool> _prepareCommandVersion() {
    final active = _commandVersion;
    if (active != null) {
      return active.future;
    }
    final completion = _commandVersion = Completer<bool>();
    final discovery = _versionRequest ??= _discoverVersion().whenComplete(
      () => _versionRequest = null,
    );
    unawaited(
      discovery.then((final supported) {
        if (!completion.isCompleted) {
          completion.complete(supported);
          _commandVersion = null;
        }
      }),
    );
    return completion.future;
  }

  CachedValue<T> snapshot<T extends Object>(final DomainStore<T> store) {
    _checkOwner(store);
    return _versionError == null
        ? store.value
        : store.value.copyWith(lastError: () => _versionError);
  }

  void setVersion(final Version version) {
    if (!isAttached) {
      return;
    }
    _version = version;
    _versionError = null;
    for (final entry in _domains.entries) {
      entry.key.setSupport(
        entry.value.allows(version)
            ? DomainSupport.supported
            : DomainSupport.unsupported,
      );
    }
    _changes.add(null);
  }

  void versionUnavailable() {
    if (!isAttached) {
      return;
    }
    _versionError = StateError('Server API version unavailable.');
    _changes.add(null);
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
    if (_version == null || _versionError != null) {
      final supported = await (_versionRequest ??= _discoverVersion()
          .whenComplete(() => _versionRequest = null));
      if (!isAttached) {
        return RefreshResult.disposed;
      }
      if (!supported) {
        return RefreshResult.failed;
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

  Future<bool> _discoverVersion() async {
    try {
      final version = await api.getApiVersion();
      if (!isAttached) {
        return false;
      }
      if (version != null) {
        setVersion(Version.parse(version));
        return true;
      }
    } catch (_) {
      // Do not expose raw API errors to consumers.
    }
    versionUnavailable();
    return false;
  }

  void _checkOwner(final DomainStore<Object> store) {
    if (!_domains.containsKey(store)) {
      throw ArgumentError('Store belongs to another connection.');
    }
  }

  /// Disposes all stores. Requests already sent to the server are not cancelled.
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _commandVersion?.complete(false);
    _commandVersion = null;
    for (final completion in _refreshes.values) {
      completion.complete(RefreshResult.disposed);
    }
    _refreshes.clear();
    commands.dispose();
    jobs.dispose();
    for (final store in _domains.keys) {
      store.dispose();
    }
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    unawaited(_changes.close());
  }
}
