import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/connection/lifecycle/network_connectivity.dart';
import 'package:selfprivacy/logic/connection/lifecycle/reachability.dart';

class _Network implements NetworkConnectivitySource {
  final events = StreamController<NetworkConnectivity>();
  Future<NetworkConnectivity>? initial;
  @override
  Future<NetworkConnectivity> check() =>
      initial ?? Future.value(NetworkConnectivity.available);
  @override
  Stream<NetworkConnectivity> get changes => events.stream;
}

void main() {
  late _Network network;
  late Reachability reachability;
  late int calls;
  late Future<bool> Function() response;

  void initialize() {
    network = _Network();
    calls = 0;
    response = () async => true;
    reachability = Reachability(
      connectivity: network,
      probe: () {
        calls++;
        return response();
      },
      random: () => 0.5,
    );
  }

  void testReachability(
    final String description,
    final WidgetTesterCallback body,
  ) {
    testWidgets(description, (final tester) async {
      initialize();
      try {
        await body(tester);
      } finally {
        reachability.dispose();
        unawaited(network.events.close());
      }
    });
  }

  test(
    'explicit start probes once and emits distinct non-replayed states',
    () async {
      initialize();
      addTearDown(() {
        reachability.dispose();
        return network.events.close();
      });
      expect(reachability.current, ReachabilityStatus.checking);
      expect(calls, 0);
      final states = <ReachabilityStatus>[];
      final subscription = reachability.stream.listen(states.add);
      reachability
        ..start()
        ..start();
      await Future<void>.delayed(Duration.zero);
      reachability.reportSuccess();
      await Future<void>.delayed(Duration.zero);
      expect(calls, 1);
      expect(states, [ReachabilityStatus.reachable]);
      await subscription.cancel();
      reachability.dispose();
    },
  );

  testReachability(
    'two failures establish an outage and success resets the threshold',
    (final tester) async {
      reachability.start();
      await tester.pump();
      reachability.reportNetworkFailure();
      expect(reachability.current, ReachabilityStatus.reachable);
      reachability
        ..reportSuccess()
        ..reportNetworkFailure();
      expect(reachability.current, ReachabilityStatus.reachable);
      reachability.reportNetworkFailure();
      expect(reachability.current, ReachabilityStatus.serverUnreachable);
      reachability.reportSuccess();
      await tester.pump(const Duration(minutes: 3));
      expect(calls, 1);
      reachability.dispose();
    },
  );

  testReachability(
    'failed probes back off from completion and reset after success',
    (final tester) async {
      response = () async => false;
      reachability.start();
      await tester.pump();
      expect(reachability.current, ReachabilityStatus.serverUnreachable);
      for (final seconds in [5, 10, 20, 40, 80, 120, 120]) {
        final before = calls;
        reachability.reportWsState(alive: false);
        await tester.pump(Duration(seconds: seconds - 1));
        expect(calls, before);
        await tester.pump(const Duration(seconds: 1));
        expect(calls, before + 1);
      }
      reachability.reportSuccess();
      await reachability.probe();
      final before = calls;
      await tester.pump(const Duration(seconds: 5));
      expect(calls, before + 1);
      reachability.dispose();
    },
  );

  testReachability('offline gates requests and reconnect probes immediately', (
    final tester,
  ) async {
    network.initial = Future.value(NetworkConnectivity.offline);
    reachability.start();
    await tester.pump();
    expect(reachability.current, ReachabilityStatus.noLocalNetwork);
    await reachability.probe();
    reachability.reportWsState(alive: false);
    await tester.pump(const Duration(minutes: 5));
    expect(calls, 0);
    network.events.add(NetworkConnectivity.available);
    await tester.pump();
    expect(calls, 1);
    expect(reachability.current, ReachabilityStatus.reachable);
    reachability.dispose();
  });

  testReachability('new OS event supersedes the initial check', (
    final tester,
  ) async {
    final initial = Completer<NetworkConnectivity>();
    network.initial = initial.future;
    reachability.start();
    network.events.add(NetworkConnectivity.available);
    await tester.pump();
    initial.complete(NetworkConnectivity.offline);
    await tester.pump();
    expect(reachability.current, ReachabilityStatus.reachable);
    expect(calls, 1);
    reachability.dispose();
  });

  testReachability('unknown network and plugin errors allow probing', (
    final tester,
  ) async {
    network.initial = Future.error(StateError('plugin unavailable'));
    reachability.start();
    await tester.pump();
    expect(calls, 1);
    network.events.add(NetworkConnectivity.offline);
    await tester.pump();
    network.events.addError(StateError('plugin unavailable'));
    await tester.pump();
    expect(calls, 2);
    expect(reachability.current, ReachabilityStatus.reachable);
    reachability.dispose();
  });

  testReachability('real success overrides offline until a newer OS event', (
    final tester,
  ) async {
    network.initial = Future.value(NetworkConnectivity.offline);
    reachability.start();
    await tester.pump();
    reachability.reportSuccess();
    expect(reachability.current, ReachabilityStatus.reachable);
    await reachability.probe();
    expect(calls, 1);
    network.events.add(NetworkConnectivity.offline);
    await tester.pump();
    expect(reachability.current, ReachabilityStatus.noLocalNetwork);
    reachability.dispose();
  });

  testReachability('unauthorized stops work until protected success', (
    final tester,
  ) async {
    reachability.start();
    await tester.pump();
    reachability
      ..reportAuthFailure()
      ..reportSuccess()
      ..reportWsState(alive: true)
      ..reportNetworkFailure();
    network.events.add(NetworkConnectivity.offline);
    network.events.add(NetworkConnectivity.available);
    await tester.pump();
    await reachability.probe();
    await tester.pump(const Duration(minutes: 5));
    expect(reachability.current, ReachabilityStatus.unauthorized);
    expect(calls, 1);
    reachability.reportProtectedSuccess();
    expect(reachability.current, ReachabilityStatus.reachable);
    await reachability.probe();
    expect(calls, 2);
    reachability.dispose();
  });

  testReachability('WebSocket loss probes without declaring failure', (
    final tester,
  ) async {
    reachability.start();
    await tester.pump();
    final pending = Completer<bool>();
    response = () => pending.future;
    reachability
      ..reportWsState(alive: false)
      ..reportWsState(alive: false);
    expect(calls, 2);
    expect(reachability.current, ReachabilityStatus.reachable);
    final first = reachability.probe();
    expect(reachability.probe(), same(first));
    pending.complete(false);
    await first;
    expect(reachability.current, ReachabilityStatus.serverUnreachable);
    reachability.reportWsState(alive: true);
    expect(reachability.current, ReachabilityStatus.reachable);
    reachability.dispose();
  });

  testReachability('timeout ignores late success and schedules retry', (
    final tester,
  ) async {
    final pending = Completer<bool>();
    response = () => pending.future;
    reachability.start();
    await tester.pump();
    final completion = reachability.probe();
    await tester.pump(const Duration(seconds: 10));
    await completion;
    expect(reachability.current, ReachabilityStatus.serverUnreachable);
    pending.complete(true);
    await tester.pump();
    expect(reachability.current, ReachabilityStatus.serverUnreachable);
    response = () async => true;
    await tester.pump(const Duration(seconds: 5));
    expect(reachability.current, ReachabilityStatus.reachable);
    reachability.dispose();
  });

  for (final event in ['success', 'auth', 'offline', 'dispose']) {
    testReachability('$event supersedes an active probe and resolves waiters', (
      final tester,
    ) async {
      final pending = Completer<bool>();
      response = () => pending.future;
      reachability.start();
      await tester.pump();
      final completion = reachability.probe();
      switch (event) {
        case 'success':
          reachability.reportSuccess();
        case 'auth':
          reachability.reportAuthFailure();
        case 'offline':
          network.events.add(NetworkConnectivity.offline);
        case 'dispose':
          reachability.dispose();
      }
      await tester.pump();
      await completion;
      final expected = reachability.current;
      pending.completeError(StateError('late failure'));
      await tester.pump(const Duration(minutes: 5));
      expect(reachability.current, expected);
      expect(calls, 1);
      reachability.dispose();
    });
  }

  for (final random in [0.0, 1.0]) {
    testReachability('jitter bounds and maximum delay at $random', (
      final tester,
    ) async {
      reachability.dispose();
      final delays = <Duration>[];
      reachability = Reachability(
        connectivity: network,
        probe: () async => false,
        random: () => random,
        createTimer: (final delay, final callback) {
          delays.add(delay);
          return Timer(delay, callback);
        },
      )..start();
      await tester.pump();
      for (final seconds in [5, 10, 20, 40, 80, 120, 120]) {
        final milliseconds = (seconds * 1000 * (0.8 + random * 0.4))
            .round()
            .clamp(0, 120000);
        expect(delays.last, Duration(milliseconds: milliseconds));
        await tester.pump(delays.last);
      }
      reachability.dispose();
    });
  }

  testReachability(
    'instances are isolated and disposal ignores the initial read',
    (final tester) async {
      final initial = Completer<NetworkConnectivity>();
      network.initial = initial.future;
      reachability
        ..start()
        ..dispose();
      initial.complete(NetworkConnectivity.available);
      await tester.pump();
      expect(calls, 0);
      final otherNetwork = _Network();
      final other = Reachability(
        connectivity: otherNetwork,
        probe: () async => true,
      )..start();
      await tester.pump();
      expect(other.current, ReachabilityStatus.reachable);
      expect(reachability.current, ReachabilityStatus.checking);
      other.dispose();
      unawaited(otherNetwork.events.close());
    },
  );

  testReachability('starting paused performs no probes until resumed', (
    final tester,
  ) async {
    reachability.start(paused: true);
    expect(reachability.isPaused, isTrue);
    network.events.add(NetworkConnectivity.available);
    await tester.pump();
    await reachability.probe();
    reachability.reportWsState(alive: false);
    await tester.pump(const Duration(minutes: 5));
    expect(calls, 0);
    reachability
      ..resume()
      ..resume();
    await tester.pump();
    expect(reachability.isPaused, isFalse);
    expect(reachability.current, ReachabilityStatus.reachable);
    expect(calls, 1);
  });

  testReachability(
    'pause cancels backoff and resume starts a fresh retry sequence',
    (final tester) async {
      response = () async => false;
      reachability.start();
      await tester.pump();
      await tester.pump(const Duration(seconds: 5));
      expect(calls, 2);
      reachability
        ..pause()
        ..pause();
      expect(reachability.current, ReachabilityStatus.serverUnreachable);
      reachability
        ..reportNetworkFailure()
        ..reportWsState(alive: false);
      await tester.pump(const Duration(minutes: 5));
      expect(calls, 2);
      reachability.resume();
      expect(reachability.current, ReachabilityStatus.checking);
      await tester.pump();
      expect(calls, 3);
      await tester.pump(const Duration(seconds: 5));
      expect(calls, 4);
    },
  );

  for (final succeeds in [true, false]) {
    testReachability('pause supersedes a pending probe ($succeeds)', (
      final tester,
    ) async {
      final pending = Completer<bool>();
      response = () => pending.future;
      reachability.start();
      await tester.pump();
      final completion = reachability.probe();
      reachability.pause();
      await completion;
      pending.complete(succeeds);
      await tester.pump(const Duration(minutes: 5));
      expect(reachability.current, ReachabilityStatus.checking);
      expect(calls, 1);
      response = () async => true;
      reachability.resume();
      await tester.pump();
      expect(reachability.current, ReachabilityStatus.reachable);
      expect(calls, 2);
    });
  }

  testReachability('resume rechecks OS state even when no events arrived', (
    final tester,
  ) async {
    reachability.start();
    await tester.pump();
    reachability.pause();
    network.initial = Future.value(NetworkConnectivity.offline);
    reachability.resume();
    await tester.pump();
    expect(calls, 1);
    expect(reachability.current, ReachabilityStatus.noLocalNetwork);
    reachability.pause();
    network.initial = Future.value(NetworkConnectivity.available);
    reachability.resume();
    await tester.pump();
    expect(calls, 2);
  });

  testReachability('paused network events cannot probe or erase unauthorized', (
    final tester,
  ) async {
    reachability.start();
    await tester.pump();
    reachability
      ..reportAuthFailure()
      ..pause();
    network.events.add(NetworkConnectivity.offline);
    network.events.add(NetworkConnectivity.available);
    await tester.pump();
    reachability.resume();
    await tester.pump();
    expect(reachability.current, ReachabilityStatus.unauthorized);
    expect(calls, 1);
  });

  testReachability('pause supersedes initial and resume connectivity reads', (
    final tester,
  ) async {
    final initial = Completer<NetworkConnectivity>();
    network.initial = initial.future;
    reachability
      ..start()
      ..pause();
    initial.complete(NetworkConnectivity.available);
    await tester.pump();
    expect(calls, 0);
    final resumed = Completer<NetworkConnectivity>();
    network.initial = resumed.future;
    reachability
      ..resume()
      ..pause();
    resumed.complete(NetworkConnectivity.available);
    await tester.pump();
    expect(calls, 0);
    network.initial = Future.value(NetworkConnectivity.available);
    reachability.resume();
    await tester.pump();
    expect(calls, 1);
  });

  testReachability(
    'synchronous probe errors are state and disposal rejects writes',
    (final tester) async {
      response = () => throw StateError('failed');
      reachability.start();
      await tester.pump();
      expect(reachability.current, ReachabilityStatus.serverUnreachable);
      reachability
        ..dispose()
        ..dispose();
      expect(reachability.start, throwsStateError);
      expect(reachability.probe, throwsStateError);
      expect(reachability.reportSuccess, throwsStateError);
      expect(reachability.reportProtectedSuccess, throwsStateError);
      expect(reachability.reportNetworkFailure, throwsStateError);
      expect(reachability.reportAuthFailure, throwsStateError);
      expect(reachability.pause, throwsStateError);
      expect(reachability.resume, throwsStateError);
    },
  );
}
