import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/palettes/core_palette.dart';

abstract class AppThemeFactory {
  AppThemeFactory._();

  static Future<ThemeData> create({
    required final bool isDark,
    required final Color fallbackColor,
  }) => _createAppTheme(isDark: isDark, fallbackColor: fallbackColor);

  static Future<ThemeData> _createAppTheme({
    required final Color fallbackColor,
    final bool isDark = false,
  }) async {
    final Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    final ColorScheme? dynamicColorsScheme = await _getDynamicColors(
      brightness,
    );

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
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    return materialThemeData;
  }

  static Future<ColorScheme?> _getDynamicColors(
    final Brightness brightness,
  ) async {
    List<Color> extractAdditionalColours(final ColorScheme scheme) => [
      scheme.surface,
      scheme.surfaceDim,
      scheme.surfaceBright,
      scheme.surfaceContainerLowest,
      scheme.surfaceContainerLow,
      scheme.surfaceContainer,
      scheme.surfaceContainerHigh,
      scheme.surfaceContainerHighest,
    ];

    ColorScheme insertAdditionalColours(
      final ColorScheme scheme,
      final List<Color> additionalColours,
    ) => scheme.copyWith(
      surface: additionalColours[0],
      surfaceDim: additionalColours[1],
      surfaceBright: additionalColours[2],
      surfaceContainerLowest: additionalColours[3],
      surfaceContainerLow: additionalColours[4],
      surfaceContainer: additionalColours[5],
      surfaceContainerHigh: additionalColours[6],
      surfaceContainerHighest: additionalColours[7],
    );

    try {
      final ColorScheme? colorScheme = await DynamicColorPlugin.getCorePalette()
          .then(
            (final corePalette) =>
                corePalette?.toColorScheme(brightness: brightness),
          );
      if (colorScheme == null) {
        return Future.value(null);
      }
      // Workaround as dynamic_color doesn't add new color roles
      final fromSeed = ColorScheme.fromSeed(
        seedColor: colorScheme.primary,
        brightness: brightness,
      );
      final additionalColours = extractAdditionalColours(fromSeed);
      final updatedColorScheme = insertAdditionalColours(
        colorScheme,
        additionalColours,
      );
      return Future.value(updatedColorScheme);
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
