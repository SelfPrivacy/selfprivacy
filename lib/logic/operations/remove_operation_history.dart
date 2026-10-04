import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

Future<bool> removeOperationHistory({
  required final OperationQueue queue,
  required final JobsRepository jobs,
  required final int id,
  required final Future<ServerJob?> Function(String) readJob,
}) async {
  final operation = queue.history
      .where((final item) => item.id == id)
      .firstOrNull;
  if (operation == null || operation.status.isPending) {
    return false;
  }
  try {
    final completed = <String>[];
    for (final uid in operation.jobIds) {
      final job = await readJob(uid);
      if (job == null) {
        continue;
      }
      if (job.status != JobStatusEnum.finished &&
          job.status != JobStatusEnum.error) {
        return false;
      }
      completed.add(uid);
    }
    for (final uid in completed) {
      final result = await jobs.removeJob(uid);
      if (result.outcome != ServerMutationOutcome.confirmed) {
        return false;
      }
    }
    return queue.removeCompleted(id);
  } catch (_) {
    return false;
  }
}
