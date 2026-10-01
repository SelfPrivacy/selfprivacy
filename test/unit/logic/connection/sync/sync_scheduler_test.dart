import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/cache/server_state_cache.dart';
import 'package:selfprivacy/logic/connection/lifecycle/app_lifecycle.dart';
import 'package:selfprivacy/logic/connection/lifecycle/network_connectivity.dart';
import 'package:selfprivacy/logic/connection/lifecycle/reachability.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/connection/sync/sync_scheduler.dart';

import '../../../../fakes/graphql/link_transport.dart';
import '../../../../helpers/fixtures/json_fixture.dart';

class _Lifecycle extends Mock implements AppLifecycle {}

class _Network extends Mock implements NetworkConnectivitySource {}

class _Api extends Mock implements ServerApi {}

void main() {
  late SyncScheduler scheduler;
  late ServerStateCache cache;
  late Reachability reachability;
  late StreamController<bool> visibility;
  late bool foreground;
  late List<String> calls;
  late Map<String, dynamic> fixtures;
  late Map<String, Completer<Response>> pending;
  late Set<String> failures;
  late List<Duration> timers;
  late ServerCommandCoordinator commands;

  Response response(final String operation) => Response(
    response: const {},
    data: fixtures[operation] as Map<String, dynamic>,
  );

  void show({required final bool visible}) {
    foreground = visible;
    visibility.add(visible);
  }

  void testScheduler(final String name, final WidgetTesterCallback body) {
    testWidgets(name, (final tester) async {
      foreground = true;
      calls = [];
      timers = [];
      pending = {};
      failures = {};
      fixtures = loadJsonFixture('graphql/domain_reads.json');
      visibility = StreamController<bool>.broadcast(sync: true);
      final lifecycle = _Lifecycle();
      when(() => lifecycle.isForeground).thenAnswer((_) => foreground);
      when(
        () => lifecycle.foregroundChanges,
      ).thenAnswer((_) => visibility.stream);
      final network = _Network();
      when(
        network.check,
      ).thenAnswer((_) async => NetworkConnectivity.available);
      when(() => network.changes).thenAnswer((_) => const Stream.empty());
      reachability = Reachability(
        connectivity: network,
        probe: () async => true,
      );
      cache = ServerStateCache(
        now: tester.binding.clock.now,
        api: ServerApi(
          transport: transportWithLink(
            Link.function((final request, [final forward]) {
              final name = request.operation.document.definitions
                  .whereType<OperationDefinitionNode>()
                  .single
                  .name!
                  .value;
              calls.add(name);
              if (failures.contains(name)) {
                return Stream.error(StateError('failed $name'));
              }
              if (pending[name] case final completion?) {
                return Stream.fromFuture(completion.future);
              }
              return Stream.value(response(name));
            }),
          ),
        ),
      );
      final origin = ServerStateOrigin('server');
      commands = ServerCommandCoordinator(
        origin: origin,
        currentOrigin: () => origin,
        api: _Api(),
        stores: cache.stores,
      );
      scheduler = SyncScheduler(
        cache: cache,
        reachability: reachability,
        lifecycle: lifecycle,
        commands: commands,
        now: tester.binding.clock.now,
        createTimer: (final delay, final callback) {
          timers.add(delay);
          return Timer(delay, callback);
        },
      );
      try {
        await body(tester);
      } finally {
        scheduler.dispose();
        commands.dispose();
        reachability.dispose();
        cache.dispose();
        for (final entry in pending.entries) {
          if (!entry.value.isCompleted) {
            entry.value.complete(response(entry.key));
          }
        }
        await tester.pump();
        unawaited(visibility.close());
      }
    });
  }

  testScheduler('suspension blocks dispatch until resumed', (
    final tester,
  ) async {
    scheduler
      ..setSuspended(suspended: true)
      ..start();
    await tester.pump();
    expect(calls, isEmpty);
    expect(await scheduler.refresh('apiVersion'), RefreshResult.deferred);
    scheduler.setSuspended(suspended: false);
    await tester.pump();
    expect(calls, contains('GetApiVersion'));
  });

  testScheduler('pool snapshots are immutable and slots stay stable', (
    final tester,
  ) async {
    final snapshots = <List<SyncPoolActivity?>>[];
    final subscription = scheduler.poolStatusChanges.listen(snapshots.add);
    addTearDown(subscription.cancel);
    final initial = scheduler.poolStatus;
    expect(initial, hasLength(SyncScheduler.poolSize));
    expect(initial, everyElement(isNull));
    expect(() => initial[0] = null, throwsUnsupportedError);
    for (final name in [
      'GetApiJobs',
      'BackupConfiguration',
      'AllBackupSnapshots',
      'AllUsers',
    ]) {
      pending[name] = Completer<Response>();
    }
    final startedAt = tester.binding.clock.now();
    scheduler.start();
    await tester.pump();
    final full = scheduler.poolStatus;
    expect(
      full.whereType<SyncPoolActivity>(),
      hasLength(SyncScheduler.poolSize),
    );
    expect(full.map((final slot) => slot?.startedAt), everyElement(startedAt));
    expect(initial, everyElement(isNull));
    final slot = full.indexWhere(
      (final activity) => activity?.domain == cache.serverJobs.name,
    );
    expect(slot, isNonNegative);
    scheduler.boost('users', interval: const Duration(seconds: 15));
    await tester.pump();
    expect(scheduler.poolStatus, full);
    await tester.pump(const Duration(seconds: 1));
    pending.remove('GetApiJobs')!.complete(response('GetApiJobs'));
    await tester.pump();
    expect(scheduler.poolStatus[slot], (
      domain: 'users',
      startedAt: tester.binding.clock.now(),
    ));
    for (var i = 0; i < SyncScheduler.poolSize; i++) {
      if (i != slot) {
        expect(scheduler.poolStatus[i], full[i]);
      }
    }
    expect(full[slot]?.domain, cache.serverJobs.name);
    expect(snapshots.last, scheduler.poolStatus);
    expect(() => snapshots.last.clear(), throwsUnsupportedError);
  });

  testScheduler('explicit requests coalesce and report their applied result', (
    final tester,
  ) async {
    scheduler.start();
    await tester.pump();
    calls.clear();
    pending['AllUsers'] = Completer<Response>();
    final first = scheduler.refresh('users');
    final second = scheduler.refresh('users');
    expect(second, same(first));
    await tester.pump();
    final third = scheduler.refresh('users');
    expect(third, same(first));
    expect(calls, ['AllUsers']);
    pending.remove('AllUsers')!.complete(response('AllUsers'));
    await tester.pump();
    expect(await first, RefreshResult.applied);
  });

  for (final background in [false, true]) {
    testScheduler(
      'explicit refresh is finite while ${background ? 'backgrounded' : 'unauthorized'}',
      (final tester) async {
        scheduler.start();
        await tester.pump();
        calls.clear();
        if (background) {
          show(visible: false);
        } else {
          reachability.reportAuthFailure();
        }
        expect(await scheduler.refresh('users'), RefreshResult.deferred);
        expect(cache.users.value.needsReconciliation, isTrue);
        expect(calls, isEmpty);
        if (background) {
          show(visible: true);
        } else {
          reachability.reportProtectedSuccess();
        }
        await tester.pump();
        expect(calls, ['AllUsers']);
      },
    );
  }

  testScheduler('unknown support and pre-start policy return finite outcomes', (
    final tester,
  ) async {
    expect(await scheduler.refresh('users'), RefreshResult.unsupported);
    expect(await scheduler.refresh('apiVersion'), RefreshResult.deferred);
    expect(() => scheduler.refresh('unknown'), throwsArgumentError);
    scheduler.dispose();
    expect(await scheduler.refresh('users'), RefreshResult.disposed);
  });

  testScheduler('commands block dispatch and reconcile only after release', (
    final tester,
  ) async {
    scheduler.start();
    await tester.pump();
    calls.clear();
    final response = Completer<ServerMutationResult<void>>();
    final command = commands.submit<void>(
      domains: [cache.users],
      send: (_) => response.future,
    );
    expect(await scheduler.refresh('users'), RefreshResult.deferred);
    await tester.pump();
    expect(calls, isEmpty);
    response.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    await command.completion;
    await tester.pump();
    expect(calls, ['AllUsers']);
  });

  testScheduler(
    'confirmed complete payload discharges blocked reconciliation',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      calls.clear();
      final users = cache.users.value.data!;
      final response = Completer<ServerMutationResult<void>>();
      final command = commands.submit<void>(
        domains: [cache.users],
        send: (_) => response.future,
        applyConfirmed: (_) {
          cache.users.push(users);
          return [cache.users];
        },
      );
      expect(await scheduler.refresh('users'), RefreshResult.deferred);
      response.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await command.completion;
      await tester.pump();
      expect(calls, isEmpty);
    },
  );

  testScheduler('queued refresh defers when a command takes its domain', (
    final tester,
  ) async {
    scheduler.start();
    await tester.pump();
    calls.clear();
    final refresh = scheduler.refresh('users');
    final response = Completer<ServerMutationResult<void>>();
    final command = commands.submit<void>(
      domains: [cache.users],
      send: (_) => response.future,
    );
    await tester.pump();
    expect(await refresh, RefreshResult.superseded);
    expect(calls, isEmpty);
    response.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.rejected,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    await command.completion;
  });

  testScheduler(
    'explicit failure reports failed and respects subsequent cooldown',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      calls.clear();
      failures.add('AllUsers');
      final refresh = scheduler.refresh('users');
      await tester.pump();
      expect(await refresh, RefreshResult.failed);
      await tester.pump(const Duration(seconds: 59));
      expect(calls.where((final call) => call == 'AllUsers'), hasLength(1));
    },
  );

  testScheduler(
    'disposal completes both queued and in-flight refresh waiters',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      pending['AllUsers'] = Completer<Response>();
      final active = scheduler.refresh('users');
      await tester.pump();
      final queued = scheduler.refresh('settings');
      scheduler.dispose();
      expect(await active, RefreshResult.disposed);
      expect(await queued, RefreshResult.disposed);
    },
  );

  testScheduler(
    'repeated explicit refreshes yield to overdue background work',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      for (var i = 0; i < SyncScheduler.poolSize; i++) {
        final refresh = scheduler.refresh('users');
        await tester.pump();
        await refresh;
      }
      calls.clear();
      cache.settings.invalidate();
      final refresh = scheduler.refresh('users');
      await tester.pump();
      await refresh;
      expect(calls.take(2), ['SystemSettings', 'AllUsers']);
    },
  );

  testScheduler('failed reads release observable slots', (final tester) async {
    failures.add('GetApiVersion');
    final snapshots = <List<SyncPoolActivity?>>[];
    final subscription = scheduler.poolStatusChanges.listen(snapshots.add);
    addTearDown(subscription.cancel);
    scheduler.start();
    await tester.pump();
    expect(snapshots, hasLength(2));
    expect(
      snapshots.first.whereType<SyncPoolActivity>().single.domain,
      'apiVersion',
    );
    expect(snapshots.last, everyElement(isNull));
    expect(scheduler.poolStatus, everyElement(isNull));
  });

  testScheduler('disposal closes observation without late slot updates', (
    final tester,
  ) async {
    pending['GetApiVersion'] = Completer<Response>();
    var closed = false;
    final snapshots = <List<SyncPoolActivity?>>[];
    final subscription = scheduler.poolStatusChanges.listen(
      snapshots.add,
      onDone: () => closed = true,
    );
    addTearDown(subscription.cancel);
    scheduler.start();
    await tester.pump();
    final last = scheduler.poolStatus;
    scheduler.dispose();
    await tester.pump();
    expect(closed, isTrue);
    pending.remove('GetApiVersion')!.complete(response('GetApiVersion'));
    await tester.pump();
    expect(scheduler.poolStatus, same(last));
    expect(snapshots, [last]);
  });

  testScheduler('construction is idle and startup discovers version first', (
    final tester,
  ) async {
    expect(calls, isEmpty);
    pending['GetApiVersion'] = Completer<Response>();
    scheduler
      ..start()
      ..start();
    await tester.pump();
    expect(calls, ['GetApiVersion']);
    pending.remove('GetApiVersion')!.complete(response('GetApiVersion'));
    await tester.pump();
    expect(calls, hasLength(11));
    expect(cache.users.value.freshness, Freshness.fresh);
  });

  testScheduler('refreshes before staleness and honors each interval', (
    final tester,
  ) async {
    scheduler.start();
    await tester.pump();
    calls.clear();
    await tester.pump(const Duration(seconds: 9));
    expect(calls, isEmpty);
    await tester.pump(const Duration(seconds: 1));
    expect(calls, isEmpty);
    expect(cache.serverJobs.value.freshness, Freshness.fresh);
    await tester.pump(const Duration(seconds: 50));
    expect(calls, contains('AllUsers'));
    expect(calls, isNot(contains('SystemSettings')));
    expect(calls, isNot(contains('BackupConfiguration')));
    expect(timers.every((final delay) => delay > Duration.zero), isTrue);
  });

  testScheduler('three reads at most and page interests take the next slot', (
    final tester,
  ) async {
    for (final name in [
      'GetApiJobs',
      'BackupConfiguration',
      'AllBackupSnapshots',
    ]) {
      pending[name] = Completer<Response>();
    }
    scheduler.start();
    await tester.pump();
    expect(calls, [
      'GetApiVersion',
      'GetApiJobs',
      'BackupConfiguration',
      'AllBackupSnapshots',
    ]);
    final interest = scheduler.boost(
      'users',
      interval: const Duration(seconds: 15),
    );
    await tester.pump();
    expect(calls, hasLength(4));
    pending.remove('GetApiJobs')!.complete(response('GetApiJobs'));
    await tester.pump();
    expect(calls[4], 'AllUsers');
    expect(calls, contains('SystemSettings'));
    interest.dispose();
  });

  testScheduler(
    'failed reads wait their interval without blocking other domains',
    (final tester) async {
      failures.add('AllUsers');
      scheduler.start();
      await tester.pump();
      expect(cache.users.value.lastError, isNotNull);
      calls.clear();
      await tester.pump(const Duration(seconds: 59));
      expect(calls, isNot(contains('AllUsers')));
      failures.clear();
      await tester.pump(const Duration(seconds: 1));
      expect(calls.where((final name) => name == 'AllUsers'), hasLength(1));
      expect(cache.users.value.data, isNotEmpty);
    },
  );

  testScheduler(
    'version failure retains known support but initial failure gates domains',
    (final tester) async {
      failures.add('GetApiVersion');
      scheduler.start();
      await tester.pump();
      expect(calls, ['GetApiVersion']);
      failures.clear();
      await tester.pump(const Duration(seconds: 60));
      expect(calls, hasLength(12));
      failures.add('GetApiVersion');
      calls.clear();
      await tester.pump(const Duration(seconds: 60));
      expect(calls, contains('AllUsers'));
      expect(cache.users.value.support, DomainSupport.supported);
    },
  );

  testScheduler('unsupported domains never fetch even with page interests', (
    final tester,
  ) async {
    final version = fixtures['GetApiVersion'] as Map<String, dynamic>;
    (version['api'] as Map<String, dynamic>)['version'] = '2.3.0';
    scheduler
      ..boost('groups', interval: const Duration(seconds: 1))
      ..start();
    await tester.pump();
    expect(calls, isNot(contains('AllGroups')));
    expect(calls, isNot(contains('AllServices')));
    expect(calls, isNot(contains('AllBackupSnapshots')));
  });

  testScheduler(
    'opening forces a fresh read and shortest active interest wins',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      calls.clear();
      final slow = scheduler.boost(
        'users',
        interval: const Duration(seconds: 30),
      );
      final fast = scheduler.boost(
        'users',
        interval: const Duration(seconds: 10),
      );
      await tester.pump();
      expect(calls, ['AllUsers']);
      await tester.pump(const Duration(seconds: 10));
      expect(calls.where((final name) => name == 'AllUsers'), hasLength(2));
      fast
        ..dispose()
        ..dispose();
      await tester.pump(const Duration(seconds: 29));
      expect(calls.where((final name) => name == 'AllUsers'), hasLength(2));
      await tester.pump(const Duration(seconds: 1));
      expect(calls.where((final name) => name == 'AllUsers'), hasLength(3));
      slow.dispose();
      await tester.pump(const Duration(seconds: 59));
      expect(calls.where((final name) => name == 'AllUsers'), hasLength(3));
    },
  );

  testScheduler('interests coalesce with an in-flight read', (
    final tester,
  ) async {
    pending['AllUsers'] = Completer<Response>();
    scheduler.start();
    await tester.pump();
    final interest = scheduler.boost(
      'users',
      interval: const Duration(seconds: 30),
    );
    pending.remove('AllUsers')!.complete(response('AllUsers'));
    await tester.pump();
    expect(calls.where((final name) => name == 'AllUsers'), hasLength(1));
    interest.dispose();
  });

  testScheduler(
    'background gates initial work and disposed interests lose forced refresh',
    (final tester) async {
      show(visible: false);
      scheduler.start();
      await tester.pump(const Duration(minutes: 5));
      expect(calls, isEmpty);
      expect(reachability.isPaused, isTrue);
      show(visible: true);
      await tester.pump();
      calls.clear();
      show(visible: false);
      scheduler.boost('users', interval: const Duration(seconds: 30)).dispose();
      show(visible: true);
      await tester.pump();
      expect(calls, isEmpty);
    },
  );

  testScheduler(
    'resume refreshes overdue domains and retained page interests',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      show(visible: false);
      calls.clear();
      scheduler.boost('settings', interval: const Duration(seconds: 600));
      await tester.pump(const Duration(seconds: 61));
      expect(calls, isEmpty);
      show(visible: true);
      await tester.pump();
      expect(calls.first, 'GetApiVersion');
      expect(calls[1], 'SystemSettings');
      expect(calls, contains('AllUsers'));
      expect(calls, isNot(contains('AllBackupSnapshots')));
    },
  );

  testScheduler('unauthorized gates fetching until protected success', (
    final tester,
  ) async {
    scheduler.start();
    await tester.pump();
    reachability.reportAuthFailure();
    calls.clear();
    await tester.pump(const Duration(minutes: 5));
    expect(calls, isEmpty);
    reachability.reportSuccess();
    await tester.pump();
    expect(calls, isEmpty);
    reachability.reportProtectedSuccess();
    await tester.pump();
    expect(calls, contains('AllUsers'));
  });

  testScheduler('recovery clears failed-read cooldowns', (final tester) async {
    failures.add('AllUsers');
    scheduler.start();
    await tester.pump();
    calls.clear();
    reachability
      ..reportNetworkFailure()
      ..reportNetworkFailure();
    await tester.pump();
    failures.clear();
    reachability.reportSuccess();
    await tester.pump();
    expect(calls, ['AllUsers']);
  });

  testScheduler(
    'jobs pushes postpone polling and invalidation refreshes promptly',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      calls.clear();
      await tester.pump(const Duration(seconds: 9));
      cache.serverJobs.push([]);
      await tester.pump(const Duration(seconds: 1));
      expect(calls, isEmpty);
      await tester.pump(const Duration(seconds: 59));
      expect(calls, contains('GetApiJobs'));
      cache.users.invalidate();
      await tester.pump();
      expect(calls.last, 'AllUsers');
    },
  );

  testScheduler(
    'disposing stops queued and late work without disposing inputs',
    (final tester) async {
      pending['GetApiVersion'] = Completer<Response>();
      scheduler.start();
      await tester.pump();
      final interest = scheduler.boost(
        'users',
        interval: const Duration(seconds: 1),
      );
      scheduler
        ..dispose()
        ..dispose();
      interest.dispose();
      pending.remove('GetApiVersion')!.complete(response('GetApiVersion'));
      await tester.pump(const Duration(minutes: 5));
      expect(calls, ['GetApiVersion']);
      expect(reachability.isPaused, isTrue);
      await cache.users.refresh();
      expect(cache.users.value.data, isNotEmpty);
      expect(scheduler.start, throwsStateError);
      expect(
        () => scheduler.boost('users', interval: const Duration(seconds: 1)),
        throwsStateError,
      );
    },
  );

  testScheduler(
    'queued callers finish when backgrounded while all permits are occupied',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      for (final entry in {
        'serverJobs': 'GetApiJobs',
        'backups': 'AllBackupSnapshots',
        'backupConfig': 'BackupConfiguration',
      }.entries) {
        pending[entry.value] = Completer<Response>();
        unawaited(scheduler.refresh(entry.key));
      }
      await tester.pump();
      calls.clear();
      final queued = scheduler.refresh('users');
      await tester.pump();
      show(visible: false);
      await tester.pump();
      expect(await queued, RefreshResult.deferred);
      expect(cache.users.value.needsReconciliation, isTrue);
      expect(calls, isEmpty);
    },
  );

  testScheduler(
    'background command completion publishes without passive reads',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      calls.clear();
      final response = Completer<ServerMutationResult<void>>();
      final command = commands.submit<void>(
        domains: [cache.users],
        send: (_) => response.future,
        applyConfirmed: (_) {
          cache.users.patch((final users) => List.unmodifiable(users.skip(1)));
          return [cache.users];
        },
      );
      expect(await scheduler.refresh('users'), RefreshResult.deferred);
      show(visible: false);
      response.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      expect(
        (await command.completion).application,
        CommandApplication.applied,
      );
      await tester.pump();
      expect(cache.users.value.data!.map((final user) => user.login), [
        'bob',
        'root',
      ]);
      expect(calls, isEmpty);
      show(visible: true);
      await tester.pump();
      expect(calls, ['AllUsers']);
    },
  );

  testScheduler('an active explicit read can finish in the background', (
    final tester,
  ) async {
    scheduler.start();
    await tester.pump();
    calls.clear();
    pending['AllUsers'] = Completer<Response>();
    final refresh = scheduler.refresh('users');
    await tester.pump();
    show(visible: false);
    pending.remove('AllUsers')!.complete(response('AllUsers'));
    await tester.pump();
    expect(await refresh, RefreshResult.applied);
    expect(calls, ['AllUsers']);
  });

  testScheduler('explicit refresh joins an externally started read', (
    final tester,
  ) async {
    scheduler.start();
    await tester.pump();
    calls.clear();
    pending['AllUsers'] = Completer<Response>();
    final external = cache.users.refresh(force: true);
    final requested = scheduler.refresh('users');
    pending.remove('AllUsers')!.complete(response('AllUsers'));
    await tester.pump();
    expect(await external, RefreshResult.applied);
    expect(await requested, RefreshResult.applied);
    expect(calls, ['AllUsers']);
  });

  testScheduler('cache disposal resolves queued refreshes without dispatch', (
    final tester,
  ) async {
    scheduler.start();
    await tester.pump();
    calls.clear();
    final requested = scheduler.refresh('users');
    cache.dispose();
    await tester.pump();
    expect(await requested, RefreshResult.disposed);
    expect(calls, isEmpty);
  });

  testScheduler(
    'coordinator disposal stops dispatch and finishes queued callers',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      calls.clear();
      final requested = scheduler.refresh('users');
      commands.dispose();
      await tester.pump();
      expect(await requested, RefreshResult.disposed);
      expect(calls, isEmpty);
    },
  );

  testScheduler('rejects invalid interests', (final tester) async {
    final origin = ServerStateOrigin('other-server');
    final foreign = ServerCommandCoordinator(
      origin: origin,
      currentOrigin: () => origin,
      api: _Api(),
      stores: [],
    );
    expect(
      () => SyncScheduler(
        cache: cache,
        reachability: reachability,
        lifecycle: _Lifecycle(),
        commands: foreign,
      ),
      throwsArgumentError,
    );
    foreign.dispose();
    expect(
      () => scheduler.boost('typo', interval: const Duration(seconds: 1)),
      throwsArgumentError,
    );
    expect(
      () => scheduler.boost('users', interval: Duration.zero),
      throwsArgumentError,
    );
  });

  testScheduler(
    'backgrounding prevents queued reads after an active request finishes',
    (final tester) async {
      for (final name in [
        'GetApiJobs',
        'BackupConfiguration',
        'AllBackupSnapshots',
      ]) {
        pending[name] = Completer<Response>();
      }
      scheduler.start();
      await tester.pump();
      show(visible: false);
      pending.remove('GetApiJobs')!.complete(response('GetApiJobs'));
      await tester.pump();
      expect(calls, hasLength(4));
      show(visible: true);
      await tester.pump();
      expect(calls, contains('AllUsers'));
    },
  );

  testScheduler(
    'page interest bypasses failure cooldown without losing cached data',
    (final tester) async {
      scheduler.start();
      await tester.pump();
      final users = cache.users.value.data;
      failures.add('AllUsers');
      await tester.pump(const Duration(seconds: 60));
      expect(cache.users.value.data, same(users));
      expect(cache.users.value.lastError, isNotNull);
      failures.clear();
      calls.clear();
      final interest = scheduler.boost(
        'users',
        interval: const Duration(seconds: 30),
      );
      await tester.pump();
      expect(calls, ['AllUsers']);
      expect(cache.users.value.lastError, isNull);
      interest.dispose();
    },
  );

  testScheduler('external refreshes coalesce with page interests', (
    final tester,
  ) async {
    scheduler.start();
    await tester.pump();
    calls.clear();
    pending['AllUsers'] = Completer<Response>();
    final refresh = cache.users.refresh(force: true);
    scheduler.boost('users', interval: const Duration(seconds: 30));
    await tester.pump();
    expect(calls, ['AllUsers']);
    pending.remove('AllUsers')!.complete(response('AllUsers'));
    await refresh;
    await tester.pump();
    expect(calls, ['AllUsers']);
  });

  for (final background in [false, true]) {
    testScheduler(
      'superseded reads recheck ${background ? 'lifecycle' : 'authentication'} before replacement',
      (final tester) async {
        scheduler.start();
        await tester.pump();
        calls.clear();
        pending['AllUsers'] = Completer<Response>();
        scheduler.boost('users', interval: const Duration(seconds: 30));
        await tester.pump();
        cache.users.patch((final users) => List.unmodifiable(users.skip(1)));
        final patched = cache.users.value.data;
        if (background) {
          show(visible: false);
        } else {
          reachability.reportAuthFailure();
        }
        pending.remove('AllUsers')!.complete(response('AllUsers'));
        await tester.pump();
        expect(calls, ['AllUsers']);
        expect(cache.users.value.data, same(patched));
        expect(cache.users.value.needsReconciliation, isTrue);
        expect(scheduler.poolStatus, everyElement(isNull));
        if (background) {
          show(visible: true);
        } else {
          reachability.reportProtectedSuccess();
        }
        await tester.pump();
        expect(calls, ['AllUsers', 'AllUsers']);
        expect(cache.users.value.needsReconciliation, isFalse);
      },
    );
  }

  testScheduler(
    'cooldown starts at failure completion rather than request start',
    (final tester) async {
      pending['AllUsers'] = Completer<Response>();
      scheduler.start();
      await tester.pump();
      await tester.pump(const Duration(seconds: 4));
      pending.remove('AllUsers')!.completeError(StateError('late error'));
      await tester.pump();
      calls.clear();
      await tester.pump(const Duration(seconds: 59));
      expect(calls, isNot(contains('AllUsers')));
      await tester.pump(const Duration(seconds: 1));
      expect(calls, contains('AllUsers'));
    },
  );

  testScheduler('reselects work after a waiting page interest is released', (
    final tester,
  ) async {
    scheduler.start();
    await tester.pump();
    calls.clear();
    for (final entry in {
      'serverJobs': 'GetApiJobs',
      'backupConfig': 'BackupConfiguration',
      'backups': 'AllBackupSnapshots',
    }.entries) {
      pending[entry.value] = Completer<Response>();
      scheduler.boost(entry.key, interval: const Duration(seconds: 60));
    }
    await tester.pump();
    expect(calls, hasLength(3));
    final interest = scheduler.boost(
      'users',
      interval: const Duration(seconds: 30),
    );
    await tester.pump();
    interest.dispose();
    pending.remove('GetApiJobs')!.complete(response('GetApiJobs'));
    await tester.pump();
    expect(calls, hasLength(3));
    scheduler.boost('settings', interval: const Duration(seconds: 60));
    await tester.pump();
    expect(calls.last, 'SystemSettings');
  });

  for (final dispose in [false, true]) {
    testScheduler(
      'waiting permit respects ${dispose ? 'disposal' : 'unauthorized state'}',
      (final tester) async {
        for (final name in [
          'GetApiJobs',
          'BackupConfiguration',
          'AllBackupSnapshots',
        ]) {
          pending[name] = Completer<Response>();
        }
        scheduler.start();
        await tester.pump();
        expect(calls, hasLength(4));
        if (dispose) {
          scheduler.dispose();
        } else {
          reachability.reportAuthFailure();
        }
        for (final entry in pending.entries.toList()) {
          pending.remove(entry.key)!.complete(response(entry.key));
        }
        await tester.pump(const Duration(seconds: 1));
        expect(calls, hasLength(4));
        if (!dispose) {
          reachability.reportProtectedSuccess();
          await tester.pump();
          expect(calls, contains('AllUsers'));
        }
      },
    );
  }
}
