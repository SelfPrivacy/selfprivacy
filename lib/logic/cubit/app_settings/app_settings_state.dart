part of 'app_settings_cubit.dart';

class AppSettingsState extends Equatable {
  const AppSettingsState({
    required this.isDarkModeOn,
    required this.isAutoDarkModeOn,
    required this.isOnboardingShowing,
    this.corePalette,
  });

  final bool isDarkModeOn;
  final bool isAutoDarkModeOn;
  final bool isOnboardingShowing;
  final color_utils.CorePalette? corePalette;

  AppSettingsState copyWith({
    final bool? isDarkModeOn,
    final bool? isAutoDarkModeOn,
    final bool? isOnboardingShowing,
    final color_utils.CorePalette? corePalette,
  }) =>
      AppSettingsState(
        isDarkModeOn: isDarkModeOn ?? this.isDarkModeOn,
        isAutoDarkModeOn: isAutoDarkModeOn ?? this.isAutoDarkModeOn,
        isOnboardingShowing: isOnboardingShowing ?? this.isOnboardingShowing,
        corePalette: corePalette ?? this.corePalette,
      );

  color_utils.CorePalette get corePaletteOrDefault =>
      corePalette ?? color_utils.CorePalette.of(BrandColors.primary.value);

  @override
  List<dynamic> get props =>
      [isDarkModeOn, isAutoDarkModeOn, isOnboardingShowing, corePalette];
}
