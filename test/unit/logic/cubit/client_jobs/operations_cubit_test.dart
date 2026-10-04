import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/operations_cubit.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

void main() {
  test('only new long operations request progress navigation', () async {
    final queue = OperationQueue(serverId: 'server');
    addTearDown(queue.dispose);
    final existing = queue.recordExternal(
      OperationKind.resizeVolume,
      OperationStatus.running,
    );
    final cubit = OperationsCubit(
      queue: queue,
      remove: (_) async => true,
      showMessage: (_) {},
    );
    addTearDown(cubit.close);
    expect(cubit.state.focusId, isNull);
    queue.recordExternal(OperationKind.manageUsers, OperationStatus.succeeded);
    await pumpEventQueue();
    expect(cubit.state.focusId, isNull);
    final next = queue.recordExternal(
      OperationKind.initializeBackups,
      OperationStatus.running,
    );
    await pumpEventQueue();
    expect(cubit.state.focusId, next);
    queue.updateExternal(existing, OperationStatus.succeeded);
    await pumpEventQueue();
    expect(cubit.state.focusId, next);
  });

  test('a late job ID does not request progress navigation', () async {
    final queue = OperationQueue(serverId: 'server');
    addTearDown(queue.dispose);
    final cubit = OperationsCubit(
      queue: queue,
      remove: (_) async => true,
      showMessage: (_) {},
    );
    addTearDown(cubit.close);
    final response = Completer<void>();
    final operation = queue.submit(
      OperationKind.manageServices,
      () => response.future,
      describe: (_) =>
          OperationReport(OperationStatus.accepted, jobIds: ['late-job']),
    );
    await pumpEventQueue();
    expect(cubit.state.focusId, isNull);
    response.complete();
    await operation.result;
    await pumpEventQueue();
    expect(cubit.state.operations.single.jobIds, {'late-job'});
    expect(cubit.state.focusId, isNull);
  });

  test(
    'history removal stays pending through failure without duplicate requests',
    () async {
      final queue = OperationQueue(serverId: 'server');
      addTearDown(queue.dispose);
      final id = queue.recordExternal(
        OperationKind.manageUsers,
        OperationStatus.succeeded,
      );
      final completion = Completer<bool>();
      var calls = 0;
      final feedback = <String>[];
      final cubit = OperationsCubit(
        queue: queue,
        remove: (_) {
          calls++;
          return completion.future;
        },
        showMessage: feedback.add,
      );
      addTearDown(cubit.close);
      final removing = cubit.remove(id);
      await cubit.remove(id);
      expect(calls, 1);
      expect(cubit.state.removing, {id});
      expect(cubit.state.operations, hasLength(1));
      completion.complete(false);
      await removing;
      expect(cubit.state.operations, hasLength(1));
      expect(cubit.state.removing, isEmpty);
      expect(feedback, hasLength(1));
    },
  );
}
