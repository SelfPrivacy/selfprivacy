import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/theming/app_theme_factory.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final brightness in Brightness.values) {
    for (final accent in <Color?>[null, Colors.orange]) {
      test('creates $brightness theme with accent $accent', () async {
        final messenger =
            TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
              ..setMockMethodCallHandler(
                DynamicColorPlugin.channel,
                (final call) async =>
                    call.method == 'getAccentColor' ? accent?.toARGB32() : null,
              );
        addTearDown(
          () => messenger.setMockMethodCallHandler(
            DynamicColorPlugin.channel,
            null,
          ),
        );
        final theme = await AppThemeFactory.create(
          isDark: brightness == Brightness.dark,
          fallbackColor: Colors.blue,
        );
        expect(theme.brightness, brightness);
        expect(
          theme.colorScheme,
          ColorScheme.fromSeed(
            seedColor: accent ?? Colors.blue,
            brightness: brightness,
          ),
        );
        expect(theme.useMaterial3, isTrue);
        expect(theme.listTileTheme.shape, isA<RoundedRectangleBorder>());
      });
    }
  }
}
