part of 'backups_cubit.dart';

class BackupsState extends ServerInstallationDependendState {
  const BackupsState({
    this.isInitialized = false,
    this.backups = const [],
    this.preventActions = true,
    this.refreshTimer = const Duration(seconds: 60),
    this.refreshing = true,
    this.autobackupPeriod,
    this.backblazeBucket,
    this.autobackupQuotas,
    this.backupsCredential,
  });

  final bool isInitialized;
  final List<Backup> backups;
  final bool preventActions;
  final Duration refreshTimer;
  final bool refreshing;
  final Duration? autobackupPeriod;
  final BackblazeBucket? backblazeBucket;
  final AutobackupQuotas? autobackupQuotas;
  final BackupsCredential? backupsCredential;

  List<Backup> serviceBackups(final String serviceId) => backups
      .where((final backup) => backup.serviceId == serviceId)
      .toList(growable: false);

  @override
  List<Object> get props => [
        isInitialized,
        backups,
        preventActions,
        refreshTimer,
        refreshing,
      ];

  BackupsState copyWith({
    final bool? isInitialized,
    final List<Backup>? backups,
    final bool? preventActions,
    final Duration? refreshTimer,
    final bool? refreshing,
    final Duration? autobackupPeriod,
    final BackblazeBucket? backblazeBucket,
    final AutobackupQuotas? autobackupQuotas,
    final BackupsCredential? backupsCredential,
  }) =>
      BackupsState(
        isInitialized: isInitialized ?? this.isInitialized,
        backups: backups ?? this.backups,
        preventActions: preventActions ?? this.preventActions,
        refreshTimer: refreshTimer ?? this.refreshTimer,
        refreshing: refreshing ?? this.refreshing,
        backupsCredential: backupsCredential ?? this.backupsCredential,
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
        autobackupQuotas: autobackupQuotas ?? this.autobackupQuotas,
        // The autobackupPeriod might be null, so if the duration is set to 0, we
        // set it to null.
        autobackupPeriod: autobackupPeriod?.inSeconds == 0
            ? null
            : autobackupPeriod ?? this.autobackupPeriod,
      );
}

class BackupsNotFinishedState extends BackupsState {
  BackupsNotFinishedState.fromBackupsState(final BackupsState backupsState)
      : this(
          step: BackupsInitializingStep.hosting,
          isInitialized: false,
          autobackupPeriod: backupsState.autobackupPeriod,
          autobackupQuotas: backupsState.autobackupQuotas,
          backblazeBucket: backupsState.backblazeBucket,
          backups: backupsState.backups,
          backupsCredential: backupsState.backupsCredential,
          preventActions: backupsState.preventActions,
          refreshTimer: backupsState.refreshTimer,
          refreshing: backupsState.refreshing,
        );

  const BackupsNotFinishedState({
    required this.step,
    super.isInitialized = false,
    super.backups = const [],
    super.preventActions = true,
    super.refreshTimer = const Duration(seconds: 60),
    super.refreshing = true,
    super.autobackupPeriod,
    super.backblazeBucket,
    super.autobackupQuotas,
    super.backupsCredential,
  });

  final BackupsInitializingStep step;

  BackupsNotFinishedState copyNotFinishedWith({
    required final BackupsInitializingStep step,
    final bool? isInitialized,
    final List<Backup>? backups,
    final bool? preventActions,
    final Duration? refreshTimer,
    final bool? refreshing,
    final Duration? autobackupPeriod,
    final BackblazeBucket? backblazeBucket,
    final AutobackupQuotas? autobackupQuotas,
    final BackupsCredential? backupsCredential,
  }) =>
      BackupsNotFinishedState(
        isInitialized: isInitialized ?? this.isInitialized,
        backups: backups ?? this.backups,
        preventActions: preventActions ?? this.preventActions,
        refreshTimer: refreshTimer ?? this.refreshTimer,
        refreshing: refreshing ?? this.refreshing,
        backupsCredential: backupsCredential ?? this.backupsCredential,
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
        autobackupQuotas: autobackupQuotas ?? this.autobackupQuotas,
        step: step,
        // The autobackupPeriod might be null, so if the duration is set to 0, we
        // set it to null.
        autobackupPeriod: autobackupPeriod?.inSeconds == 0
            ? null
            : autobackupPeriod ?? this.autobackupPeriod,
      );

  BackupsState finish() => BackupsState(
        isInitialized: true,
        autobackupPeriod: autobackupPeriod,
        autobackupQuotas: autobackupQuotas,
        backblazeBucket: backblazeBucket,
        backups: backups,
        backupsCredential: backupsCredential,
        preventActions: preventActions,
        refreshTimer: refreshTimer,
        refreshing: refreshing,
      );
}

enum BackupsInitializingStep {
  hosting,
  period,
  rotation,
}
