import 'dart:async';

import 'package:flutter/material.dart';
import 'package:selfprivacy/config/localization.dart';
import 'package:selfprivacy/config/preferences_repository/datasources/preferences_datasource.dart';

class PreferencesRepository {
  const PreferencesRepository({
    required this.dataSource,
    required this.getSupportedLocales,
    required this.getDelegateLocale,
    required this.setDelegateLocale,
    required this.resetDelegateLocale,
  });

  final PreferencesDataSource dataSource;

  /// easy localizations don't expose type of localization provider,
  /// so it needs to be this crutchy (I could've created one more class-wrapper,
  /// containing needed functions, but perceive it as boilerplate, because we
  /// don't need additional encapsulation level here)
  final Future<void> Function(Locale) setDelegateLocale;
  final Future<void> Function() resetDelegateLocale;
  final List<Locale> Function() getSupportedLocales;
  final Locale Function() getDelegateLocale;

  Future<bool> getSystemThemeModeFlag() async =>
      (await dataSource.getSystemThemeModeFlag()) ?? true;

  Future<bool> getDarkThemeModeFlag() async =>
      (await dataSource.getDarkThemeModeFlag()) ?? false;

  Future<void> setDarkThemeModeFlag({required final bool useDark}) =>
      dataSource.setDarkThemeModeFlag(useDark: useDark);

  Future<void> setSystemThemeModeFlag({required final bool useSystem}) =>
      dataSource.setSystemThemeModeFlag(useSystem: useSystem);

  Future<List<Locale>> supportedLocales() async => getSupportedLocales();

  Future<Locale> getActiveLocale() async {
    Locale? chosenLocale;

    final String? storedLocaleCode = await dataSource.getLocale();
    if (storedLocaleCode != null) {
      chosenLocale = Locale(storedLocaleCode);
    }

    return chosenLocale ?? Localization.systemLocale;
  }

  Future<void> setActiveLocale(final Locale newLocale) async {
    await dataSource.setLocale(newLocale.toString());
  }

  Future<void> resetActiveLocale() async {
    await dataSource.setLocale(null);
  }

  /// true when we need to show onboarding
  Future<bool> getShouldShowOnboarding() => dataSource.getOnboardingFlag();

  /// true when we need to show onboarding
  Future<void> setShouldShowOnboarding({required final bool shouldOnboard}) =>
      dataSource.setOnboardingFlag(shouldOnboard: shouldOnboard);
}
