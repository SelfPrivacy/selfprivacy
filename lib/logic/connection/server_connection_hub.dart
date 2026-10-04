import 'dart:async';

import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/connection_runtime.dart';
import 'package:selfprivacy/logic/connection/lifecycle/app_lifecycle.dart';
import 'package:selfprivacy/logic/connection/lifecycle/managed_subscription.dart';
import 'package:selfprivacy/logic/connection/lifecycle/network_connectivity.dart';
import 'package:selfprivacy/logic/connection/lifecycle/reachability.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_connection_binding.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/operation_execution.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';
import 'package:selfprivacy/logic/models/token_renewal_schedule.dart';

enum RotationStatus { idle, waiting, rotating, suppressed }

enum RotationOutcome {
  succeeded,
  rejected,
  unknown,
  suppressed,
  cancelled,
  detached,
}

class RotationState {
  const RotationState(this.status);
  final RotationStatus status;
  bool get canCancel => status == RotationStatus.waiting;
}

typedef HubApiFactory =
    ServerApi Function(
      ServerConnectionBinding binding,
      void Function(GraphQLTransportEvent) onEvent,
      void Function() beforeRequest,
    );

class _Session {
  _Session(this.binding);
  final ServerConnectionBinding binding;
  late final ServerConnection connection;
  StreamSubscription<void>? subscription;
  int requests = 0;
  Completer<void>? idle;
  bool exclusive = false;
  ConnectionRuntime? runtime;

  Future<void> get whenIdle =>
      requests == 0 ? Future.value() : (idle ??= Completer<void>()).future;

  void dispose() {
    runtime?.dispose();
    connection.dispose();
    unawaited(subscription?.cancel());
    idle?.complete();
    idle = null;
  }
}

class _Rotation {
  _Rotation(this.session, this.queue, this.id);
  final _Session session;
  final OperationQueue queue;
  final int id;
  final completion = Completer<RotationOutcome>();
  bool sent = false;
}

class ServerConnectionHub {
  ServerConnectionHub({
    required final ResourcesModel resourcesModel,
    final HubApiFactory? createApi,
    final Server? Function()? selectServer,
    final bool Function()? automaticRotationEnabled,
    final DateTime Function()? now,
  }) : _resources = resourcesModel,
       _selectServer =
           selectServer ?? (() => resourcesModel.servers.firstOrNull),
       _createApi = createApi ?? _productionApi,
       _now = now ?? DateTime.now,
       _automaticRotationEnabled =
           automaticRotationEnabled ??
           (() =>
               getIt.isRegistered<DeveloperSettingsModel>() &&
               getIt<DeveloperSettingsModel>().automaticGraphqlTokenRefresh) {
    _resourcesSubscription = resourcesModel.statusStream.listen(
      (_) => _synchronize(),
    );
    _synchronize();
  }

  static ServerApi _productionApi(
    final ServerConnectionBinding binding,
    final void Function(GraphQLTransportEvent) onEvent,
    final void Function() beforeRequest,
  ) => ServerApi(
    transport: createGraphQLTransport(
      domainProvider: () => binding.domain,
      tokenProvider: () => binding.token,
      onEvent: onEvent,
      beforeRequest: beforeRequest,
    ),
  );

  static final _admissionKey = Object();
  final ResourcesModel _resources;
  final Server? Function() _selectServer;
  final HubApiFactory _createApi;
  final DateTime Function() _now;
  final bool Function() _automaticRotationEnabled;
  late final StreamSubscription<Object?> _resourcesSubscription;
  final _queues = <String, OperationQueue>{};
  final _suppressed = <String, Set<String?>>{};
  final _unsaved = <String, String>{};
  final _changes = StreamController<void>.broadcast();
  final _queueSubscriptions = <StreamSubscription<Object?>>[];
  _Session? _session;
  _Rotation? _rotation;
  bool _disposed = false;
  bool _cleared = false;
  bool _savingRotation = false;
  int _resetRevision = 0;
  AppLifecycle? _lifecycle;
  late NetworkConnectivitySource _connectivity;
  bool _ownsLifecycle = false;
  bool _started = false;
  final _rotationAttempts = <String, (String?, DateTime)>{};

  ReachabilityStatus? get reachability =>
      _session?.runtime?.reachability.current;
  bool get isForeground => _lifecycle?.isForeground ?? true;
  bool get canRead =>
      isForeground &&
      _rotation == null &&
      active != null &&
      _unsaved[_session!.binding.serverId] != _session!.binding.token &&
      (!_started || reachability == ReachabilityStatus.reachable);

  Future<T> read<T>(final Future<T> Function(ServerConnection) fetch) async {
    final connection = _synchronize()?.connection;
    if (!canRead || connection == null) {
      throw const GraphQLDispatchDeferred();
    }
    final value = await fetch(connection);
    if (!connection.isAttached) {
      throw const GraphQLDispatchDeferred();
    }
    return value;
  }

  Stream<ServerLogEntry> logs() {
    final connection = _synchronize()?.connection;
    final revision = _resetRevision;
    return managedSubscription(
      changes: changes,
      identity: () => active,
      available: () => _session?.runtime?.canStream ?? false,
      detached: () =>
          _disposed || connection == null || revision != _resetRevision,
      open: () => active!.api.getServerLogsStream(),
    );
  }

  void start({
    final AppLifecycle? lifecycle,
    final NetworkConnectivitySource? connectivity,
  }) {
    if (_disposed || _started) {
      return;
    }
    _started = true;
    _ownsLifecycle = lifecycle == null;
    _lifecycle = lifecycle ?? AppLifecycle();
    _connectivity = connectivity ?? OsNetworkConnectivity();
    final session = _synchronize();
    if (session != null) {
      _startRuntime(session);
    }
  }

  void _startRuntime(final _Session session) {
    if (!_started ||
        session.runtime != null ||
        _unsaved[session.binding.serverId] == session.binding.token) {
      return;
    }
    session.runtime = ConnectionRuntime(
      connection: session.connection,
      lifecycle: _lifecycle!,
      connectivity: _connectivity,
      operations: operationsFor(session.binding.serverId),
      onChanged: _notify,
    )..start();
  }

  Stream<void> get changes => _changes.stream;
  ServerConnection? get active =>
      (_session?.connection.isAttached ?? false) ? _session!.connection : null;
  ServerConnection? get admittedConnection {
    final session = Zone.current[_admissionKey] as _Session?;
    return session == null
        ? active
        : session.connection.isAttached
        ? session.connection
        : null;
  }

  Future<T?> run<T>(
    final OperationKind kind,
    final Future<T> Function(ServerConnection) action, {
    final ServerStateOrigin? origin,
    final void Function()? onNotSent,
  }) async {
    if (Zone.current[_admissionKey] != null) {
      final connection = admittedConnection;
      if (connection == null ||
          (origin != null &&
              !identical(origin.continuity, connection.origin.continuity))) {
        throw const OperationNotSent();
      }
      return action(connection);
    }
    final result = await submit(kind, action, origin: origin).completion;
    if (result.status == OperationStatus.notSent ||
        result.status == OperationStatus.cancelled) {
      onNotSent?.call();
    }
    return result.value;
  }

  RotationState get rotation {
    final pending = _rotation;
    if (pending != null) {
      return RotationState(
        pending.sent ? RotationStatus.rotating : RotationStatus.waiting,
      );
    }
    final binding = _session?.binding;
    return RotationState(
      binding != null &&
              (_suppressed[binding.serverId]?.contains(binding.token) ?? false)
          ? RotationStatus.suppressed
          : RotationStatus.idle,
    );
  }

  OperationQueue operationsFor(final String serverId) =>
      _queues.putIfAbsent(serverId, () {
        final queue = OperationQueue(serverId: serverId, now: _now);
        _queueSubscriptions.add(queue.changes.listen((_) => _notify()));
        return queue;
      });

  OperationHandle<T> submit<T>(
    final OperationKind kind,
    final Future<T> Function(ServerConnection) action, {
    final ServerStateOrigin? origin,
    final OperationReport Function(T)? describe,
  }) {
    final session = _synchronize();
    final serverId = session?.binding.serverId ?? '';
    final execution = OperationExecution();
    return operationsFor(serverId).submit(kind, () {
      final admitted = _session;
      if (session == null ||
          admitted == null ||
          (origin != null &&
              !identical(
                origin.continuity,
                admitted.connection.origin.continuity,
              )) ||
          !identical(
            session.connection.origin.continuity,
            admitted.connection.origin.continuity,
          ) ||
          !admitted.binding.matches(_selectServer()) ||
          _unsaved[serverId] == admitted.binding.token) {
        throw const OperationNotSent();
      }
      return runZoned(
        () => action(admitted.connection),
        zoneValues: {
          _admissionKey: admitted,
          OperationExecution.zoneKey: execution,
        },
      );
    }, describe: describe ?? (_) => execution.report);
  }

  _Session? _synchronize() {
    if (_disposed || _cleared) {
      return null;
    }
    if (_savingRotation) {
      return _session;
    }
    final server = _selectServer();
    if (_session?.binding.matches(server) ?? server == null) {
      return _session;
    }
    _detach();
    if (server != null) {
      if (!(_suppressed[server.uuid]?.contains(
            server.hostingDetails.apiToken,
          ) ??
          true)) {
        _suppressed.remove(server.uuid);
        _unsaved.remove(server.uuid);
      }
      _session = _createSession(server);
      _startRuntime(_session!);
    }
    _notify();
    return _session;
  }

  _Session _createSession(
    final Server server, {
    final ConnectionContinuity? continuity,
  }) {
    final session = _Session(ServerConnectionBinding(server));
    final origin = ServerStateOrigin(server.uuid, continuity: continuity);
    session
      ..connection = ServerConnection(
        api: _createApi(
          session.binding,
          (final event) => _event(session, event),
          () {
            if (!identical(_session, session) ||
                !session.binding.matches(_selectServer()) ||
                _unsaved[session.binding.serverId] == session.binding.token ||
                ((session.exclusive || !isForeground) &&
                    !identical(Zone.current[_admissionKey], session))) {
              throw const GraphQLDispatchDeferred();
            }
          },
        ),
        origin: origin,
        now: _now,
        currentOrigin: () =>
            !_disposed &&
                identical(_session, session) &&
                (session.binding.matches(_selectServer()) || _savingRotation)
            ? origin
            : null,
      )
      ..subscription = session.connection.changes.listen((_) => _notify());
    return session;
  }

  void _event(final _Session session, final GraphQLTransportEvent event) {
    if (!identical(session, _session)) {
      return;
    }
    session.runtime?.event(event);
    switch (event) {
      case GraphQLTransportEvent.requestStarted:
        session.requests++;
      case GraphQLTransportEvent.requestFinished:
        session.requests--;
        if (session.requests == 0) {
          session.idle?.complete();
          session.idle = null;
          _notify();
        }
      case GraphQLTransportEvent.reachable:
      case GraphQLTransportEvent.protectedSuccess:
      case GraphQLTransportEvent.authFailure:
      case GraphQLTransportEvent.networkFailure:
        break;
    }
  }

  Future<RotationOutcome> rotateToken() {
    if (_rotation case final pending?) {
      return pending.completion.future;
    }
    final session = _synchronize();
    if (session == null) {
      return Future.value(RotationOutcome.detached);
    }
    if (rotation.status == RotationStatus.suppressed) {
      return Future.value(RotationOutcome.suppressed);
    }
    final queue = operationsFor(session.binding.serverId)..pause();
    _rotationAttempts[session.binding.serverId] = (
      session.binding.token,
      _now(),
    );
    final pending = _rotation = _Rotation(
      session,
      queue,
      queue.recordExternal(OperationKind.rotateToken, OperationStatus.queued),
    );
    session.runtime?.setSuspended(suspended: true);
    _notify();
    unawaited(_rotate(pending));
    return pending.completion.future;
  }

  bool cancelRotation() {
    final pending = _rotation;
    if (pending == null || pending.sent) {
      return false;
    }
    _finishRotation(pending, RotationOutcome.cancelled);
    return true;
  }

  Future<void> _rotate(final _Rotation pending) async {
    final session = pending.session;
    await pending.queue.whenIdle;
    if (!identical(_rotation, pending)) {
      return;
    }
    session.exclusive = true;
    await session.whenIdle;
    if (!identical(_rotation, pending)) {
      return;
    }
    if (!session.binding.matches(_selectServer())) {
      _synchronize();
      return;
    }
    pending.sent = true;
    pending.queue.updateExternal(pending.id, OperationStatus.running);
    _notify();
    String? replacement;
    try {
      final result = await runZoned(
        session.connection.api.refreshDeviceApiToken,
        zoneValues: {_admissionKey: session},
      );
      if (!identical(_rotation, pending)) {
        return;
      }
      replacement = result.confirmedSecret;
      if (replacement == null) {
        if (result.outcome == ServerMutationOutcome.rejected) {
          _finishRotation(pending, RotationOutcome.rejected);
          return;
        }
        throw const OperationNotSent();
      }
      final current = _selectServer();
      if (!session.binding.matches(current)) {
        _synchronize();
        return;
      }
      _savingRotation = true;
      final updated = Server(
        uuid: current!.uuid,
        domain: current.domain,
        hostingDetails: current.hostingDetails.copyWith(
          apiToken: replacement,
          apiTokenRotatedAt: _now(),
        ),
      );
      await _resources.updateServerByUuid(updated);
      _savingRotation = false;
      if (!identical(_rotation, pending)) {
        _synchronize();
        return;
      }
      if (!ServerConnectionBinding(updated).matches(_selectServer())) {
        _synchronize();
        return;
      }
      final next = _createSession(
        updated,
        continuity: session.connection.origin.continuity,
      );
      _session = next;
      next.connection.restoreFrom(session.connection);
      session.dispose();
      _startRuntime(next);
      _suppressed.remove(updated.uuid);
      _unsaved.remove(updated.uuid);
      _finishRotation(pending, RotationOutcome.succeeded);
    } catch (_) {
      _savingRotation = false;
      _suppressed[session.binding.serverId] = {
        session.binding.token,
        ?replacement,
      };
      if (replacement != null) {
        _unsaved[session.binding.serverId] = replacement;
      }
      if (!identical(_rotation, pending)) {
        _synchronize();
        _notify();
        return;
      }
      _finishRotation(pending, RotationOutcome.unknown);
      _synchronize();
    }
  }

  void _finishRotation(final _Rotation pending, final RotationOutcome outcome) {
    if (!identical(_rotation, pending)) {
      return;
    }
    _rotation = null;
    pending.session.exclusive = false;
    if (identical(_session, pending.session)) {
      pending.session.runtime?.setSuspended(suspended: false);
    }
    pending.queue.updateExternal(pending.id, switch (outcome) {
      RotationOutcome.succeeded => OperationStatus.succeeded,
      RotationOutcome.rejected => OperationStatus.rejected,
      RotationOutcome.cancelled => OperationStatus.cancelled,
      RotationOutcome.detached =>
        pending.sent ? OperationStatus.unknown : OperationStatus.notSent,
      _ => OperationStatus.unknown,
    });
    if (outcome != RotationOutcome.succeeded &&
        outcome != RotationOutcome.cancelled) {
      pending.queue.rejectWaiting(OperationReason.rotationFailed);
    }
    pending.completion.complete(outcome);
    pending.queue.resume();
    _notify();
  }

  void _detach() {
    _resetRevision++;
    final previous = _session;
    _session = null;
    if (_rotation case final pending?) {
      _finishRotation(pending, RotationOutcome.detached);
    }
    if (previous != null) {
      operationsFor(previous.binding.serverId).detach();
      previous.dispose();
    }
  }

  void clear() {
    _cleared = true;
    _detach();
    _notify();
  }

  void resume() {
    _cleared = false;
    _synchronize();
  }

  void _notify() {
    if (!_disposed) {
      _changes.add(null);
      scheduleMicrotask(_rotateAutomatically);
    }
  }

  void _rotateAutomatically() {
    final session = _session;
    if (_disposed ||
        !_started ||
        _rotation != null ||
        session == null ||
        !isForeground ||
        session.requests != 0 ||
        reachability != ReachabilityStatus.reachable ||
        !operationsFor(session.binding.serverId).isIdle ||
        !_automaticRotationEnabled()) {
      return;
    }
    final server = _selectServer();
    if (!session.binding.matches(server)) {
      return;
    }
    final now = _now();
    final details = server!.hostingDetails;
    final previous = _rotationAttempts[server.uuid];
    if (previous != null &&
        previous.$1 == details.apiToken &&
        now.difference(previous.$2) < const Duration(hours: 1)) {
      return;
    }
    if (!TokenRenewalSchedule.fromToken(
      token: details.apiToken,
      rotatedAt: details.apiTokenRotatedAt,
    ).shouldRefreshAutomatically(enabled: true, now: now)) {
      return;
    }
    _rotationAttempts[server.uuid] = (details.apiToken, now);
    unawaited(rotateToken());
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _detach();
    if (_ownsLifecycle) {
      _lifecycle?.dispose();
    }
    for (final queue in _queues.values) {
      queue.dispose();
    }
    for (final subscription in _queueSubscriptions) {
      unawaited(subscription.cancel());
    }
    unawaited(_resourcesSubscription.cancel());
    unawaited(_changes.close());
  }
}
