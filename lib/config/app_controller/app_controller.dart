import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart'
    as color_utils;
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/localization.dart';
import 'package:selfprivacy/config/preferences_repository/preferences_repository.dart';

/// A class that many Widgets can interact with to read current app
/// configuration, update it, or listen to its changes.
///
/// AppController uses repo to change persistent data.
class AppController with ChangeNotifier {
  AppController(this._repo);

  /// repo encapsulates retrieval and storage of preferences
  final PreferencesRepository _repo;

  /// TODO: to be removed or changed
  late final ApiConfigModel _apiConfigModel = getIt.get<ApiConfigModel>();

  bool _loaded = false;
  bool get loaded => _loaded;

  // localization
  late Locale _locale;
  Locale get locale => _locale;
  late List<Locale> _supportedLocales;
  List<Locale> get supportedLocales => _supportedLocales;

  // theme
  late ThemeData _lightTheme;
  ThemeData get lightTheme => _lightTheme;
  late ThemeData _darkTheme;
  ThemeData get darkTheme => _darkTheme;
  late color_utils.CorePalette _corePalette;
  color_utils.CorePalette get corePalette => _corePalette;

  late bool _systemThemeModeActive;
  bool get systemThemeModeActive => _systemThemeModeActive;

  late bool _darkThemeModeActive;
  bool get darkThemeModeActive => _darkThemeModeActive;

  ThemeMode get themeMode => systemThemeModeActive
      ? ThemeMode.system
      : darkThemeModeActive
          ? ThemeMode.dark
          : ThemeMode.light;

  late bool _shouldShowOnboarding;
  bool get shouldShowOnboarding => _shouldShowOnboarding;

  Future<void> init({
    // required final AppPreferencesRepository repo,
    required final ThemeData lightThemeData,
    required final ThemeData darkThemeData,
    required final color_utils.CorePalette colorPalette,
  }) async {
    // _repo = repo;

    await Future.wait(<Future>[
      // load locale
      () async {
        _supportedLocales = [
          Localization.systemLocale,
          ...await _repo.getSupportedLocales(),
        ];

        _locale = await _repo.getActiveLocale();
        if (_locale != Localization.systemLocale) {
          // preset value to other state holders
          await _apiConfigModel.setLocaleCode(_locale.languageCode);
          await _repo.setDelegateLocale(_locale);
        }
      }(),

      // load theme mode && initialize theme
      () async {
        _lightTheme = lightThemeData;
        _darkTheme = darkThemeData;
        _corePalette = colorPalette;
        _darkThemeModeActive = await _repo.getDarkThemeModeFlag();
        _systemThemeModeActive = await _repo.getSystemThemeModeFlag();
      }(),

      // load onboarding flag
      () async {
        _shouldShowOnboarding = await _repo.getShouldShowOnboarding();
      }(),
    ]);

    _loaded = true;
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  // updateRepoReference
  Future<void> setShouldShowOnboarding(final bool newValue) async {
    // Do not perform any work if new and old flag values are identical
    if (newValue == shouldShowOnboarding) {
      return;
    }

    // Store the flag in memory
    _shouldShowOnboarding = newValue;
    notifyListeners();

    // Persist the change
    await _repo.setShouldShowOnboarding(newValue);
  }

  Future<void> setSystemThemeModeFlag(final bool newValue) async {
    // Do not perform any work if new and old ThemeMode are identical
    if (systemThemeModeActive == newValue) {
      return;
    }

    // Store the new ThemeMode in memory
    _systemThemeModeActive = newValue;

    // Inform listeners a change has occurred.
    notifyListeners();

    // Persist the change
    await _repo.setSystemModeFlag(newValue);
  }

  Future<void> setDarkThemeModeFlag(final bool newValue) async {
    // Do not perform any work if new and old ThemeMode are identical
    if (darkThemeModeActive == newValue) {
      return;
    }

    // Store the new ThemeMode in memory
    _darkThemeModeActive = newValue;

    // Inform listeners a change has occurred.
    notifyListeners();

    // Persist the change
    await _repo.setDarkThemeModeFlag(newValue);
  }

  Future<void> setLocale(final Locale newLocale) async {
    // Do not perform any work if new and old Locales are identical
    if (newLocale == _locale) {
      return;
    }

    // Store the new Locale in memory
    _locale = newLocale;

    if (newLocale == Localization.systemLocale) {
      return resetLocale();
    }

    /// update locale delegate, which in turn should update deps
    await _repo.setDelegateLocale(newLocale);

    // Persist the change
    await _repo.setActiveLocale(newLocale);
    // Update other locale holders
    await _apiConfigModel.setLocaleCode(newLocale.languageCode);
  }

  Future<void> resetLocale() async {
    /// update locale delegate, which in turn should update deps
    await _repo.resetDelegateLocale();

    // Persist the change
    await _repo.resetActiveLocale();
    // Update other locale holders
    await _apiConfigModel.resetLocaleCode();
  }
}
