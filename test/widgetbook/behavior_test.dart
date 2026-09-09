import 'dart:ui' as ui;

import 'package:bip39_mnemonic/bip39_mnemonic.dart' show Language, Mnemonic;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tool/widgetbook/catalog_case.dart';
import '../../tool/widgetbook/fixtures.dart';
import '../../tool/widgetbook/main.dart';
import '../../tool/widgetbook/platform.dart';
import '../../tool/widgetbook/use_cases/molecules/config_item_fields/basic_bool_config_item.dart';
import '../../tool/widgetbook/use_cases/organisms/modals/backups/snapshot_modal.dart';

class _Context extends Mock implements BuildContext {}

class _Messenger extends Mock implements BinaryMessenger {}

Future<void> pumpCase(
  final WidgetTester tester,
  final CatalogCase example, {
  final Locale locale = const Locale('en'),
}) async {
  rootBundle.clear();
  tester.view.physicalSize = Size(example.width, example.height);
  tester.view.devicePixelRatio = 1;
  await tester.runAsync(() async {
    await tester.pumpWidget(
      CatalogLocalization(
        locale: locale,
        child: Theme(data: catalogTheme(Brightness.light), child: example),
      ),
    );
  });
  for (
    var attempt = 0;
    attempt < 100 && find.byType(Scaffold).evaluate().isEmpty;
    attempt++
  ) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pump();
  }
  expect(find.byType(Scaffold), findsWidgets);
  await tester.pump();
  for (var frame = 0; frame < 5; frame++) {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
  });
  testWidgets(
    'default content host sizes future cards independently of viewport height',
    (final tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      const cardKey = ValueKey('natural-card');
      Size? firstSize;
      for (final height in [400.0, 800.0]) {
        await pumpCase(
          tester,
          CatalogCase(
            id: 'NaturalCard/$height',
            variant: 'Default',
            height: height,
            builder:
                (
                  final context,
                  final fixtures,
                  final controller,
                  final update,
                ) => const Card(
                  key: cardKey,
                  child: Column(
                    children: [SizedBox(height: 30), SizedBox(height: 40)],
                  ),
                ),
          ),
        );
        final size = tester.getSize(find.byKey(cardKey));
        expect(size.height, lessThan(100));
        expect(
          tester.getSize(find.byKey(catalogContentKey)).height,
          size.height + 48,
        );
        if (firstSize != null) {
          expect(size, firstSize);
        }
        firstSize = size;
        expect(tester.takeException(), isNull);
      }
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
  test('key fixtures have real formats and no embedded line breaks', () {
    expect(
      () => Mnemonic.fromSentence(demoMnemonic, Language.english),
      returnsNormally,
    );
    expect(demoMnemonic.split(' '), hasLength(12));
    expect(demoBackupKey.length, 384);
    expect(demoBackupKey, isNot(contains('\n')));
  });
  test('clipboard and URL actions never reach the platform', () async {
    final delegate = _Messenger();
    final messenger = CatalogMessenger(delegate);
    const json = JSONMethodCodec();
    await messenger.send(
      'flutter/platform',
      json.encodeMethodCall(
        const MethodCall('Clipboard.setData', {'text': 'catalog-only'}),
      ),
    );
    await messenger.send(
      'dev.flutter.pigeon.url_launcher_linux.UrlLauncherApi.launchUrl',
      const StandardMessageCodec().encodeMessage(['https://example.org']),
    );
    verifyZeroInteractions(delegate);
    expect(catalogActions.value.last, contains('External link (preview)'));
  });
  testWidgets('local selections work and reset when the example changes', (
    final tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpCase(tester, basicBoolConfigItemOff(_Context()) as CatalogCase);
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isFalse,
    );
    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isTrue,
    );
    await pumpCase(tester, basicBoolConfigItemOn(_Context()) as CatalogCase);
    await pumpCase(tester, basicBoolConfigItemOff(_Context()) as CatalogCase);
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isFalse,
    );
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    expect(getIt.isRegistered<NavigationService>(), isFalse);
  });
  testWidgets(
    'inplace example selects the strategy without submitting a restore',
    (final tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await pumpCase(
        tester,
        snapshotModalInplaceRestore(_Context()) as CatalogCase,
      );
      expect(
        tester
            .widgetList<RadioSelectionCard>(find.byType(RadioSelectionCard))
            .last
            .isSelected,
        isTrue,
      );
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(catalogActions.value, isEmpty);
      Navigator.of(tester.element(find.byType(BottomSheet))).pop();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Open preview'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
  for (final locale in [
    const Locale('en'),
    const Locale('ru'),
    const Locale('ar'),
  ]) {
    testWidgets('locale ${locale.languageCode} uses the app delegates', (
      final tester,
    ) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await pumpCase(
        tester,
        basicBoolConfigItemOff(_Context()) as CatalogCase,
        locale: locale,
      );
      final context = tester.element(find.byType(SwitchListTile));
      expect(Localizations.localeOf(context), locale);
      expect(
        Directionality.of(context),
        locale.languageCode == 'ar'
            ? ui.TextDirection.rtl
            : ui.TextDirection.ltr,
      );
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
  testWidgets('Widgetbook opens a real example with knobs and theme controls', (
    final tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const CatalogApp(initialRoute: '/?path=atoms/buttons/brandbutton/filled'),
    );
    await tester.runAsync(() async {
      await tester.pump();
    });
    await tester.pump();
    expect(find.byType(CatalogCase), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
