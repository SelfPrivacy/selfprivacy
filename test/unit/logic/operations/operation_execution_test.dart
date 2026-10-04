import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../helpers/fixtures/domain_mutation_fixtures.dart';

void main() {
  test('no work is not reported as success', () {
    expect(OperationExecution().report.status, OperationStatus.notSent);
  });

  test('provider failure survives later successful steps', () {
    final execution = OperationExecution()
      ..recordCompletion(succeeded: false)
      ..recordCompletion(succeeded: true);
    expect(execution.report.status, OperationStatus.failed);
  });

  test('partial failure retains accepted jobs without claiming success', () {
    final job = aServiceMoveJob();
    final execution = OperationExecution()
      ..record(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(job),
        ),
      )
      ..recordCompletion(succeeded: false);
    expect(execution.report.status, OperationStatus.failed);
    expect(execution.report.jobIds, {job.uid});
  });
}
