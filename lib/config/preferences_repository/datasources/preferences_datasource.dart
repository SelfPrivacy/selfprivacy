/// abstraction for manipulation of stored app preferences
abstract class PreferencesDataSource {
  /// should onboarding be shown
  Future<bool> getOnboardingFlag();

  /// should onboarding be shown
  Future<void> setOnboardingFlag({required final bool shouldOnboard});

  // TODO(Aliaksei): should probably deprecate the following, instead add the
  // getThemeMode and setThemeMode methods, which store one value instead of
  // flags.

  /// should system theme mode be enabled
  Future<bool?> getSystemThemeModeFlag();

  /// should system theme mode be enabled
  Future<void> setSystemThemeModeFlag({required final bool useSystem});

  /// should dark theme be enabled
  Future<bool?> getDarkThemeModeFlag();

  /// should dark theme be enabled
  Future<void> setDarkThemeModeFlag({required final bool useDark});

  /// locale, as set by user
  ///
  ///
  /// when null, app takes system locale
  Future<String?> getLocale();

  /// locale, as set by user
  Future<void> setLocale(final String? newLocale);
}
