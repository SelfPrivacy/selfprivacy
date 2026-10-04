import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/repositories/services_repository.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';

Future<List<ServerMutationResult<ServerJob>>> moveServices(
  final ServicesRepository repository,
  final Map<String, String> destinations,
) async {
  final submitted = Map<String, String>.unmodifiable(destinations);
  final results = <ServerMutationResult<ServerJob>>[];
  for (final entry in submitted.entries) {
    if (!repository.commands.isAttached) {
      throw const OperationNotSent();
    }
    OperationExecution.current?.recordStep(
      OperationStep(
        id: entry.key,
        titleKey: 'operations.kind.manage_services',
        target: entry.key,
        status: OperationStatus.running,
      ),
    );
    final result = await repository.move(entry.key, entry.value);
    OperationExecution.current?.recordStep(
      OperationStep.fromMutation(
        id: entry.key,
        titleKey: 'operations.kind.manage_services',
        target: entry.key,
        result: result,
      ),
    );
    results.add(result);
  }
  return List.unmodifiable(results);
}
