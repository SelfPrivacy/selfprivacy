// ignore_for_file: always_specify_types

import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/palettes/core_palette.dart';
import 'package:system_theme/system_theme.dart';
import 'package:gtk_theme_fl/gtk_theme_fl.dart';

abstract class AppThemeFactory {
  AppThemeFactory._();

  static Future<ThemeData> create(
      {required final bool isDark, required final Color fallbackColor,}) => _createAppTheme(
      isDark: isDark,
      fallbackColor: fallbackColor,
    );

  static Future<ThemeData> _createAppTheme({
    required final Color fallbackColor,
    final bool isDark = false,
  }) async {
    ColorScheme? gtkColorsScheme;
    final Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    final ColorScheme? dynamicColorsScheme = await _getDynamicColors(brightness);

    if (Platform.isLinux) {
      final GtkThemeData themeData = await GtkThemeData.initialize();
      final bool isGtkDark =
          Color(themeData.theme_bg_color).computeLuminance() < 0.5;
      final bool isInverseNeeded = isGtkDark != isDark;
      gtkColorsScheme = ColorScheme.fromSeed(
        seedColor: Color(themeData.theme_selected_bg_color),
        brightness: brightness,
        background: isInverseNeeded ? null : Color(themeData.theme_bg_color),
        surface: isInverseNeeded ? null : Color(themeData.theme_base_color),
      );
    }

    final SystemAccentColor accentColor = SystemAccentColor(fallbackColor);

    try {
      await accentColor.load();
    } on MissingPluginException catch (e) {
      print('_createAppTheme: ${e.message}');
    }

    final ColorScheme fallbackColorScheme = ColorScheme.fromSeed(
      seedColor: accentColor.accent,
      brightness: brightness,
    );

    final ColorScheme colorScheme =
        dynamicColorsScheme ?? gtkColorsScheme ?? fallbackColorScheme;

    final Typography appTypography = Typography.material2021();

    final ThemeData materialThemeData = ThemeData(
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      typography: appTypography,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    );

    return materialThemeData;
  }

  static Future<ColorScheme?> _getDynamicColors(final Brightness brightness) {
    try {
      return DynamicColorPlugin.getCorePalette().then(
          (final CorePalette? corePallet) => corePallet?.toColorScheme(brightness: brightness),);
    } on PlatformException {
      return Future.value(null);
    }
  }
}
