part of 'backups_bloc.dart';

sealed class BackupsState extends Equatable {
  BackupsState({this.backblazeBucket});
  final apiConnectionRepository = getIt<ApiConnectionRepository>();
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
  BackupsInitial({super.backblazeBucket});
  @override
  List<Object> get props => [];

  @override
  BackupsInitial copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsInitial(backblazeBucket: backblazeBucket ?? this.backblazeBucket);
}

class BackupsLoading extends BackupsState {
  BackupsLoading({super.backblazeBucket});
  @override
  List<Object> get props => [];

  @override
  @Deprecated('Infer the loading status from state')
  bool get refreshing => true;

  @override
  BackupsLoading copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsLoading(backblazeBucket: backblazeBucket ?? this.backblazeBucket);
}

class BackupsUnititialized extends BackupsState {
  BackupsUnititialized({super.backblazeBucket});
  @override
  List<Object> get props => [];

  @override
  bool get preventActions => false;

  @override
  BackupsUnititialized copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsUnititialized(
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
      );
}

class BackupsInitializing extends BackupsState {
  BackupsInitializing({super.backblazeBucket});
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
  }) : _backupsHashCode = Object.hashAll(backups),
       _backupConfigHashCode = Object.hashAll([backupConfig]);

  final int _backupsHashCode;
  final int _backupConfigHashCode;

  List<Backup> get _backupList =>
      apiConnectionRepository.apiData.backups.data ?? [];

  BackupConfiguration? get _backupConfig =>
      apiConnectionRepository.apiData.backupConfig.data;

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
  List<Backup> get backups {
    try {
      final List<Backup> list =
          _backupList..sort((final a, final b) => b.time.compareTo(a.time));
      return list;
    } catch (_) {
      return _backupList;
    }
  }

  @override
  List<Backup> serviceBackups(final String serviceId) => backups
      .where((final backup) => backup.serviceId == serviceId)
      .toList(growable: false);

  @override
  List<Object> get props => [_backupsHashCode, _backupConfigHashCode];

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

  @override
  List<Object> get props => [];
}
