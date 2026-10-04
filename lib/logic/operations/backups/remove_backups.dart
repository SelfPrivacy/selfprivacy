import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/repositories/backups_repository.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

Future<ServerMutationResult<BackupConfiguration>> removeBackups(
  final BackupsRepository repository, {
  required final Future<void> Function() removeBucket,
}) async {
  final result = await repository.removeRepository();
  OperationExecution.current?.recordStep(
    OperationStep.fromMutation(
      id: 'remove',
      titleKey: 'operations.kind.manage_backups',
      result: result,
    ),
  );
  if (result.outcome == ServerMutationOutcome.confirmed) {
    if (!repository.commands.isAttached) {
      throw const OperationNotSent();
    }
    await removeBucket();
  }
  return result;
}
