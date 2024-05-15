/// abstraction for manipulation of stored app preferences
abstract class PreferencesDataSource {
  /// should onboarding be shown
  Future<bool> getOnboardingFlag();

  /// should onboarding be shown
  Future<void> setOnboardingFlag(final bool newValue);

  // TODO: should probably deprecate the following, instead add the
  // getThemeMode and setThemeMode methods, which store one value instead of
  // flags.

  /// should system theme mode be enabled
  Future<bool?> getSystemThemeModeFlag();

  /// should system theme mode be enabled
  Future<void> setSystemThemeModeFlag(final bool newValue);

  /// should dark theme be enabled
  Future<bool?> getDarkThemeModeFlag();

  /// should dark theme be enabled
  Future<void> setDarkThemeModeFlag(final bool newValue);

  /// locale, as set by user
  ///
  ///
  /// when null, app takes system locale
  Future<String?> getLocale();

  /// locale, as set by user
  ///
  ///
  /// when null, app takes system locale
  Future<void> setLocale(final String newLocale);
}
