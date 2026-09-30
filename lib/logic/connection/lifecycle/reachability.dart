import 'dart:async';
import 'dart:math';

import 'package:selfprivacy/logic/connection/lifecycle/network_connectivity.dart';

enum ReachabilityStatus {
  checking,
  reachable,
  serverUnreachable,
  noLocalNetwork,
  unauthorized,
}

typedef ReachabilityTimerFactory =
    Timer Function(Duration delay, void Function() callback);

class Reachability {
  Reachability({
    required final NetworkConnectivitySource connectivity,
    required final Future<bool> Function() probe,
    final ReachabilityTimerFactory? createTimer,
    final double Function()? random,
  }) : _connectivity = connectivity,
       _probe = probe,
       _createTimer = createTimer ?? Timer.new,
       _random = random ?? Random().nextDouble;

  final NetworkConnectivitySource _connectivity;
  final Future<bool> Function() _probe;
  final ReachabilityTimerFactory _createTimer;
  final double Function() _random;
  final _changes = StreamController<ReachabilityStatus>.broadcast();
  ReachabilityStatus _current = ReachabilityStatus.checking;
  ReachabilityStatus get current => _current;

  Stream<ReachabilityStatus> get stream => _changes.stream;

  StreamSubscription<NetworkConnectivity>? _subscription;
  Timer? _retry;
  Timer? _timeout;
  Completer<void>? _pending;
  bool _started = false;
  bool _disposed = false;
  bool _offline = false;
  bool _paused = false;
  bool get isPaused => _paused;
  int _networkRevision = 0;
  int _failures = 0;
  int _retrySeconds = 5;

  void start({final bool paused = false}) {
    _ensureOpen();
    if (_started) {
      return;
    }
    _started = true;
    _paused = paused;
    _subscription = _connectivity.changes.listen(
      _networkChanged,
      onError: (final Object error) =>
          _networkChanged(NetworkConnectivity.unknown),
    );
    if (!_paused) {
      unawaited(_readInitialNetwork(_networkRevision));
    }
  }

  void pause() {
    _ensureStarted();
    if (_paused) {
      return;
    }
    _paused = true;
    _networkRevision++;
    _cancelWork();
  }

  void resume() {
    _ensureStarted();
    if (!_paused) {
      return;
    }
    _paused = false;
    _networkRevision++;
    _failures = 0;
    _retrySeconds = 5;
    if (_current != ReachabilityStatus.unauthorized) {
      _setStatus(ReachabilityStatus.checking);
    }
    unawaited(_readInitialNetwork(_networkRevision));
  }

  Future<void> _readInitialNetwork(final int revision) async {
    NetworkConnectivity network;
    try {
      network = await _connectivity.check();
    } catch (_) {
      network = NetworkConnectivity.unknown;
    }
    if (!_disposed && revision == _networkRevision) {
      _networkChanged(network);
    }
  }

  void _networkChanged(final NetworkConnectivity network) {
    if (_disposed) {
      return;
    }
    _networkRevision++;
    final wasOffline = _offline;
    _offline = network == NetworkConnectivity.offline;
    if (_paused || _current == ReachabilityStatus.unauthorized) {
      return;
    }
    if (_offline) {
      _cancelWork();
      _failures = 0;
      _setStatus(ReachabilityStatus.noLocalNetwork);
    } else if (wasOffline || _current == ReachabilityStatus.checking) {
      _setStatus(ReachabilityStatus.checking);
      unawaited(probe());
    }
  }

  Future<void> probe() {
    _ensureStarted();
    if (_paused || _offline || _current == ReachabilityStatus.unauthorized) {
      return Future<void>.value();
    }
    final pending = _pending;
    if (pending != null) {
      return pending.future;
    }
    _retry?.cancel();
    _retry = null;
    final completion = Completer<void>();
    _pending = completion;
    _timeout = _createTimer(
      const Duration(seconds: 10),
      () => _finishProbe(completion, false),
    );
    unawaited(_runProbe(completion));
    return completion.future;
  }

  Future<void> _runProbe(final Completer<void> completion) async {
    var success = false;
    try {
      success = await _probe();
    } catch (_) {
      success = false;
    }
    _finishProbe(completion, success);
  }

  void _finishProbe(final Completer<void> completion, final bool success) {
    if (_disposed || !identical(_pending, completion)) {
      return;
    }
    _timeout?.cancel();
    _timeout = null;
    _pending = null;
    if (success) {
      reportSuccess();
    } else {
      _setStatus(ReachabilityStatus.serverUnreachable);
      _scheduleRetry();
    }
    completion.complete();
  }

  void reportSuccess() {
    _ensureStarted();
    _networkRevision++;
    _offline = false;
    _failures = 0;
    _retrySeconds = 5;
    _cancelWork();
    if (_current != ReachabilityStatus.unauthorized) {
      _setStatus(ReachabilityStatus.reachable);
    }
  }

  void reportProtectedSuccess() {
    reportSuccess();
    _setStatus(ReachabilityStatus.reachable);
  }

  void reportNetworkFailure() {
    _ensureStarted();
    if (_paused || _offline || _current == ReachabilityStatus.unauthorized) {
      return;
    }
    _failures = min(_failures + 1, 2);
    if (_failures == 2) {
      _setStatus(ReachabilityStatus.serverUnreachable);
      _scheduleRetry();
    }
  }

  void reportAuthFailure() {
    _ensureStarted();
    _cancelWork();
    _setStatus(ReachabilityStatus.unauthorized);
  }

  void reportWsState({required final bool alive}) {
    _ensureStarted();
    if (alive) {
      reportSuccess();
    } else if (_retry == null) {
      unawaited(probe());
    }
  }

  void _scheduleRetry() {
    if (_paused || _retry != null || _pending != null) {
      return;
    }
    final milliseconds = min(
      120000,
      (_retrySeconds * 1000 * (0.8 + 0.4 * _random())).round(),
    );
    _retrySeconds = min(_retrySeconds * 2, 120);
    _retry = _createTimer(Duration(milliseconds: milliseconds), () {
      _retry = null;
      unawaited(probe());
    });
  }

  void _setStatus(final ReachabilityStatus status) {
    if (_current != status) {
      _current = status;
      _changes.add(status);
    }
  }

  void _cancelWork() {
    _retry?.cancel();
    _retry = null;
    _timeout?.cancel();
    _timeout = null;
    _pending?.complete();
    _pending = null;
  }

  void _ensureOpen() {
    if (_disposed) {
      throw StateError('Reachability is disposed');
    }
  }

  void _ensureStarted() {
    _ensureOpen();
    if (!_started) {
      throw StateError('Reachability has not started');
    }
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _cancelWork();
    unawaited(_subscription?.cancel());
    unawaited(_changes.close());
  }
}
