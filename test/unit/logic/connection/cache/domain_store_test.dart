import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';

DomainStore<T> createStore<T extends Object>(
  final WidgetTester tester, {
  required final Future<T> Function() fetch,
  final DomainSupport support = DomainSupport.supported,
  final Duration? staleAfter,
}) {
  final store = DomainStore<T>(
    name: 'test',
    fetch: fetch,
    refreshInterval: const Duration(seconds: 10),
    staleAfter: staleAfter,
    support: support,
    now: tester.binding.clock.now,
  );
  addTearDown(store.dispose);
  return store;
}

void main() {
  testWidgets(
    'partial effects preserve unrelated data and snapshot deadlines',
    (final tester) async {
      final store = createStore<Map<String, int>>(
        tester,
        fetch: () async => const {'changed': 1, 'retained': 2},
      );
      expect(await store.refresh(), RefreshResult.applied);
      final original = store.value;
      await tester.pump(const Duration(seconds: 9));
      expect(
        store.patch((final data) => Map.unmodifiable({...data, 'changed': 3})),
        isTrue,
      );
      expect(store.value.data, {'changed': 3, 'retained': 2});
      expect(original.data, {'changed': 1, 'retained': 2});
      expect(store.value.updatedAt, original.updatedAt);
      expect(store.value.needsReconciliation, isFalse);
      expect(store.isDue, isFalse);
      expect(await store.refresh(), RefreshResult.current);
      expect(() => store.value.data!['changed'] = 4, throwsUnsupportedError);
      await tester.pump(const Duration(seconds: 1));
      expect(store.isDue, isTrue);
      await tester.pump(const Duration(seconds: 10));
      expect(store.value.freshness, Freshness.stale);
      store.dispose();
    },
  );

  testWidgets('partial effects cannot establish a complete initial list', (
    final tester,
  ) async {
    final store = createStore<List<int>>(tester, fetch: () async => const [1]);
    expect(
      store.patch((_) => fail('must not reduce an absent snapshot')),
      isFalse,
    );
    expect(store.value.data, isNull);
    expect(store.value.updatedAt, isNull);
    expect(store.value.needsReconciliation, isTrue);
    expect(await store.refresh(), RefreshResult.applied);
    expect(store.value.needsReconciliation, isFalse);
    store.dispose();
  });

  for (final fails in [false, true]) {
    testWidgets('partial deletion fences old reads and errors ($fails)', (
      final tester,
    ) async {
      final response = Completer<List<int>>();
      final store = createStore<List<int>>(tester, fetch: () => response.future)
        ..push(const [1, 2]);
      final updatedAt = store.value.updatedAt;
      final attempt = store.refresh(force: true);
      store.patch(
        (final data) => List.unmodifiable(data.where((final id) => id != 1)),
      );
      expect(await store.refresh(), RefreshResult.superseded);
      if (fails) {
        response.completeError(StateError('obsolete error'));
      } else {
        response.complete(const [1, 2]);
      }
      expect(await attempt, RefreshResult.superseded);
      expect(store.value.data, [2]);
      expect(store.value.updatedAt, updatedAt);
      expect(store.value.lastError, isNull);
      expect(store.value.needsReconciliation, isTrue);
      expect(store.isDue, isTrue);
      store.push(const [2]);
      expect(store.value.needsReconciliation, isFalse);
      expect(store.isDue, isFalse);
      store.dispose();
    });
  }

  testWidgets('patch retains stale state and existing reconciliation', (
    final tester,
  ) async {
    final store = createStore<int>(tester, fetch: () async => 1)
      ..push(1)
      ..invalidate()
      ..patch((final data) => data + 1);
    expect(store.value.freshness, Freshness.stale);
    expect(store.value.needsReconciliation, isTrue);
    expect(store.value.data, 2);
    expect(await store.refresh(), RefreshResult.applied);
    expect(store.value.needsReconciliation, isFalse);
    store.dispose();
  });

  testWidgets('failed reducers leave the snapshot and active read unchanged', (
    final tester,
  ) async {
    final response = Completer<int>();
    final store = createStore<int>(tester, fetch: () => response.future)
      ..push(1);
    final attempt = store.refresh(force: true);
    final before = store.value;
    expect(
      () => store.patch((_) => throw StateError('bad reducer')),
      throwsStateError,
    );
    expect(store.value, same(before));
    response.complete(2);
    expect(await attempt, RefreshResult.applied);
    store.setSupport(DomainSupport.unsupported);
    expect(() => store.patch((final value) => value), throwsStateError);
    store.dispose();
    expect(() => store.patch((final value) => value), throwsStateError);
  });

  testWidgets('complete push covers old reads even after a later patch', (
    final tester,
  ) async {
    final response = Completer<int>();
    final store = createStore<int>(tester, fetch: () => response.future);
    final attempt = store.refresh();
    store
      ..invalidate()
      ..push(2)
      ..patch((final value) => value + 1);
    response.complete(1);
    expect(await attempt, RefreshResult.superseded);
    expect(store.value.data, 3);
    expect(store.value.needsReconciliation, isFalse);
    expect(await store.refresh(), RefreshResult.current);
    store.dispose();
  });

  test('rejects invalid timing policies', () {
    DomainStore<int> create(
      final Duration interval,
      final Duration staleAfter,
    ) => DomainStore<int>(
      name: 'test',
      fetch: () async => 1,
      refreshInterval: interval,
      staleAfter: staleAfter,
    );

    expect(
      () => create(Duration.zero, const Duration(seconds: 1)),
      throwsArgumentError,
    );
    expect(
      () => create(const Duration(seconds: -1), const Duration(seconds: 1)),
      throwsArgumentError,
    );
    expect(
      () => create(const Duration(seconds: 10), const Duration(seconds: 10)),
      throwsArgumentError,
    );
    expect(
      () => create(const Duration(seconds: 10), const Duration(seconds: 5)),
      throwsArgumentError,
    );
  });

  testWidgets('empty data is a loaded result, distinct from initial state', (
    final tester,
  ) async {
    final store = createStore<List<int>>(tester, fetch: () async => []);
    expect(store.value.data, isNull);
    expect(store.value.updatedAt, isNull);
    expect(store.value.freshness, Freshness.stale);
    expect(store.isDue, isTrue);

    await store.refresh();

    expect(store.value.data, isEmpty);
    expect(store.value.updatedAt, tester.binding.clock.now());
    expect(store.value.freshness, Freshness.fresh);
    expect(store.value.isRefreshing, isFalse);
    expect(store.isDue, isFalse);
    store.dispose();
  });

  testWidgets('refresh becomes due before automatic staleness, without I/O', (
    final tester,
  ) async {
    var requests = 0;
    final store = createStore<int>(tester, fetch: () async => ++requests);
    await store.refresh();
    await tester.pump(const Duration(seconds: 9));
    expect(store.isDue, isFalse);
    await tester.pump(const Duration(seconds: 1));
    expect(store.isDue, isTrue);
    expect(store.value.freshness, Freshness.fresh);
    await tester.pump(const Duration(seconds: 10));
    expect(store.value.freshness, Freshness.stale);
    expect(store.value.data, 1);
    expect(requests, 1);
    store.dispose();
  });

  testWidgets('honors a custom staleness deadline', (final tester) async {
    final store = createStore<int>(
      tester,
      fetch: () async => 1,
      staleAfter: const Duration(seconds: 30),
    );
    await store.refresh();
    await tester.pump(const Duration(seconds: 20));
    expect(store.value.freshness, Freshness.fresh);
    await tester.pump(const Duration(seconds: 10));
    expect(store.value.freshness, Freshness.stale);
    store.dispose();
  });

  testWidgets('skips a fresh result unless forced', (final tester) async {
    var requests = 0;
    final store = createStore<int>(tester, fetch: () async => ++requests);
    await store.refresh();
    await store.refresh();
    expect(requests, 1);
    await store.refresh(force: true);
    expect(requests, 2);
    expect(store.value.data, 2);
    store.dispose();
  });

  testWidgets('unchanged success renews deadlines and emits its timestamp', (
    final tester,
  ) async {
    final store = createStore<int>(tester, fetch: () async => 1);
    final states = <CachedValue<int>>[];
    final subscription = store.stream.listen(states.add);
    addTearDown(subscription.cancel);
    await store.refresh();
    final firstUpdate = store.value.updatedAt!;
    await tester.pump(const Duration(seconds: 10));
    await store.refresh();
    await tester.pump();
    expect(store.value.updatedAt, firstUpdate.add(const Duration(seconds: 10)));
    expect(states.last.updatedAt, store.value.updatedAt);
    await tester.pump(const Duration(seconds: 10));
    expect(store.value.freshness, Freshness.fresh);
    await tester.pump(const Duration(seconds: 10));
    expect(store.value.freshness, Freshness.stale);
    store.dispose();
  });

  testWidgets('concurrent and forced refreshes share one pending request', (
    final tester,
  ) async {
    final response = Completer<int>();
    var requests = 0;
    final store = createStore<int>(
      tester,
      fetch: () {
        requests++;
        return response.future;
      },
    );
    final first = store.refresh();
    final second = store.refresh(force: true);
    expect(identical(first, second), isTrue);
    expect(store.value.isRefreshing, isTrue);
    response.complete(1);
    await first;
    expect(requests, 1);
    expect(store.value.isRefreshing, isFalse);
    store.dispose();
  });

  testWidgets('failure retains data and its deadline, recovery clears error', (
    final tester,
  ) async {
    final error = Exception('fetch failed');
    var fails = false;
    final store = createStore<int>(
      tester,
      fetch: () async {
        if (fails) {
          throw error;
        }
        return 1;
      },
    );
    await store.refresh();
    final updatedAt = store.value.updatedAt;
    fails = true;
    await tester.pump(const Duration(seconds: 10));
    expect(await store.refresh(), RefreshResult.failed);
    expect(store.value.lastError, same(error));
    expect(store.value.data, 1);
    expect(store.value.updatedAt, updatedAt);
    expect(store.value.freshness, Freshness.fresh);
    await tester.pump(const Duration(seconds: 10));
    expect(store.value.freshness, Freshness.stale);
    await store.refresh();
    expect(store.value.data, 1);
    expect(store.value.freshness, Freshness.stale);
    fails = false;
    await store.refresh();
    expect(store.value.lastError, isNull);
    expect(store.value.freshness, Freshness.fresh);
    store.dispose();
  });

  testWidgets('initial synchronous fetch failure is recorded without data', (
    final tester,
  ) async {
    final error = Exception('fetch failed');
    final store = createStore<int>(tester, fetch: () => throw error);
    await store.refresh();
    expect(store.value.lastError, same(error));
    expect(store.value.data, isNull);
    expect(store.value.updatedAt, isNull);
    expect(store.value.isRefreshing, isFalse);
    expect(store.isDue, isTrue);
    store.dispose();
  });

  testWidgets('expiry does not hide an active background refresh', (
    final tester,
  ) async {
    final response = Completer<int>();
    final store = createStore<int>(tester, fetch: () => response.future)
      ..push(1);
    await tester.pump(const Duration(seconds: 10));
    final refresh = store.refresh();
    expect(store.value.freshness, Freshness.fresh);
    expect(store.value.isRefreshing, isTrue);
    await tester.pump(const Duration(seconds: 10));
    expect(store.value.freshness, Freshness.stale);
    expect(store.value.isRefreshing, isTrue);
    response.complete(2);
    await refresh;
    expect(store.value.freshness, Freshness.fresh);
    expect(store.value.isRefreshing, isFalse);
    store.dispose();
  });

  for (final fails in [false, true]) {
    testWidgets('push supersedes pending fetch (failure: $fails)', (
      final tester,
    ) async {
      final response = Completer<int>();
      final store = createStore<int>(tester, fetch: () => response.future);
      final refresh = store.refresh();
      await tester.pump(const Duration(seconds: 1));
      store.push(2);
      final pushedAt = store.value.updatedAt;
      if (fails) {
        response.completeError(Exception('old failure'));
      } else {
        response.complete(1);
      }
      await refresh;
      expect(store.value.data, 2);
      expect(store.value.updatedAt, pushedAt);
      expect(store.value.lastError, isNull);
      expect(store.value.freshness, Freshness.fresh);
      expect(store.value.isRefreshing, isFalse);
      store.dispose();
    });
  }

  testWidgets('idle invalidation marks stale without fetching or losing data', (
    final tester,
  ) async {
    var requests = 0;
    final store = createStore<int>(tester, fetch: () async => ++requests);
    await store.refresh();
    store.invalidate();
    expect(store.value.freshness, Freshness.stale);
    expect(store.value.data, 1);
    expect(store.isDue, isTrue);
    expect(requests, 1);
    await store.refresh();
    expect(store.value.data, 2);
    store.dispose();
  });

  for (final fails in [false, true]) {
    testWidgets('invalidations coalesce and discard old response ($fails)', (
      final tester,
    ) async {
      final responses = [Completer<int>(), Completer<int>()];
      var requests = 0;
      final store = createStore<int>(
        tester,
        fetch: () => responses[requests++].future,
      )..push(0);
      final refresh = store.refresh(force: true);
      store
        ..invalidate()
        ..invalidate();
      if (fails) {
        responses[0].completeError(Exception('old failure'));
      } else {
        responses[0].complete(1);
      }
      await tester.pump();
      expect(await refresh, RefreshResult.superseded);
      expect(requests, 1);
      expect(store.value.data, 0);
      expect(store.value.lastError, isNull);
      expect(store.value.isRefreshing, isFalse);
      expect(store.value.needsReconciliation, isTrue);
      final replacement = store.refresh();
      responses[1].complete(2);
      expect(await replacement, RefreshResult.applied);
      expect(store.value.data, 2);
      expect(store.value.freshness, Freshness.fresh);
      store.dispose();
    });
  }

  testWidgets('each invalidated attempt requires a separate refresh call', (
    final tester,
  ) async {
    final responses = List.generate(3, (_) => Completer<int>());
    var requests = 0;
    final store = createStore<int>(
      tester,
      fetch: () => responses[requests++].future,
    );
    final refresh = store.refresh();
    store.invalidate();
    responses[0].complete(1);
    expect(await refresh, RefreshResult.superseded);
    expect(requests, 1);
    final second = store.refresh();
    store.invalidate();
    responses[1].complete(2);
    expect(await second, RefreshResult.superseded);
    expect(requests, 2);
    expect(store.value.data, isNull);
    final third = store.refresh();
    responses[2].complete(3);
    expect(await third, RefreshResult.applied);
    expect(store.value.data, 3);
    store.dispose();
  });

  testWidgets('push satisfies pending invalidation', (final tester) async {
    final response = Completer<int>();
    var requests = 0;
    final store = createStore<int>(
      tester,
      fetch: () {
        requests++;
        return response.future;
      },
    );
    final refresh = store.refresh();
    store
      ..invalidate()
      ..push(2);
    response.complete(1);
    await refresh;
    expect(requests, 1);
    expect(store.value.data, 2);
    store.dispose();
  });

  testWidgets('unknown and unsupported domains skip even forced refreshes', (
    final tester,
  ) async {
    var requests = 0;
    final store = createStore<int>(
      tester,
      support: DomainSupport.unknown,
      fetch: () async => ++requests,
    );
    expect(await store.refresh(force: true), RefreshResult.unsupported);
    expect(store.isDue, isFalse);
    expect(() => store.push(1), throwsStateError);
    store.setSupport(DomainSupport.unsupported);
    await store.refresh(force: true);
    expect(requests, 0);
    expect(store.value.lastError, isNull);
    store.setSupport(DomainSupport.supported);
    await store.refresh();
    expect(requests, 1);
    store.dispose();
  });

  testWidgets('losing support supersedes fetch and cancels follow-up', (
    final tester,
  ) async {
    final response = Completer<int>();
    var requests = 0;
    final store = createStore<int>(
      tester,
      fetch: () {
        requests++;
        return response.future;
      },
    )..push(0);
    final refresh = store.refresh(force: true);
    store
      ..invalidate()
      ..setSupport(DomainSupport.unsupported);
    response.complete(1);
    await refresh;
    expect(requests, 1);
    expect(store.value.data, 0);
    expect(store.value.support, DomainSupport.unsupported);
    expect(store.value.freshness, Freshness.stale);
    expect(store.value.isRefreshing, isFalse);
    store.dispose();
  });

  testWidgets('regaining support does not start another request', (
    final tester,
  ) async {
    final response = Completer<int>();
    var requests = 0;
    final store = createStore<int>(
      tester,
      fetch: () async {
        requests++;
        return requests == 1 ? response.future : 2;
      },
    );
    final refresh = store.refresh();
    store
      ..setSupport(DomainSupport.unknown)
      ..setSupport(DomainSupport.supported);
    response.complete(1);
    expect(await refresh, RefreshResult.superseded);
    expect(requests, 1);
    expect(store.value.needsReconciliation, isTrue);
    expect(await store.refresh(), RefreshResult.applied);
    expect(requests, 2);
    expect(store.value.data, 2);
    store.dispose();
  });

  testWidgets('stream broadcasts state changes but does not replay', (
    final tester,
  ) async {
    final store = createStore<int>(tester, fetch: () async => 1);
    final first = <CachedValue<int>>[];
    final second = <CachedValue<int>>[];
    final firstSubscription = store.stream.listen(first.add);
    final secondSubscription = store.stream.listen(second.add);
    addTearDown(firstSubscription.cancel);
    addTearDown(secondSubscription.cancel);
    await tester.pump();
    expect(first, isEmpty);
    await store.refresh();
    await tester.pump();
    expect(first.map((final state) => state.isRefreshing), [true, true, false]);
    expect(second, first);
    store
      ..setSupport(DomainSupport.supported)
      ..invalidate()
      ..invalidate();
    await tester.pump();
    expect(first.length, 4);
    store.dispose();
  });

  for (final fails in [false, true]) {
    testWidgets('disposal completes waiters and ignores late I/O ($fails)', (
      final tester,
    ) async {
      final response = Completer<int>();
      var requests = 0;
      final store = createStore<int>(
        tester,
        fetch: () {
          requests++;
          return response.future;
        },
      )..push(0);
      final states = <CachedValue<int>>[];
      var closed = false;
      store.stream.listen(states.add, onDone: () => closed = true);
      final refresh = store.refresh(force: true);
      store
        ..invalidate()
        ..dispose();
      expect(await refresh, RefreshResult.disposed);
      await tester.pump();
      final count = states.length;
      expect(closed, isTrue);
      if (fails) {
        response.completeError(Exception('late failure'));
      } else {
        response.complete(1);
      }
      await tester.pump(const Duration(seconds: 30));
      expect(states.length, count);
      expect(requests, 1);
      expect(store.value.data, 0);
      expect(store.value.lastError, isNull);
      expect(store.value.isRefreshing, isFalse);
      expect(await store.refresh(), RefreshResult.disposed);
      expect(store.invalidate, throwsStateError);
      expect(() => store.push(3), throwsStateError);
      expect(() => store.setSupport(DomainSupport.supported), throwsStateError);
      store.dispose();
    });
  }
}
