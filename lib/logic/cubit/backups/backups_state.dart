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
  });

  final bool isInitialized;
  final List<Backup> backups;
  final bool preventActions;
  final Duration refreshTimer;
  final bool refreshing;
  final Duration? autobackupPeriod;
  final BackblazeBucket? backblazeBucket;
  final AutobackupQuotas? autobackupQuotas;

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
  }) =>
      BackupsState(
        isInitialized: isInitialized ?? this.isInitialized,
        backups: backups ?? this.backups,
        preventActions: preventActions ?? this.preventActions,
        refreshTimer: refreshTimer ?? this.refreshTimer,
        refreshing: refreshing ?? this.refreshing,
        // The autobackupPeriod might be null, so if the duration is set to 0, we
        // set it to null.
        autobackupPeriod: autobackupPeriod?.inSeconds == 0
            ? null
            : autobackupPeriod ?? this.autobackupPeriod,
        backblazeBucket: backblazeBucket ?? this.backblazeBucket,
        autobackupQuotas: autobackupQuotas ?? this.autobackupQuotas,
      );
}
