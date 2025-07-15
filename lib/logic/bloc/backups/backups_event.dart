part of 'backups_bloc.dart';

sealed class BackupsEvent extends Equatable {
  const BackupsEvent();
}

class BackupsServerLoaded extends BackupsEvent {
  const BackupsServerLoaded();

  @override
  List<Object?> get props => [];
}

class BackupsServerReset extends BackupsEvent {
  const BackupsServerReset();

  @override
  List<Object?> get props => [];
}

class InitializeBackupsRepository extends BackupsEvent {
  const InitializeBackupsRepository(this.credential);

  final BackupsCredential credential;

  @override
  List<Object?> get props => [];
}

class BackupsStateChanged extends BackupsEvent {
  const BackupsStateChanged(this.backups, this.backupConfiguration);

  final List<Backup> backups;
  final BackupConfiguration? backupConfiguration;

  @override
  List<Object?> get props => [backups, backupConfiguration];
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
