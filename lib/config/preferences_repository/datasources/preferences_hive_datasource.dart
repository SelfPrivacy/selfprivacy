import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/config/preferences_repository/datasources/preferences_datasource.dart';

/// app preferences data source hive implementation
class PreferencesHiveDataSource implements PreferencesDataSource {
  final Box _appSettingsBox = Hive.box(BNames.appSettingsBox);

  @override
  Future<bool> getOnboardingFlag() async =>
      _appSettingsBox.get(BNames.shouldShowOnboarding, defaultValue: true);

  @override
  Future<void> setOnboardingFlag({required final bool shouldOnboard}) =>
      _appSettingsBox.put(BNames.shouldShowOnboarding, shouldOnboard);

  @override
  Future<bool?> getSystemThemeModeFlag() async =>
      _appSettingsBox.get(BNames.systemThemeModeOn);

  @override
  Future<void> setSystemThemeModeFlag({required final bool useSystem}) =>
      _appSettingsBox.put(BNames.systemThemeModeOn, useSystem);

  @override
  Future<bool?> getDarkThemeModeFlag() async =>
      _appSettingsBox.get(BNames.darkThemeModeOn);

  @override
  Future<void> setDarkThemeModeFlag({required final bool useDark}) =>
      _appSettingsBox.put(BNames.darkThemeModeOn, useDark);

  @override
  Future<String?> getLocale() async => _appSettingsBox.get(BNames.appLocale);

  @override
  Future<void> setLocale(final String? newLocale) =>
      newLocale == null
          ? _appSettingsBox.delete(BNames.appLocale)
          : _appSettingsBox.put(BNames.appLocale, newLocale);
}
