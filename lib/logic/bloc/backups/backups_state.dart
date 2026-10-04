part of 'backups_bloc.dart';

sealed class BackupsState extends Equatable {
  const BackupsState({this.backblazeBucket, this.origin});
  final BackblazeBucket? backblazeBucket;
  final ServerStateOrigin? origin;

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
  const BackupsInitial({super.origin, super.backblazeBucket});
  @override
  List<Object?> get props => [origin];

  @override
  BackupsInitial copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsInitial(
        origin: origin,
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
      );
}

class BackupsLoading extends BackupsState {
  const BackupsLoading({super.origin, super.backblazeBucket});
  @override
  List<Object?> get props => [origin];

  @override
  @Deprecated('Infer the loading status from state')
  bool get refreshing => true;

  @override
  BackupsLoading copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsLoading(
        origin: origin,
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
      );
}

class BackupsUnavailable extends BackupsState {
  const BackupsUnavailable({
    required this.isUnsupported,
    super.origin,
    super.backblazeBucket,
  });

  final bool isUnsupported;

  @override
  List<Object?> get props => [origin, isUnsupported, backblazeBucket];

  @override
  BackupsUnavailable copyWith({
    required final BackblazeBucket backblazeBucket,
  }) => BackupsUnavailable(
    isUnsupported: isUnsupported,
    origin: origin,
    backblazeBucket: backblazeBucket,
  );
}

class BackupsUninitialized extends BackupsState {
  const BackupsUninitialized({super.origin, super.backblazeBucket});
  @override
  List<Object?> get props => [origin];

  @override
  bool get preventActions => false;

  @override
  BackupsUninitialized copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsUninitialized(
        origin: origin,
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
      );
}

class BackupsInitializing extends BackupsState {
  const BackupsInitializing({super.origin, super.backblazeBucket});
  @override
  List<Object?> get props => [origin];

  @override
  BackupsInitializing copyWith({final BackblazeBucket? backblazeBucket}) =>
      BackupsInitializing(
        origin: origin,
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
      );
}

class BackupsInitialized extends BackupsState {
  BackupsInitialized({
    final List<Backup> backups = const [],
    final BackupConfiguration? backupConfig,
    super.origin,
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
  List<Object?> get props => [
    origin,
    _backupList,
    _backupConfig,
    backblazeBucket,
  ];

  @override
  BackupsState copyWith({required final BackblazeBucket backblazeBucket}) =>
      BackupsInitialized(
        backups: backups,
        backupConfig: _backupConfig,
        origin: origin,
        backblazeBucket: backblazeBucket,
      );
}

class BackupsBusy extends BackupsInitialized {
  BackupsBusy.fromState(final BackupsInitialized state)
    : super(
        backups: state.backups,
        backupConfig: state._backupConfig,
        origin: state.origin,
        backblazeBucket: state.backblazeBucket,
      );

  @override
  @Deprecated('Infer the prevent actions status from state')
  bool get preventActions => true;
}
