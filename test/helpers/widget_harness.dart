import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setUpWidgetTestHarness() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(<String, Object>{});
  await EasyLocalization.ensureInitialized();
}

Widget wrapForTest({required final Widget child}) => EasyLocalization(
  supportedLocales: const [Locale('en')],
  path: 'assets/translations',
  fallbackLocale: const Locale('en'),
  useFallbackTranslations: true,
  saveLocale: false,
  child: Builder(
    builder: (final context) => MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Scaffold(body: child),
    ),
  ),
);

Future<void> pumpForTest(final WidgetTester tester, final Widget child) async {
  await tester.runAsync(() async {
    await tester.pumpWidget(wrapForTest(child: child));
    await Future<void>.delayed(Duration.zero);
  });
  await tester.pumpAndSettle();
}
