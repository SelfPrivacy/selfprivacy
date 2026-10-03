part of 'backups_bloc.dart';

sealed class BackupsEvent extends Equatable {
  const BackupsEvent();
}

class _BackupsObserved extends BackupsEvent {
  const _BackupsObserved(this.observation);
  final ConnectionObservation<BackupsSnapshot> observation;
  @override
  List<Object?> get props => [observation];
}

class _BackupsAction<T extends BackupsEvent> extends BackupsEvent {
  const _BackupsAction(this.event, this.origin);
  final T event;
  final ServerStateOrigin? origin;
  @override
  List<Object?> get props => [event, origin];
}

class InitializeBackupsRepository extends BackupsEvent {
  const InitializeBackupsRepository(this.credential);

  final BackupsCredential credential;

  @override
  List<Object?> get props => [];
}

class ForceSnapshotListUpdate extends BackupsEvent {
  const ForceSnapshotListUpdate();

  @override
  List<Object?> get props => [];
}

class CreateBackups extends BackupsEvent {
  const CreateBackups(this.services);

  final List<Service> services;

  @override
  List<Object?> get props => [services];
}

class RestoreBackup extends BackupsEvent {
  const RestoreBackup(this.backupId, this.restoreStrategy);

  final String backupId;
  final BackupRestoreStrategy restoreStrategy;

  @override
  List<Object?> get props => [backupId, restoreStrategy];
}

class SetAutobackupPeriod extends BackupsEvent {
  const SetAutobackupPeriod(this.period);

  final Duration? period;

  @override
  List<Object?> get props => [period];
}

class SetAutobackupQuotas extends BackupsEvent {
  const SetAutobackupQuotas(this.quotas);

  final AutobackupQuotas quotas;

  @override
  List<Object?> get props => [quotas];
}

class ForgetSnapshot extends BackupsEvent {
  const ForgetSnapshot(this.backupId);

  final String backupId;

  @override
  List<Object?> get props => [backupId];
}

class RemoveBackupsRepository extends BackupsEvent {
  const RemoveBackupsRepository();

  @override
  List<Object?> get props => [];
}
