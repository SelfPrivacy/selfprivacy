import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/logic/operations/remove_operation_history.dart';

import '../../../helpers/connection_fixture.dart';
import '../../../helpers/fixtures/backup_fixtures.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  test('failed cleanup at capacity retains the operation for retry', () async {
    final api = _Api();
    final connection = seededConnection(api);
    addTearDown(connection.dispose);
    final queue = connection.operations;
    final oldest = queue.submit(
      OperationKind.manageBackups,
      () async {},
      describe: (_) =>
          OperationReport(OperationStatus.accepted, jobIds: {'oldest-job'}),
    );
    await oldest.result;
    queue.observeJob('oldest-job', succeeded: true);
    for (var i = 1; i < OperationQueue.completedHistoryLimit; i++) {
      await queue.submit(OperationKind.manageBackups, () async {}).result;
    }
    final cubit = createOperationsCubit(connection, showMessage: (_) {});
    addTearDown(cubit.close);
    when(() => api.getServerJob('oldest-job')).thenThrow(Exception('offline'));

    await cubit.remove(oldest.id);

    expect(
      cubit.state.operations.map((final operation) => operation.id),
      contains(oldest.id),
    );
    expect(queue.history, hasLength(OperationQueue.completedHistoryLimit));

    when(() => api.getServerJob('oldest-job')).thenAnswer((_) async => null);
    await cubit.remove(oldest.id);
    expect(
      cubit.state.operations.map((final operation) => operation.id),
      isNot(contains(oldest.id)),
    );
    expect(queue.history, hasLength(OperationQueue.completedHistoryLimit - 1));
  });

  test(
    'partial history deletion retains the operation and can be retried',
    () async {
      final api = _Api();
      final connection = seededConnection(api);
      addTearDown(connection.dispose);
      final queue = connection.operations;
      final handle = queue.submit(
        OperationKind.manageBackups,
        () async {},
        describe: (_) =>
            OperationReport(OperationStatus.accepted, jobIds: {'a', 'b'}),
      );
      await handle.result;
      queue
        ..observeJob('a', succeeded: true)
        ..observeJob('b', succeeded: true);
      final jobs = {
        for (final uid in ['a', 'b'])
          uid: aBackupJob(uid: uid, status: JobStatusEnum.finished),
      };
      var reject = true;
      final removed = <String>[];
      when(() => api.removeApiJob(any())).thenAnswer((final invocation) async {
        final uid = invocation.positionalArguments.single as String;
        if (uid == 'b' && reject) {
          return ServerMutationResult(
            outcome: ServerMutationOutcome.rejected,
            payload: const ServerMutationPayload.notExpected(),
          );
        }
        jobs.remove(uid);
        removed.add(uid);
        return ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        );
      });
      Future<bool> remove() => removeOperationHistory(
        queue: queue,
        jobs: connection.jobs,
        id: handle.id,
        readJob: (final uid) async => jobs[uid],
      );
      expect(await remove(), isFalse);
      expect(queue.history, hasLength(1));
      expect(removed, ['a']);
      reject = false;
      expect(await remove(), isTrue);
      expect(queue.history, isEmpty);
      expect(removed, ['a', 'b']);
    },
  );

  test(
    'unknown operations cannot delete jobs that are still running',
    () async {
      final api = _Api();
      final connection = seededConnection(api);
      addTearDown(connection.dispose);
      final queue = connection.operations;
      final handle = queue.submit(
        OperationKind.manageBackups,
        () async {},
        describe: (_) =>
            OperationReport(OperationStatus.accepted, jobIds: {'a'}),
      );
      await handle.result;
      queue.observeMissingJob('a');
      expect(
        await removeOperationHistory(
          queue: queue,
          jobs: connection.jobs,
          id: handle.id,
          readJob: (_) async =>
              aBackupJob(uid: 'a', status: JobStatusEnum.running),
        ),
        isFalse,
      );
      verifyNever(() => api.removeApiJob(any()));
      expect(queue.history, hasLength(1));
    },
  );
}
