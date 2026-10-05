import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/cache/server_state_cache.dart';
import 'package:selfprivacy/logic/connection/connection_runtime.dart';
import 'package:selfprivacy/logic/connection/lifecycle/app_lifecycle.dart';
import 'package:selfprivacy/logic/connection/lifecycle/managed_subscription.dart';
import 'package:selfprivacy/logic/connection/lifecycle/network_connectivity.dart';
import 'package:selfprivacy/logic/connection/lifecycle/reachability.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_connection_binding.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
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
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';
import 'package:selfprivacy/logic/models/token_renewal_schedule.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

part 'server_connection_session.dart';

typedef ConnectionApiFactory =
    ServerApi Function(
      ServerConnectionBinding binding,
      void Function(GraphQLTransportEvent) onEvent,
      void Function() beforeRequest,
    );

/// Owns domain stores and coordinates commands for one server connection.
class ServerConnection {
  ServerConnection({
    required this.api,
    required this.serverId,
    required final bool Function() isAttached,
    final DateTime Function()? now,
    final CacheTimerFactory? createTimer,
  }) : _isAttached = isAttached {
    operations = OperationQueue(serverId: serverId, now: now);
    cache = ServerStateCache(
      api: () => api,
      now: now,
      createTimer: createTimer,
    );
    final deviceStore = cache.devices;
    final jobsStore = cache.serverJobs;
    final usersStore = cache.users;
    final settingsStore = cache.settings;
    final servicesStore = cache.services;
    final backupsStore = cache.backups;
    final configStore = cache.backupConfig;
    final volumesStore = cache.volumes;
    commands = ServerCommandCoordinator(
      api: () => api,
      isAttached: () => this.isAttached,
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
          if (this.isAttached) {
            _notify();
          }
        }),
      );
    }
  }

  factory ServerConnection.connect({
    required final Server server,
    required final ResourcesModel resources,
    required final ConnectionApiFactory createApi,
    required final TokenRotationHistory rotationHistory,
    required final bool Function() automaticRotationEnabled,
    required final DateTime Function() now,
  }) {
    final session = _Session(
      server: server,
      resources: resources,
      createApiFactory: createApi,
      history: rotationHistory,
      automaticRotationEnabled: automaticRotationEnabled,
      now: now,
    );
    final connection = ServerConnection(
      api: session.createApi(),
      serverId: server.uuid,
      isAttached: () => session.matches(session.server),
      now: now,
    );
    session.connection = connection;
    connection._session = session;
    connection._subscriptions.add(
      connection.operations.changes.listen((_) => connection._notify()),
    );
    return connection;
  }

  ServerApi api;
  final String serverId;
  final bool Function() _isAttached;
  bool get _canDispatch => !(_session?.hasUnsavedToken ?? false);
  static final _admissionKey = Object();
  late final OperationQueue operations;
  _Session? _session;
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

  Stream<void> get changes => _changes.stream;
  bool get isAttached => !_disposed && _isAttached();
  bool get _isAdmitted => identical(Zone.current[_admissionKey], this);

  Future<T> _admit<T>(final Future<T> Function() action) =>
      runZoned(action, zoneValues: {_admissionKey: this});

  Future<T?> run<T>(
    final OperationKind kind,
    final Future<T> Function(ServerConnection) action, {
    final void Function()? onNotSent,
  }) async {
    if (_isAdmitted) {
      _checkDispatch();
      return action(this);
    }
    final result = await submit(kind, action).result;
    if (result.status == OperationStatus.notSent ||
        result.status == OperationStatus.cancelled) {
      onNotSent?.call();
    }
    return result.value;
  }

  OperationHandle<T> submit<T>(
    final OperationKind kind,
    final Future<T> Function(ServerConnection) action, {
    final OperationReport Function(T)? describe,
  }) => operations.submit(kind, () {
    _checkDispatch();
    return _admit(() => action(this));
  }, describe: describe ?? (_) => OperationExecution.current!.report);

  void _checkDispatch() {
    if (!isAttached || !_canDispatch) {
      throw const OperationNotSent();
    }
  }

  bool matches(final Server? server) => _session?.matches(server) ?? false;
  ReachabilityStatus? get reachability =>
      _session?.runtime?.reachability.current;
  bool get isForeground => _session?.lifecycle?.isForeground ?? true;
  bool get canRead =>
      isAttached &&
      isForeground &&
      _session?._rotation == null &&
      _canDispatch &&
      (_session?.runtime == null ||
          reachability == ReachabilityStatus.reachable);
  RotationState get rotation =>
      _session?.rotation ?? const RotationState(RotationStatus.idle);
  Future<RotationOutcome> rotateToken() =>
      _session?.rotateToken() ?? Future.value(RotationOutcome.detached);
  bool cancelRotation() => _session?.cancelRotation() ?? false;

  void start({
    required final AppLifecycle lifecycle,
    required final NetworkConnectivitySource connectivity,
  }) {
    _session?.start(lifecycle, connectivity);
  }

  Future<T> read<T>(final Future<T> Function(ServerConnection) fetch) async {
    if (!canRead) {
      throw const GraphQLDispatchDeferred();
    }
    final value = await fetch(this);
    if (!isAttached) {
      throw const GraphQLDispatchDeferred();
    }
    return value;
  }

  Stream<ServerLogEntry> logs() => managedSubscription(
    changes: changes,
    identity: () => this,
    available: () => _session?.runtime?.canStream ?? false,
    detached: () => !isAttached,
    open: () => api.getServerLogsStream(),
  );

  void _notify() {
    if (_disposed) {
      return;
    }
    _changes.add(null);
    scheduleMicrotask(() => _session?.rotateAutomatically());
  }

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
    _changes.add(null);
    _session?.dispose();
    operations.dispose();
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
