import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/palettes/core_palette.dart';

abstract class AppThemeFactory {
  AppThemeFactory._();

  static Future<ThemeData> create({
    required final bool isDark,
    required final Color fallbackColor,
  }) =>
      _createAppTheme(
        isDark: isDark,
        fallbackColor: fallbackColor,
      );

  static Future<ThemeData> _createAppTheme({
    required final Color fallbackColor,
    final bool isDark = false,
  }) async {
    final Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    final ColorScheme? dynamicColorsScheme =
        await _getDynamicColors(brightness);

    final Color? accentColor = await _getAccentColor();

    final ColorScheme fallbackColorScheme = ColorScheme.fromSeed(
      seedColor: accentColor ?? fallbackColor,
      brightness: brightness,
    );

    final ColorScheme colorScheme = dynamicColorsScheme ?? fallbackColorScheme;

    final Typography appTypography = Typography.material2021();

    final ThemeData materialThemeData = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      typography: appTypography,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.background,
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    return materialThemeData;
  }

  static Future<ColorScheme?> _getDynamicColors(final Brightness brightness) {
    try {
      return DynamicColorPlugin.getCorePalette().then(
        (final corePallete) =>
            corePallete?.toColorScheme(brightness: brightness),
      );
    } on PlatformException {
      return Future.value(null);
    }
  }

  static Future<Color?> _getAccentColor() {
    try {
      return DynamicColorPlugin.getAccentColor();
    } on PlatformException {
      return Future.value(null);
    }
  }

  static Future<CorePalette?> getCorePalette() async {
    try {
      return await DynamicColorPlugin.getCorePalette();
    } on PlatformException {
      return Future.value(null);
    }
  }
}
