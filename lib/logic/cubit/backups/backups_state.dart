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
  });

  final bool isInitialized;
  final List<Backup> backups;
  final bool preventActions;
  final Duration refreshTimer;
  final bool refreshing;
  final Duration? autobackupPeriod;
  final BackblazeBucket? backblazeBucket;

  @override
  List<Object> get props => [
        isInitialized,
        backups,
        preventActions,
        refreshTimer,
        refreshing
      ];

  BackupsState copyWith({
    final bool? isInitialized,
    final List<Backup>? backups,
    final bool? preventActions,
    final Duration? refreshTimer,
    final bool? refreshing,
    final Duration? autobackupPeriod,
    final BackblazeBucket? backblazeBucket,
  }) =>
      BackupsState(
        isInitialized: isInitialized ?? this.isInitialized,
        backups: backups ?? this.backups,
        preventActions: preventActions ?? this.preventActions,
        refreshTimer: refreshTimer ?? this.refreshTimer,
        refreshing: refreshing ?? this.refreshing,
        autobackupPeriod: autobackupPeriod ?? this.autobackupPeriod,
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
      );
}
