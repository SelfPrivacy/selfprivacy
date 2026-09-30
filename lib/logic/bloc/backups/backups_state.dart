part of 'backups_bloc.dart';

sealed class BackupsState extends Equatable {
  const BackupsState({this.backblazeBucket});
  final BackblazeBucket? backblazeBucket;

  @Deprecated('Infer the initializations status from state')
  bool get isInitialized => false;

  @Deprecated('Infer the loading status from state')
  bool get refreshing => false;

  @Deprecated('Infer the prevent actions status from state')
  bool get preventActions => true;

  List<Backup> get backups => [];

  List<Backup> serviceBackups(final String serviceId) => [];

  Duration? timeSinceLastBackup() => null;

  Duration? get autobackupPeriod => null;

  AutobackupQuotas? get autobackupQuotas => null;

  String? get encryptionKey => null;

  BackupsState copyWith({required final BackblazeBucket backblazeBucket});
}

class BackupsInitial extends BackupsState {
  const BackupsInitial({super.backblazeBucket});
  @override
  List<Object> get props => [];

  @override
  BackupsInitial copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsInitial(backblazeBucket: backblazeBucket ?? this.backblazeBucket);
}

class BackupsLoading extends BackupsState {
  const BackupsLoading({super.backblazeBucket});
  @override
  List<Object> get props => [];

  @override
  @Deprecated('Infer the loading status from state')
  bool get refreshing => true;

  @override
  BackupsLoading copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsLoading(backblazeBucket: backblazeBucket ?? this.backblazeBucket);
}

class BackupsUninitialized extends BackupsState {
  const BackupsUninitialized({super.backblazeBucket});
  @override
  List<Object> get props => [];

  @override
  bool get preventActions => false;

  @override
  BackupsUninitialized copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsUninitialized(
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
      );
}

class BackupsInitializing extends BackupsState {
  const BackupsInitializing({super.backblazeBucket});
  @override
  List<Object> get props => [];

  @override
  BackupsInitializing copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsInitializing(
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
      );
}

class BackupsInitialized extends BackupsState {
  BackupsInitialized({
    final List<Backup> backups = const [],
    final BackupConfiguration? backupConfig,
    super.backblazeBucket,
  }) : _backupList = List.unmodifiable(
         List<Backup>.of(backups)
           ..sort((final a, final b) => b.time.compareTo(a.time)),
       ),
       _backupConfig = backupConfig;

  final List<Backup> _backupList;
  final BackupConfiguration? _backupConfig;

  @override
  AutobackupQuotas? get autobackupQuotas => _backupConfig?.autobackupQuotas;

  @override
  String? get encryptionKey => _backupConfig?.encryptionKey;

  @override
  Duration? get autobackupPeriod =>
      _backupConfig?.autobackupPeriod?.inMinutes == 0
      ? null
      : _backupConfig?.autobackupPeriod;

  @override
  Duration? timeSinceLastBackup() {
    if (backups.isEmpty) {
      return null;
    }
    final timeNow = DateTime.now();
    final timeLastBackup = backups.first.time;
    final delta = timeNow.difference(timeLastBackup);
    return Duration(seconds: delta.inSeconds);
  }

  @override
  @Deprecated('Infer the initializations status from state')
  bool get isInitialized => true;

  @override
  @Deprecated('Infer the prevent actions status from state')
  bool get preventActions => false;

  @override
  List<Backup> get backups => _backupList;

  @override
  List<Backup> serviceBackups(final String serviceId) => backups
      .where((final backup) => backup.serviceId == serviceId)
      .toList(growable: false);

  @override
  List<Object?> get props => [_backupList, _backupConfig, backblazeBucket];

  @override
  BackupsState copyWith({required final BackblazeBucket backblazeBucket}) =>
      BackupsInitialized(
        backups: backups,
        backupConfig: _backupConfig,
        backblazeBucket: backblazeBucket,
      );
}

class BackupsBusy extends BackupsInitialized {
  BackupsBusy.fromState(final BackupsInitialized state)
    : super(
        backups: state.backups,
        backupConfig: state._backupConfig,
        backblazeBucket: state.backblazeBucket,
      );

  @override
  @Deprecated('Infer the prevent actions status from state')
  bool get preventActions => true;
}
