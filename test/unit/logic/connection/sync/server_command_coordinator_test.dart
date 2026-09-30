import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';

class _Api extends Mock implements ServerApi {}

ServerMutationResult<int> result({
  final ServerMutationOutcome outcome = ServerMutationOutcome.confirmed,
  final ServerMutationPayload<int> payload =
      const ServerMutationPayload.available(2),
}) => ServerMutationResult(outcome: outcome, payload: payload);

void main() {
  late ServerStateOrigin origin;
  late ServerStateOrigin? current;
  late ServerApi api;
  late DomainStore<int> users;
  late DomainStore<int> jobs;
  late DomainStore<int> settings;
  late ServerCommandCoordinator coordinator;

  void testCoordinator(final String name, final WidgetTesterCallback body) {
    testWidgets(name, (final tester) async {
      origin = ServerStateOrigin('server-uuid');
      current = origin;
      api = _Api();
      DomainStore<int> store(final String name) => DomainStore(
        name: name,
        fetch: () async => 1,
        support: DomainSupport.supported,
        refreshInterval: const Duration(seconds: 10),
        now: tester.binding.clock.now,
      )..push(1);
      users = store('users');
      jobs = store('jobs');
      settings = store('settings');
      coordinator = ServerCommandCoordinator(
        origin: origin,
        currentOrigin: () => current,
        api: api,
        stores: [users, jobs, settings],
      );
      try {
        await body(tester);
      } finally {
        coordinator.dispose();
        users.dispose();
        jobs.dispose();
        settings.dispose();
        await tester.pump();
      }
    });
  }

  testCoordinator(
    'publishes confirmed effects before completing with the bound API',
    (final tester) async {
      final confirmed = result();
      final previous = users.value.updatedAt;
      await tester.pump(const Duration(seconds: 1));
      final handle = coordinator.submit<int>(
        domains: [users],
        send: (final boundApi) async {
          expect(boundApi, same(api));
          expect(coordinator.isReserved(users), isTrue);
          expect(users.value.data, 1);
          return confirmed;
        },
        applyConfirmed: (final response) {
          users.patch((_) => response.payload.value!);
          return [users];
        },
      );
      final completion = await handle.completion;
      expect(completion.application, CommandApplication.applied);
      expect(completion.result, same(confirmed));
      expect(await handle.remoteResult, same(confirmed));
      expect(users.value.data, 2);
      expect(users.value.updatedAt, previous);
      expect(users.value.freshness, Freshness.fresh);
      expect(users.value.needsReconciliation, isFalse);
      expect(coordinator.isReserved(users), isFalse);
      expect(coordinator.pending, isEmpty);
    },
  );

  testCoordinator(
    'conflicting sets are FIFO while disjoint commands run concurrently',
    (final tester) async {
      final responses = List.generate(
        4,
        (_) => Completer<ServerMutationResult<int>>(),
      );
      final sent = <int>[];
      CommandHandle<int> submit(
        final int id,
        final List<DomainStore<Object>> domains,
      ) => coordinator.submit(
        domains: domains,
        send: (_) {
          sent.add(id);
          return responses[id].future;
        },
      );
      final first = submit(0, [users]);
      final second = submit(1, [users, jobs]);
      final third = submit(2, [jobs]);
      final disjoint = submit(3, [settings]);
      expect(sent, [0, 3]);
      expect(coordinator.pending.map((final command) => command.phase), [
        CommandPhase.running,
        CommandPhase.queued,
        CommandPhase.queued,
        CommandPhase.running,
      ]);
      responses[3].complete(result());
      await disjoint.completion;
      expect(sent, [0, 3]);
      responses[0].complete(result());
      await first.completion;
      expect(sent, [0, 3, 1]);
      expect(coordinator.isReserved(users), isTrue);
      expect(coordinator.isReserved(jobs), isTrue);
      responses[1].complete(result());
      await second.completion;
      expect(sent, [0, 3, 1, 2]);
      responses[2].complete(result());
      await third.completion;
      expect(coordinator.pending, isEmpty);
    },
  );

  for (final outcome in [
    ServerMutationOutcome.rejected,
    ServerMutationOutcome.indeterminate,
  ]) {
    testCoordinator('$outcome does not apply a payload or retry the command', (
      final tester,
    ) async {
      var calls = 0;
      final response = result(outcome: outcome);
      final handle = coordinator.submit<int>(
        domains: [users, jobs],
        send: (_) async {
          calls++;
          return response;
        },
        applyConfirmed: (_) => fail('must not publish an unconfirmed payload'),
      );
      final completion = await handle.completion;
      expect(completion.result, same(response));
      expect(completion.application, CommandApplication.notApplied);
      expect(users.value.data, 1);
      expect(users.value.needsReconciliation, isTrue);
      expect(jobs.value.needsReconciliation, isTrue);
      expect(settings.value.needsReconciliation, isFalse);
      await tester.pump(const Duration(seconds: 30));
      expect(calls, 1);
      expect(coordinator.pending, isEmpty);
    });
  }

  for (final payload in [
    const ServerMutationPayload<int>.missing(),
    const ServerMutationPayload<int>.notExpected(),
  ]) {
    testCoordinator(
      'confirmed ${payload.status} reconciles without a reducer',
      (final tester) async {
        final completion = await coordinator
            .submit<int>(
              domains: [users],
              send: (_) async => result(payload: payload),
            )
            .completion;
        expect(completion.result!.outcome, ServerMutationOutcome.confirmed);
        expect(completion.application, CommandApplication.notApplied);
        expect(users.value.needsReconciliation, isTrue);
      },
    );
  }

  testCoordinator('only uncovered domains are invalidated after confirmation', (
    final tester,
  ) async {
    await coordinator
        .submit<int>(
          domains: [users, jobs],
          send: (_) async => result(),
          applyConfirmed: (final response) {
            users.push(response.payload.value!);
            return [users];
          },
        )
        .completion;
    expect(users.value.needsReconciliation, isFalse);
    expect(jobs.value.needsReconciliation, isTrue);
  });

  testCoordinator('old read cannot overwrite a confirmed command effect', (
    final tester,
  ) async {
    final read = users.refresh(force: true);
    final command = coordinator.submit<int>(
      domains: [users],
      send: (_) async => result(),
      applyConfirmed: (final response) {
        users.patch((_) => response.payload.value!);
        return [users];
      },
    );
    expect(await read, RefreshResult.superseded);
    await command.completion;
    expect(users.value.data, 2);
    expect(users.value.needsReconciliation, isTrue);
  });

  testCoordinator(
    'complete command payload satisfies a fenced read obligation',
    (final tester) async {
      final read = users.refresh(force: true);
      await coordinator
          .submit<int>(
            domains: [users],
            send: (_) async => result(),
            applyConfirmed: (final response) {
              users.push(response.payload.value!);
              return [users];
            },
          )
          .completion;
      expect(await read, RefreshResult.superseded);
      expect(users.value.data, 2);
      expect(users.value.needsReconciliation, isFalse);
    },
  );

  for (final removed in [false, true]) {
    testCoordinator(
      'late result is detached after ${removed ? 'removal' : 'generation replacement'}',
      (final tester) async {
        final response = Completer<ServerMutationResult<int>>();
        final handle = coordinator.submit<int>(
          domains: [users],
          send: (_) => response.future,
          applyConfirmed: (_) =>
              fail('must not publish to an obsolete generation'),
        );
        final queued = coordinator.submit<int>(
          domains: [users],
          send: (_) => fail(
            'must not send a queued command from an obsolete generation',
          ),
        );
        current = removed ? null : ServerStateOrigin(origin.serverId);
        final confirmed = result();
        response.complete(confirmed);
        final completion = await handle.completion;
        expect(completion.application, CommandApplication.detached);
        expect(completion.result, same(confirmed));
        expect(await handle.remoteResult, same(confirmed));
        expect(
          (await queued.completion).application,
          CommandApplication.detached,
        );
        expect(await queued.remoteResult, isNull);
        expect(users.value.data, 1);
        expect(coordinator.pending, isEmpty);
      },
    );
  }

  testCoordinator(
    'disposal resolves local waiters but preserves the eventual remote outcome',
    (final tester) async {
      final response = Completer<ServerMutationResult<int>>();
      final running = coordinator.submit<int>(
        domains: [users],
        send: (_) => response.future,
        applyConfirmed: (_) => fail('must not publish after disposal'),
      );
      final queued = coordinator.submit<int>(
        domains: [users],
        send: (_) => fail('must not send'),
      );
      coordinator.dispose();
      final completion = await running.completion;
      expect(completion.application, CommandApplication.detached);
      expect(completion.result, isNull);
      expect(
        (await queued.completion).application,
        CommandApplication.detached,
      );
      expect(await queued.remoteResult, isNull);
      expect(coordinator.isReserved(users), isFalse);
      final confirmed = result();
      response.complete(confirmed);
      expect(await running.remoteResult, same(confirmed));
      expect(users.value.data, 1);
      final afterDisposal = coordinator.submit<int>(
        domains: [users],
        send: (_) => fail('must not send'),
      );
      expect(
        (await afterDisposal.completion).application,
        CommandApplication.detached,
      );
      expect(await afterDisposal.remoteResult, isNull);
    },
  );

  testCoordinator(
    'local reducer failure preserves confirmation and releases reservations',
    (final tester) async {
      final confirmed = result();
      final handle = coordinator.submit<int>(
        domains: [users],
        send: (_) async => confirmed,
        applyConfirmed: (_) => throw StateError('secret-sentinel'),
      );
      final completion = await handle.completion;
      expect(completion.application, CommandApplication.failed);
      expect(completion.result, same(confirmed));
      expect(await handle.remoteResult, same(confirmed));
      expect(users.value.needsReconciliation, isTrue);
      expect(coordinator.pending, isEmpty);
      expect(coordinator.isReserved(users), isFalse);
      expect(completion.toString(), isNot(contains('secret-sentinel')));
    },
  );

  for (final synchronous in [false, true]) {
    testCoordinator(
      'unexpected ${synchronous ? 'synchronous' : 'async'} send failures become indeterminate without leaking text',
      (final tester) async {
        final handle = coordinator.submit<int>(
          domains: [users],
          send: (_) {
            if (synchronous) {
              throw StateError('secret-sentinel');
            }
            return Future.error(StateError('secret-sentinel'));
          },
          applyConfirmed: (_) => fail('must not publish'),
        );
        final completion = await handle.completion;
        expect(completion.result!.outcome, ServerMutationOutcome.indeterminate);
        expect(completion.result!.message, isNull);
        expect(
          completion.result.toString(),
          isNot(contains('secret-sentinel')),
        );
        expect(await handle.remoteResult, same(completion.result));
        expect(users.value.needsReconciliation, isTrue);
        expect(coordinator.pending, isEmpty);
      },
    );
  }

  testCoordinator('pending snapshots contain only immutable safe metadata', (
    final tester,
  ) async {
    final snapshots = <List<PendingCommand>>[];
    final subscription = coordinator.changes.listen(snapshots.add);
    final response = Completer<ServerMutationResult<String>>();
    final handle = coordinator.submit<String>(
      domains: [users],
      send: (_) => response.future,
    );
    final running = coordinator.pending;
    expect(running.single.id, same(handle.id));
    expect(running.single.domains, {'users'});
    expect(running.clear, throwsUnsupportedError);
    expect(() => running.single.domains.clear(), throwsUnsupportedError);
    response.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available('secret-sentinel'),
        message: 'secret-sentinel',
      ),
    );
    final completion = await handle.completion;
    await tester.pump();
    expect(completion.result!.payload.value, 'secret-sentinel');
    expect(snapshots.last, isEmpty);
    expect(snapshots.toString(), isNot(contains('secret-sentinel')));
    expect(running.single.phase, CommandPhase.running);
    unawaited(subscription.cancel());
  });

  testCoordinator('rejects unknown or empty affected sets', (
    final tester,
  ) async {
    final foreign = DomainStore<int>(
      name: 'users',
      fetch: () async => 1,
      refreshInterval: const Duration(seconds: 10),
    );
    expect(
      () => coordinator.submit<int>(domains: [], send: (_) async => result()),
      throwsArgumentError,
    );
    expect(
      () => coordinator.submit<int>(
        domains: [foreign],
        send: (_) async => result(),
      ),
      throwsArgumentError,
    );
    foreign.dispose();
  });

  testCoordinator('reentrant disjoint submissions do not wait for active I/O', (
    final tester,
  ) async {
    final response = Completer<ServerMutationResult<int>>();
    late CommandHandle<int> nested;
    var nestedSent = false;
    final first = coordinator.submit<int>(
      domains: [users],
      send: (_) {
        nested = coordinator.submit<int>(
          domains: [jobs],
          send: (_) async {
            nestedSent = true;
            return result();
          },
        );
        return response.future;
      },
    );
    await tester.pump();
    expect(nestedSent, isTrue);
    await nested.completion;
    expect(coordinator.isReserved(users), isTrue);
    response.complete(result());
    await first.completion;
  });

  testCoordinator(
    'a disposed store detaches pending commands before dispatch',
    (final tester) async {
      users.dispose();
      final handle = coordinator.submit<int>(
        domains: [users],
        send: (_) => fail('must not send without the originating cache'),
      );
      expect(
        (await handle.completion).application,
        CommandApplication.detached,
      );
      expect(await handle.remoteResult, isNull);
    },
  );

  testCoordinator(
    'undeclared coverage fails locally and retains the remote outcome',
    (final tester) async {
      final confirmed = result();
      final completion = await coordinator
          .submit<int>(
            domains: [users],
            send: (_) async => confirmed,
            applyConfirmed: (_) => [jobs],
          )
          .completion;
      expect(completion.result, same(confirmed));
      expect(completion.application, CommandApplication.failed);
      expect(users.value.needsReconciliation, isTrue);
      expect(jobs.value.needsReconciliation, isFalse);
      expect(coordinator.pending, isEmpty);
    },
  );

  testCoordinator(
    'replaced generation accepts its own commands without old effects',
    (final tester) async {
      final response = Completer<ServerMutationResult<int>>();
      final old = coordinator.submit<int>(
        domains: [users],
        send: (_) => response.future,
        applyConfirmed: (_) => fail('must not publish old effects'),
      );
      final replacementOrigin = ServerStateOrigin(origin.serverId);
      current = replacementOrigin;
      final replacementStore = DomainStore<int>(
        name: 'users',
        fetch: () async => 10,
        support: DomainSupport.supported,
        refreshInterval: const Duration(seconds: 10),
      )..push(10);
      final replacement = ServerCommandCoordinator(
        origin: replacementOrigin,
        currentOrigin: () => current,
        api: _Api(),
        stores: [replacementStore],
      );
      try {
        await replacement
            .submit<int>(
              domains: [replacementStore],
              send: (_) async =>
                  result(payload: const ServerMutationPayload.available(20)),
              applyConfirmed: (final response) {
                replacementStore.push(response.payload.value!);
                return [replacementStore];
              },
            )
            .completion;
        response.complete(result());
        expect((await old.completion).application, CommandApplication.detached);
        expect(replacementStore.value.data, 20);
        expect(users.value.data, 1);
      } finally {
        replacement.dispose();
        replacementStore.dispose();
      }
    },
  );
}
