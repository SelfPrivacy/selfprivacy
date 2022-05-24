part of 'backups_cubit.dart';

class BackupsState extends ServerInstallationDependendState {
  const BackupsState({
    this.isInitialized = false,
    this.backups = const [],
    this.progress = 0.0,
    this.status = BackupStatusEnum.noKey,
    this.preventActions = true,
    this.error = '',
    this.refreshTimer = const Duration(seconds: 60),
    this.refreshing = true,
  });

  final bool isInitialized;
  final List<Backup> backups;
  final double progress;
  final BackupStatusEnum status;
  final bool preventActions;
  final String error;
  final Duration refreshTimer;
  final bool refreshing;

  @override
  List<Object> get props => [
        isInitialized,
        backups,
        progress,
        preventActions,
        status,
        error,
        refreshTimer,
        refreshing
      ];

  BackupsState copyWith({
    bool? isInitialized,
    List<Backup>? backups,
    double? progress,
    BackupStatusEnum? status,
    bool? preventActions,
    String? error,
    Duration? refreshTimer,
    bool? refreshing,
  }) =>
      BackupsState(
        isInitialized: isInitialized ?? this.isInitialized,
        backups: backups ?? this.backups,
        progress: progress ?? this.progress,
        status: status ?? this.status,
        preventActions: preventActions ?? this.preventActions,
        error: error ?? this.error,
        refreshTimer: refreshTimer ?? this.refreshTimer,
        refreshing: refreshing ?? this.refreshing,
      );
}
