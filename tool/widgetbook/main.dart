import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/localization.dart';
import 'package:selfprivacy/theming/app_theme_factory.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as annotation;

import 'catalog_case.dart';
import 'main.directories.g.dart';
import 'platform.dart';

Future<void> main() async {
  CatalogBinding();
  await EasyLocalization.ensureInitialized();
  runApp(const CatalogApp());
}

ThemeData catalogTheme(final Brightness brightness) =>
    AppThemeFactory.fromColorScheme(
      ColorScheme.fromSeed(
        seedColor: BrandColors.primary,
        brightness: brightness,
      ),
    );

class CatalogLocaleAddon extends WidgetbookAddon<Locale> {
  CatalogLocaleAddon() : super(name: 'Language');
  @override
  List<Field> get fields => [
    ObjectDropdownField<Locale>(
      name: 'locale',
      values: Localization.supportedLocales,
      initialValue: const Locale('en'),
      labelBuilder: Localization.getLanguageName,
    ),
  ];
  @override
  Locale valueFromQueryGroup(final Map<String, String> group) =>
      valueOf('locale', group)!;
  @override
  Widget buildUseCase(
    final BuildContext context,
    final Widget child,
    final Locale setting,
  ) => CatalogLocalization(locale: setting, child: child);
}

class CatalogLocalization extends StatelessWidget {
  const CatalogLocalization({
    required this.child,
    this.locale = const Locale('en'),
    super.key,
  });
  final Widget child;
  final Locale locale;
  @override
  Widget build(final BuildContext context) => EasyLocalization(
    key: ValueKey(locale),
    startLocale: locale,
    supportedLocales: Localization.supportedLocales,
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    useFallbackTranslations: true,
    saveLocale: false,
    child: child,
  );
}

@annotation.App()
class CatalogApp extends StatelessWidget {
  const CatalogApp({this.initialRoute = '/', super.key});
  final String initialRoute;
  @override
  Widget build(final BuildContext context) => Widgetbook.material(
    directories: directories,
    initialRoute: initialRoute,
    appBuilder: (final context, final child) => child,
    addons: [
      MaterialThemeAddon(
        themes: [
          WidgetbookTheme(name: 'Light', data: catalogTheme(Brightness.light)),
          WidgetbookTheme(name: 'Dark', data: catalogTheme(Brightness.dark)),
        ],
      ),
      TextScaleAddon(min: 1, max: 2),
      CatalogLocaleAddon(),
    ],
    header: Padding(
      padding: const EdgeInsets.all(8),
      child: ValueListenableBuilder<List<String>>(
        valueListenable: catalogActions,
        builder: (final context, final actions, final child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('SelfPrivacy components'),
            Text(
              actions.isEmpty ? 'Actions appear here' : actions.last,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            TextButton(
              onPressed: () => catalogActions.value = [],
              child: const Text('Clear actions'),
            ),
          ],
        ),
      ),
    ),
  );
}
