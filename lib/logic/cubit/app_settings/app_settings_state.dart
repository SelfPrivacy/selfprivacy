part of 'app_settings_cubit.dart';

class AppSettingsState extends Equatable {
  const AppSettingsState({
    required this.isDarkModeOn,
    required this.isOnbordingShowing,
  });

  final bool isDarkModeOn;
  final bool isOnbordingShowing;

  AppSettingsState copyWith({isDarkModeOn, isOnbordingShowing}) =>
      AppSettingsState(
        isDarkModeOn: isDarkModeOn ?? this.isDarkModeOn,
        isOnbordingShowing: isOnbordingShowing ?? this.isOnbordingShowing,
      );

  @override
  List<Object> get props => [isDarkModeOn, isOnbordingShowing];
}
