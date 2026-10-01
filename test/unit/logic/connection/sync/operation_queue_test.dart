import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';

void main() {
  late OperationQueue queue;
  setUp(() => queue = OperationQueue(serverId: 'server'));
  tearDown(() => queue.dispose());

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
      expect((await first.completion).value, 1);
      expect(sent, isFalse);
      queue.resume();
      expect((await second.completion).value, 2);
      expect(sent, isTrue);
    },
  );

  test('cancellation only affects unsent work', () async {
    queue.pause();
    var calls = 0;
    final handle = queue.submit(OperationKind.manageUsers, () async => ++calls);
    expect(handle.cancel(), isTrue);
    queue.resume();
    expect((await handle.completion).status, OperationStatus.cancelled);
    expect(calls, 0);
    final active = Completer<void>();
    final running = queue.submit(
      OperationKind.manageUsers,
      () => active.future,
    );
    expect(running.cancel(), isFalse);
    active.complete();
    await running.completion;
  });

  test('failed barrier settles queued work as not sent', () async {
    queue.pause();
    var calls = 0;
    final handle = queue.submit(OperationKind.manageUsers, () async => ++calls);
    queue
      ..rejectWaiting(OperationReason.rotationFailed)
      ..resume();
    expect((await handle.completion).status, OperationStatus.notSent);
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
          .completion;
      expect(secret.value, 'SECRET_SENTINEL');
      final error = StateError('ERROR_SECRET');
      final stack = StackTrace.current;
      final failed = queue
          .submit(
            OperationKind.manageUsers,
            () => Future<void>.error(error, stack),
          )
          .completion;
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
      await queue
          .submit(OperationKind.manageServices, () async => i)
          .completion;
    }
    expect(queue.history.length, 101);
    expect(queue.history.any((final item) => item.id == running.id), isTrue);
    active.complete();
    await running.completion;
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
          .completion;
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
    expect((await waiting.completion).status, OperationStatus.notSent);
    expect((await running.completion).status, OperationStatus.unknown);
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
}
