import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/config/preferences_repository/datasources/preferences_datasource.dart';

/// app preferences data source hive implementation
class PreferencesHiveDataSource implements PreferencesDataSource {
  final Box _appSettingsBox = Hive.box(BNames.appSettingsBox);

  @override
  Future<bool> getOnboardingFlag() async =>
      _appSettingsBox.get(BNames.shouldShowOnboarding, defaultValue: true);

  @override
  Future<void> setOnboardingFlag(final bool newValue) async =>
      _appSettingsBox.put(BNames.shouldShowOnboarding, newValue);

  @override
  Future<bool?> getSystemThemeModeFlag() async =>
      _appSettingsBox.get(BNames.systemThemeModeOn);

  @override
  Future<void> setSystemThemeModeFlag(final bool newValue) async =>
      _appSettingsBox.put(BNames.systemThemeModeOn, newValue);

  @override
  Future<bool?> getDarkThemeModeFlag() async =>
      _appSettingsBox.get(BNames.darkThemeModeOn);

  @override
  Future<void> setDarkThemeModeFlag(final bool newValue) async =>
      _appSettingsBox.put(BNames.darkThemeModeOn, newValue);

  @override
  Future<String?> getLocale() async => _appSettingsBox.get(BNames.appLocale);

  @override
  Future<void> setLocale(final String? newLocale) async => newLocale == null
      ? _appSettingsBox.delete(BNames.appLocale)
      : _appSettingsBox.put(BNames.appLocale, newLocale);
}
