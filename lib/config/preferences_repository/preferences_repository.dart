import 'dart:async';

import 'package:flutter/material.dart';
import 'package:selfprivacy/config/preferences_repository/datasources/preferences_datasource.dart';

class PreferencesRepository {
  const PreferencesRepository({
    required this.dataSource,
    required this.getSupportedLocales,
    required this.getDelegateLocale,
    required this.setDelegateLocale,
  });

  final PreferencesDataSource dataSource;

  /// easy localizations don't expose type of localization provider,
  /// so it needs to be this crutchy (I could've created one more class-wrapper,
  /// containing needed functions, but perceive it as boilerplate, because we
  /// don't need additional encapsulation level here)
  final FutureOr<void> Function(Locale) setDelegateLocale;
  final FutureOr<List<Locale>> Function() getSupportedLocales;
  final FutureOr<Locale> Function() getDelegateLocale;

  Future<bool> getSystemThemeModeFlag() async =>
      (await dataSource.getSystemThemeModeFlag()) ?? true;

  Future<void> setSystemThemeModeFlag(final bool newValue) async =>
      dataSource.setSystemThemeModeFlag(newValue);

  Future<bool> getDarkThemeModeFlag() async =>
      (await dataSource.getDarkThemeModeFlag()) ?? false;

  Future<void> setDarkThemeModeFlag(final bool newValue) async =>
      dataSource.setDarkThemeModeFlag(newValue);

  Future<void> setSystemModeFlag(final bool newValue) async =>
      dataSource.setSystemThemeModeFlag(newValue);

  // Future<ThemeMode> getThemeMode() async {
  //   final themeMode = await dataSource.getThemeMode()?? ThemeMode.system;
  // }
  //
  // Future<void> setThemeMode(final ThemeMode newThemeMode) =>
  //     dataSource.setThemeMode(newThemeMode);

  Future<List<Locale>> supportedLocales() async => getSupportedLocales();

  Future<Locale> getActiveLocale() async {
    Locale? chosenLocale;

    final String? storedLocaleCode = await dataSource.getLocale();
    if (storedLocaleCode != null) {
      chosenLocale = Locale(storedLocaleCode);
    }

    // when it's null fallback on delegate locale
    chosenLocale ??= await getDelegateLocale();

    return chosenLocale;
  }

  Future<void> setActiveLocale(final Locale newLocale) async {
    await dataSource.setLocale(newLocale.toString());
  }

  /// true when we need to show onboarding
  Future<bool> getShouldShowOnboarding() async =>
      dataSource.getOnboardingFlag();

  /// true when we need to show onboarding
  Future<void> setShouldShowOnboarding(final bool newValue) =>
      dataSource.setOnboardingFlag(newValue);
}
