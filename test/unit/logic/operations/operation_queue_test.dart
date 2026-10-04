import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../helpers/fixtures/backup_fixtures.dart';

void main() {
  late OperationQueue queue;
  setUp(() => queue = OperationQueue(serverId: 'server'));
  tearDown(() => queue.dispose());

  test('completion waits for server work without holding admission', () async {
    final operation = queue.submit(
      OperationKind.manageBackups,
      () async => 'job-1',
      describe: (final uid) =>
          OperationReport(OperationStatus.accepted, jobIds: {uid}),
    );
    var completed = false;
    unawaited(operation.completion.then((_) => completed = true));
    await pumpEventQueue();

    expect(completed, isFalse);
    expect((await operation.result).value, 'job-1');
    expect(queue.isIdle, isTrue);
    queue.observeJob('job-1', succeeded: true);
    expect(await operation.completion, OperationStatus.succeeded);
    expect(completed, isTrue);
  });

  test('unknown dispatch does not abandon already accepted jobs', () async {
    final operation = queue.submit(
      OperationKind.manageBackups,
      () async {},
      describe: (_) =>
          OperationReport(OperationStatus.unknown, jobIds: {'accepted-backup'}),
    );
    expect((await operation.result).status, OperationStatus.unknown);
    expect(queue.pending.single.jobIds, {'accepted-backup'});
    queue.observeJob('accepted-backup', succeeded: true);
    expect(await operation.completion, OperationStatus.unknown);
  });

  test('detach settles completion of an accepted operation', () async {
    final operation = queue.submit(
      OperationKind.manageBackups,
      () async {},
      describe: (_) =>
          OperationReport(OperationStatus.accepted, jobIds: {'backup'}),
    );
    await operation.result;
    queue.detach();
    expect(await operation.completion, OperationStatus.unknown);
    queue.observeJob('backup', succeeded: true);
    expect(queue.history.single.status, OperationStatus.unknown);
  });

  test('a later exception does not abandon an accepted job', () async {
    final operation = queue.submit(OperationKind.manageBackups, () {
      final result = ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(aBackupJob(uid: 'backup')),
      );
      OperationExecution.current!
        ..record(result)
        ..recordStep(
          OperationStep.fromMutation(
            id: 'backup',
            titleKey: 'operations.kind.manageBackups',
            result: result,
          ),
        );
      return Future<void>.error(StateError('secret-sentinel'));
    });
    await expectLater(operation.result, throwsStateError);
    expect(queue.pending.single.jobIds, {'backup'});
    queue.observeJob('backup', succeeded: false);
    expect(await operation.completion, OperationStatus.unknown);
    expect(queue.history.single.steps.single.status, OperationStatus.failed);
    expect(queue.history.single.steps.single.messageKey, isNot('basis.done'));
  });

  test(
    'paused admission drains existing work without sending new actions',
    () async {
      final active = Completer<int>();
      final first = queue.submit(
        OperationKind.manageUsers,
        () => active.future,
      );
      queue.pause();
      var sent = false;
      final second = queue.submit(OperationKind.manageServices, () async {
        sent = true;
        return 2;
      });
      expect(queue.pending.map((final item) => item.status), [
        OperationStatus.running,
        OperationStatus.queued,
      ]);
      active.complete(1);
      await queue.whenIdle;
      expect((await first.result).value, 1);
      expect(sent, isFalse);
      queue.resume();
      expect((await second.result).value, 2);
      expect(sent, isTrue);
    },
  );

  test('cancellation only affects unsent work', () async {
    queue.pause();
    var calls = 0;
    final handle = queue.submit(OperationKind.manageUsers, () async => ++calls);
    expect(handle.cancel(), isTrue);
    queue.resume();
    expect((await handle.result).status, OperationStatus.cancelled);
    expect(await handle.completion, OperationStatus.cancelled);
    expect(calls, 0);
    final active = Completer<void>();
    final running = queue.submit(
      OperationKind.manageUsers,
      () => active.future,
    );
    expect(running.cancel(), isFalse);
    active.complete();
    await running.result;
  });

  test('failed barrier settles queued work as not sent', () async {
    queue.pause();
    var calls = 0;
    final handle = queue.submit(OperationKind.manageUsers, () async => ++calls);
    queue
      ..rejectWaiting(OperationReason.rotationFailed)
      ..resume();
    expect((await handle.result).status, OperationStatus.notSent);
    expect(await handle.completion, OperationStatus.notSent);
    expect(
      queue.history.single.events.last.reason,
      OperationReason.rotationFailed,
    );
    expect(calls, 0);
  });

  test(
    'history retains metadata but not returned secrets or raw errors',
    () async {
      final snapshots = <List<OperationSnapshot>>[];
      final subscription = queue.changes.listen(snapshots.add);
      addTearDown(subscription.cancel);
      final secret = await queue
          .submit(
            OperationKind.generateDeviceKey,
            () async => 'SECRET_SENTINEL',
          )
          .result;
      expect(secret.value, 'SECRET_SENTINEL');
      final error = StateError('ERROR_SECRET');
      final stack = StackTrace.current;
      final failed = queue
          .submit(
            OperationKind.manageUsers,
            () => Future<void>.error(error, stack),
          )
          .result;
      await expectLater(failed, throwsA(same(error)));
      await pumpEventQueue();
      expect(queue.history.last.status, OperationStatus.unknown);
      expect(snapshots, isNotEmpty);
      for (final snapshot in [...snapshots, queue.history]) {
        for (final record in snapshot) {
          expect(record.serverId, 'server');
          expect(
            record.kind,
            isIn([OperationKind.generateDeviceKey, OperationKind.manageUsers]),
          );
          expect(record.jobIds, isEmpty);
          expect(
            record.events.map((final event) => event.reason),
            everyElement(isNull),
          );
          expect(
            record.events.map((final event) => event.status),
            everyElement(
              isIn([
                OperationStatus.queued,
                OperationStatus.running,
                OperationStatus.succeeded,
                OperationStatus.unknown,
              ]),
            ),
          );
        }
      }
      expect(() => queue.history.clear(), throwsUnsupportedError);
      expect(() => queue.history.first.events.clear(), throwsUnsupportedError);
    },
  );

  test('only completed records are evicted from bounded history', () async {
    final active = Completer<void>();
    final running = queue.submit(
      OperationKind.manageUsers,
      () => active.future,
    );
    for (var i = 0; i < 102; i++) {
      await queue.submit(OperationKind.manageServices, () async => i).result;
    }
    expect(queue.history.length, 101);
    expect(queue.history.any((final item) => item.id == running.id), isTrue);
    active.complete();
    await running.result;
    expect(queue.history.length, 100);
  });

  test(
    'accepted jobs remain pending until an observed terminal outcome',
    () async {
      await queue
          .submit(
            OperationKind.manageBackups,
            () async => 'job-1',
            describe: (final uid) =>
                OperationReport(OperationStatus.accepted, jobIds: {uid}),
          )
          .result;
      expect(queue.pending.single.status, OperationStatus.accepted);
      queue.observeJob('job-1', succeeded: false);
      expect(queue.history.single.status, OperationStatus.failed);
    },
  );

  test('disposal settles waiters and rejects late completion', () async {
    final active = Completer<int>();
    final running = queue.submit(
      OperationKind.manageUsers,
      () => active.future,
    );
    queue.pause();
    final waiting = queue.submit(OperationKind.manageUsers, () async => 2);
    queue.dispose();
    expect((await waiting.result).status, OperationStatus.notSent);
    expect((await running.result).status, OperationStatus.unknown);
    final before = queue.history.singleWhere(
      (final item) => item.id == running.id,
    );
    active.complete(1);
    await Future<void>.delayed(Duration.zero);
    final after = queue.history.singleWhere(
      (final item) => item.id == running.id,
    );
    expect(after.status, OperationStatus.unknown);
    expect(after.events, before.events);
    expect(
      queue.history.singleWhere((final item) => item.id == waiting.id).status,
      OperationStatus.notSent,
    );
  });

  test(
    'a failed job does not settle an operation while another accepted job runs',
    () async {
      await queue
          .submit(
            OperationKind.manageBackups,
            () async {},
            describe: (_) => OperationReport(
              OperationStatus.accepted,
              jobIds: {'first', 'second'},
            ),
          )
          .result;
      queue.observeJob('first', succeeded: false);
      expect(queue.pending.single.status, OperationStatus.accepted);
      queue.observeJob('second', succeeded: true);
      expect(queue.pending, isEmpty);
      expect(queue.history.single.status, OperationStatus.failed);
    },
  );
}
