// ignore_for_file: always_specify_types

part of 'app_settings_cubit.dart';

class AppSettingsState extends Equatable {
  const AppSettingsState({
    required this.isDarkModeOn,
    required this.isOnboardingShowing,
  });

  final bool isDarkModeOn;
  final bool isOnboardingShowing;

  AppSettingsState copyWith({final isDarkModeOn, final isOnboardingShowing}) =>
      AppSettingsState(
        isDarkModeOn: isDarkModeOn ?? this.isDarkModeOn,
        isOnboardingShowing: isOnboardingShowing ?? this.isOnboardingShowing,
      );

  @override
  List<Object> get props => [isDarkModeOn, isOnboardingShowing];
}
