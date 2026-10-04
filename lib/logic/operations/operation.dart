import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

enum OperationKind {
  manageUsers,
  manageDevices,
  manageServices,
  manageBackups,
  manageVolumes,
  manageSettings,
  manageJobs,
  applyChanges,
  generateDeviceKey,
  generateRecoveryKey,
  generatePasswordResetLink,
  rotateToken;

  String get translationKey => 'operations.kind.$name';
}

enum OperationStatus {
  queued,
  running,
  accepted,
  succeeded,
  rejected,
  failed,
  unknown,
  cancelled,
  notSent;

  bool get isPending => this == queued || this == running || this == accepted;
  String get translationKey => 'operations.status.$name';
}

enum OperationReason {
  rotationFailed,
  connectionReplaced,
  cancelled,
  unavailable;

  String get translationKey => 'operations.reason.$name';
}

class OperationEvent {
  const OperationEvent(this.at, this.status, {this.reason});
  final DateTime at;
  final OperationStatus status;
  final OperationReason? reason;
}

class OperationSnapshot {
  OperationSnapshot({
    required this.id,
    required this.serverId,
    required this.kind,
    required final Iterable<OperationEvent> events,
    final Iterable<String> jobIds = const [],
    final Iterable<OperationStep> steps = const [],
  }) : events = List.unmodifiable(events),
       steps = List.unmodifiable(steps),
       jobIds = Set.unmodifiable(jobIds);

  final int id;
  final String serverId;
  final OperationKind kind;
  final List<OperationEvent> events;
  final Set<String> jobIds;
  final List<OperationStep> steps;
  OperationStatus get status => events.last.status;
  bool get canCancel => status == OperationStatus.queued;
}

class OperationStep {
  const OperationStep({
    required this.id,
    required this.titleKey,
    required this.status,
    this.target,
    this.jobId,
    this.messageKey,
  });

  factory OperationStep.fromMutation({
    required final String id,
    required final String titleKey,
    required final ServerMutationResult<Object?> result,
    final String? target,
  }) {
    final unavailable =
        result.payload.status == ServerMutationPayloadStatus.missing ||
        result.payload.status == ServerMutationPayloadStatus.unreadable;
    final job =
        result.outcome == ServerMutationOutcome.confirmed &&
            result.payload.value is ServerJob
        ? result.payload.value! as ServerJob
        : null;
    return OperationStep(
      id: id,
      titleKey: titleKey,
      target: target,
      jobId: job?.uid,
      status: switch (result.outcome) {
        ServerMutationOutcome.rejected => OperationStatus.rejected,
        ServerMutationOutcome.indeterminate => OperationStatus.unknown,
        ServerMutationOutcome.confirmed when unavailable =>
          OperationStatus.unknown,
        ServerMutationOutcome.confirmed when job != null =>
          OperationStatus.accepted,
        ServerMutationOutcome.confirmed => OperationStatus.succeeded,
      },
      messageKey: switch (result.outcome) {
        ServerMutationOutcome.rejected => 'server_mutation.rejected',
        ServerMutationOutcome.indeterminate =>
          'server_mutation.outcome_unknown',
        ServerMutationOutcome.confirmed when unavailable =>
          'server_mutation.payload_unavailable',
        ServerMutationOutcome.confirmed => 'basis.done',
      },
    );
  }

  final String id;
  final String titleKey;
  final OperationStatus status;
  final String? target;
  final String? jobId;
  final String? messageKey;

  OperationStep withStatus(final OperationStatus status) => OperationStep(
    id: id,
    titleKey: titleKey,
    status: status,
    target: target,
    jobId: jobId,
    messageKey: status.translationKey,
  );
}

class OperationReport {
  OperationReport(this.status, {final Iterable<String> jobIds = const []})
    : jobIds = Set.unmodifiable(jobIds);
  final OperationStatus status;
  final Set<String> jobIds;
}

class OperationResult<T> {
  const OperationResult(this.status, {this.value});
  final OperationStatus status;
  final T? value;
}

class OperationNotSent implements Exception {
  const OperationNotSent();
}
