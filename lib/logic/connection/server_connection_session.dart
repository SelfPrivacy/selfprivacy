part of 'server_connection.dart';

class _Rotation {
  _Rotation(this.id);
  final int id;
  final completion = Completer<RotationOutcome>();
  bool sent = false;
}

class _Session {
  _Session({
    required final Server server,
    required this.resources,
    required this.createApiFactory,
    required this.history,
    required this.automaticRotationEnabled,
    required this.now,
  }) : binding = ServerConnectionBinding(server) {
    history.acceptCredential(binding.token);
  }

  ServerConnectionBinding binding;
  final ResourcesModel resources;
  final ConnectionApiFactory createApiFactory;
  final TokenRotationHistory history;
  final bool Function() automaticRotationEnabled;
  final DateTime Function() now;
  late final ServerConnection connection;
  ConnectionRuntime? runtime;
  AppLifecycle? lifecycle;
  int requests = 0;
  Completer<void>? _idle;
  bool _exclusive = false;
  bool _saving = false;
  bool _disposed = false;
  _Rotation? _rotation;

  Server? get server => resources.servers
      .where((final server) => server.uuid == binding.serverId)
      .firstOrNull;
  bool get hasUnsavedToken =>
      history.unsavedToken != null && history.unsavedToken == binding.token;
  bool matches(final Server? server) =>
      !_disposed && (_saving || binding.matches(server));

  ServerApi createApi() {
    final captured = binding;
    return createApiFactory(
      captured,
      (final event) {
        if (_disposed ||
            !identical(captured, binding) ||
            !connection.isAttached) {
          return;
        }
        runtime?.event(event);
        switch (event) {
          case GraphQLTransportEvent.requestStarted:
            requests++;
          case GraphQLTransportEvent.requestFinished:
            requests--;
            if (requests == 0) {
              _idle?.complete();
              _idle = null;
              connection._notify();
            }
          case GraphQLTransportEvent.reachable:
          case GraphQLTransportEvent.protectedSuccess:
          case GraphQLTransportEvent.authFailure:
          case GraphQLTransportEvent.networkFailure:
            break;
        }
      },
      () {
        if (_disposed ||
            !identical(captured, binding) ||
            !captured.matches(server) ||
            hasUnsavedToken ||
            ((_exclusive || !(lifecycle?.isForeground ?? true)) &&
                !connection._isAdmitted)) {
          throw const GraphQLDispatchDeferred();
        }
      },
    );
  }

  void start(
    final AppLifecycle lifecycle,
    final NetworkConnectivitySource connectivity,
  ) {
    if (_disposed || runtime != null || hasUnsavedToken) {
      return;
    }
    this.lifecycle = lifecycle;
    runtime = ConnectionRuntime(
      connection: connection,
      lifecycle: lifecycle,
      connectivity: connectivity,
      operations: connection.operations,
      onChanged: connection._notify,
    )..start();
  }

  RotationState get rotation => RotationState(
    _rotation != null
        ? (_rotation!.sent ? RotationStatus.rotating : RotationStatus.waiting)
        : history.suppressedTokens.contains(binding.token)
        ? RotationStatus.suppressed
        : RotationStatus.idle,
  );

  Future<RotationOutcome> rotateToken() {
    if (_rotation case final pending?) {
      return pending.completion.future;
    }
    if (!connection.isAttached) {
      return Future.value(RotationOutcome.detached);
    }
    if (rotation.status == RotationStatus.suppressed) {
      return Future.value(RotationOutcome.suppressed);
    }
    final queue = connection.operations..pause();
    history.lastAttempt = (binding.token, now());
    final pending = _rotation = _Rotation(
      queue.recordExternal(OperationKind.rotateToken, OperationStatus.queued),
    );
    runtime?.setSuspended(suspended: true);
    connection._notify();
    unawaited(_rotate(pending));
    return pending.completion.future;
  }

  bool cancelRotation() {
    final pending = _rotation;
    if (pending == null || pending.sent) {
      return false;
    }
    _finish(pending, RotationOutcome.cancelled);
    return true;
  }

  Future<void> _rotate(final _Rotation pending) async {
    await connection.operations.whenIdle;
    if (!identical(_rotation, pending)) {
      return;
    }
    _exclusive = true;
    if (requests != 0) {
      await (_idle ??= Completer<void>()).future;
    }
    if (!identical(_rotation, pending)) {
      return;
    }
    if (!connection.isAttached) {
      _finish(pending, RotationOutcome.detached);
      return;
    }
    pending.sent = true;
    connection.operations.updateExternal(pending.id, OperationStatus.running);
    connection._notify();
    String? replacement;
    try {
      final result = await connection._admit(
        connection.api.refreshDeviceApiToken,
      );
      if (!identical(_rotation, pending)) {
        return;
      }
      replacement = result.confirmedSecret;
      if (replacement == null) {
        if (result.outcome == ServerMutationOutcome.rejected) {
          _finish(pending, RotationOutcome.rejected);
          return;
        }
        throw const OperationNotSent();
      }
      final current = server;
      if (!binding.matches(current)) {
        _finish(pending, RotationOutcome.detached);
        return;
      }
      _saving = true;
      final updated = Server(
        uuid: current!.uuid,
        domain: current.domain,
        hostingDetails: current.hostingDetails.copyWith(
          apiToken: replacement,
          apiTokenRotatedAt: now(),
        ),
      );
      await resources.updateServerByUuid(updated);
      _saving = false;
      if (!identical(_rotation, pending)) {
        return;
      }
      if (!ServerConnectionBinding(updated).matches(server)) {
        _finish(pending, RotationOutcome.detached);
        return;
      }
      binding = ServerConnectionBinding(updated);
      connection.api = createApi();
      history.suppressedTokens.clear();
      history.unsavedToken = null;
      _finish(pending, RotationOutcome.succeeded);
    } catch (_) {
      _saving = false;
      history.suppressedTokens.addAll({binding.token, ?replacement});
      if (replacement != null) {
        history.unsavedToken = replacement;
      }
      // ResourcesModel updates memory before the disk write completes.
      if (replacement != null &&
          server?.hostingDetails.apiToken == replacement) {
        binding = ServerConnectionBinding(server!);
      }
      _finish(pending, RotationOutcome.unknown);
    } finally {
      connection._notify();
    }
  }

  void _finish(final _Rotation pending, final RotationOutcome outcome) {
    if (!identical(_rotation, pending)) {
      return;
    }
    _rotation = null;
    _exclusive = false;
    runtime?.setSuspended(suspended: hasUnsavedToken);
    final queue = connection.operations
      ..updateExternal(pending.id, switch (outcome) {
        RotationOutcome.succeeded => OperationStatus.succeeded,
        RotationOutcome.rejected => OperationStatus.rejected,
        RotationOutcome.cancelled => OperationStatus.cancelled,
        RotationOutcome.detached =>
          pending.sent ? OperationStatus.unknown : OperationStatus.notSent,
        _ => OperationStatus.unknown,
      });
    if (outcome != RotationOutcome.succeeded &&
        outcome != RotationOutcome.cancelled) {
      queue.rejectWaiting(OperationReason.rotationFailed);
    }
    pending.completion.complete(outcome);
    queue.resume();
    connection._notify();
  }

  void rotateAutomatically() {
    if (_disposed ||
        runtime == null ||
        _rotation != null ||
        !(lifecycle?.isForeground ?? true) ||
        requests != 0 ||
        connection.reachability != ReachabilityStatus.reachable ||
        !connection.operations.isIdle ||
        !automaticRotationEnabled() ||
        !connection.isAttached) {
      return;
    }
    final current = server;
    if (!binding.matches(current)) {
      return;
    }
    final timestamp = now();
    final details = current!.hostingDetails;
    final previous = history.lastAttempt;
    if (previous != null &&
        previous.$1 == details.apiToken &&
        timestamp.difference(previous.$2) < const Duration(hours: 1)) {
      return;
    }
    if (!TokenRenewalSchedule.fromToken(
      token: details.apiToken,
      rotatedAt: details.apiTokenRotatedAt,
    ).shouldRefreshAutomatically(enabled: true, now: timestamp)) {
      return;
    }
    history.lastAttempt = (details.apiToken, timestamp);
    unawaited(rotateToken());
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    runtime?.dispose();
    if (_rotation case final pending?) {
      _finish(pending, RotationOutcome.detached);
    }
    _idle?.complete();
    _idle = null;
  }
}
