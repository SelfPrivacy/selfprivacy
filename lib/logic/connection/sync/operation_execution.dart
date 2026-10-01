import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

class OperationExecution {
  static final zoneKey = Object();
  static OperationExecution? get current =>
      Zone.current[zoneKey] as OperationExecution?;

  final _jobs = <String>{};
  bool _rejected = false;
  bool _unknown = false;
  bool _confirmed = false;
  bool _failed = false;

  void recordCompletion({required final bool succeeded}) {
    _confirmed |= succeeded;
    _failed |= !succeeded;
  }

  void record<T>(final ServerMutationResult<T> result) {
    switch (result.outcome) {
      case ServerMutationOutcome.rejected:
        _rejected = true;
      case ServerMutationOutcome.indeterminate:
        _unknown = true;
      case ServerMutationOutcome.confirmed:
        _confirmed = true;
        if (result.payload.value case final ServerJob job) {
          _jobs.add(job.uid);
        }
        if (result.payload.status == ServerMutationPayloadStatus.missing ||
            result.payload.status == ServerMutationPayloadStatus.unreadable) {
          _unknown = true;
        }
    }
  }

  OperationReport get report => OperationReport(
    _unknown
        ? OperationStatus.unknown
        : _failed
        ? OperationStatus.failed
        : _rejected
        ? OperationStatus.rejected
        : _jobs.isNotEmpty
        ? OperationStatus.accepted
        : _confirmed
        ? OperationStatus.succeeded
        : OperationStatus.notSent,
    jobIds: _jobs,
  );
}
