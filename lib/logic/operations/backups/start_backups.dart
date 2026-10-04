import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/repositories/backups_repository.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';

Future<List<ServerMutationResult<ServerJob>>> startBackups(
  final BackupsRepository repository,
  final Iterable<String> serviceIds,
) async {
  final submitted = List<String>.unmodifiable(serviceIds);
  final results = <ServerMutationResult<ServerJob>>[];
  for (final id in submitted) {
    if (!repository.commands.isAttached) {
      throw const OperationNotSent();
    }
    OperationExecution.current?.recordStep(
      OperationStep(
        id: id,
        titleKey: 'operations.kind.manageBackups',
        target: id,
        status: OperationStatus.running,
      ),
    );
    final result = await repository.startBackup(id);
    OperationExecution.current?.recordStep(
      OperationStep.fromMutation(
        id: id,
        titleKey: 'operations.kind.manageBackups',
        target: id,
        result: result,
      ),
    );
    results.add(result);
  }
  return List.unmodifiable(results);
}
