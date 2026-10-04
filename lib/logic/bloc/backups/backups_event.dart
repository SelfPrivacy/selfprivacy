part of 'backups_bloc.dart';

sealed class BackupsEvent extends Equatable {
  const BackupsEvent({this.origin});
  final ServerStateOrigin? origin;
}

class _BackupsObserved extends BackupsEvent {
  const _BackupsObserved(this.observation);
  final ConnectionObservation<BackupsSnapshot> observation;
  @override
  List<Object?> get props => [origin, observation];
}

class InitializeBackupsRepository extends BackupsEvent {
  const InitializeBackupsRepository(this.credential, {required super.origin});

  final BackupsCredential credential;

  @override
  List<Object?> get props => [origin];
}

class ForceSnapshotListUpdate extends BackupsEvent {
  const ForceSnapshotListUpdate({required super.origin});

  @override
  List<Object?> get props => [origin];
}

class CreateBackups extends BackupsEvent {
  const CreateBackups(this.services, {required super.origin});

  final List<Service> services;

  @override
  List<Object?> get props => [origin, services];
}

class RestoreBackup extends BackupsEvent {
  const RestoreBackup(
    this.backupId,
    this.restoreStrategy, {
    required super.origin,
  });

  final String backupId;
  final BackupRestoreStrategy restoreStrategy;

  @override
  List<Object?> get props => [origin, backupId, restoreStrategy];
}

class SetAutobackupPeriod extends BackupsEvent {
  const SetAutobackupPeriod(this.period, {required super.origin});

  final Duration? period;

  @override
  List<Object?> get props => [origin, period];
}

class SetAutobackupQuotas extends BackupsEvent {
  const SetAutobackupQuotas(this.quotas, {required super.origin});

  final AutobackupQuotas quotas;

  @override
  List<Object?> get props => [origin, quotas];
}

class ForgetSnapshot extends BackupsEvent {
  const ForgetSnapshot(this.backupId, {required super.origin});

  final String backupId;

  @override
  List<Object?> get props => [origin, backupId];
}

class RemoveBackupsRepository extends BackupsEvent {
  const RemoveBackupsRepository({required super.origin});

  @override
  List<Object?> get props => [origin];
}
