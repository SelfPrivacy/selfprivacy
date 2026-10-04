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
  createBackups,
  restoreBackup,
  moveServices,
  migrateVolumes,
  applyChanges,
  rebootServer,
  upgradeServer,
  collectGarbage,
  initializeBackups,
  removeBackups,
  resizeVolume,
  generateDeviceKey,
  generateRecoveryKey,
  generatePasswordResetLink,
  rotateToken;

  String get translationKey => switch (this) {
    rebootServer => 'jobs.reboot_server',
    upgradeServer => 'jobs.start_server_upgrade',
    collectGarbage => 'jobs.collect_nix_garbage',
    initializeBackups => 'backup.initialize',
    removeBackups => 'backup.detach_repository',
    resizeVolume => 'storage.extending_volume_title',
    manageUsers => 'operations.kind.manage_users',
    manageDevices => 'operations.kind.manage_devices',
    manageServices || moveServices => 'operations.kind.manage_services',
    manageBackups ||
    createBackups ||
    restoreBackup => 'operations.kind.manage_backups',
    manageVolumes || migrateVolumes => 'operations.kind.manage_volumes',
    manageSettings => 'operations.kind.manage_settings',
    manageJobs => 'operations.kind.manage_jobs',
    applyChanges => 'operations.kind.apply_changes',
    generateDeviceKey => 'operations.kind.generate_device_key',
    generateRecoveryKey => 'operations.kind.generate_recovery_key',
    generatePasswordResetLink => 'operations.kind.generate_password_reset_link',
    rotateToken => 'operations.kind.rotate_token',
  };
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
  String get translationKey => this == notSent
      ? 'operations.status.not_sent'
      : 'operations.status.$name';
}

enum OperationReason {
  rotationFailed,
  connectionReplaced,
  cancelled,
  unavailable;

  String get translationKey => switch (this) {
    rotationFailed => 'operations.reason.rotation_failed',
    connectionReplaced => 'operations.reason.connection_replaced',
    cancelled => 'operations.reason.cancelled',
    unavailable => 'operations.reason.unavailable',
  };
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
        ServerMutationOutcome.confirmed when job != null =>
          'operations.status.accepted',
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

  OperationStep withStatus(
    final OperationStatus status, {
    final String? messageKey,
    final String? jobId,
  }) => OperationStep(
    id: id,
    titleKey: titleKey,
    status: status,
    target: target,
    jobId: jobId ?? this.jobId,
    messageKey: messageKey ?? status.translationKey,
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
