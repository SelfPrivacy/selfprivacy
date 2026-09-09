import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../tool/widgetbook/catalog_case.dart';
import '../../tool/widgetbook/main.dart';
import '../../tool/widgetbook/main.directories.g.dart';

class _Context extends Mock implements BuildContext {}

Iterable<WidgetbookUseCase> cases(final List<WidgetbookNode> nodes) sync* {
  for (final node in nodes) {
    if (node is WidgetbookUseCase) {
      yield node;
    } else {
      yield* cases(node.children ?? []);
    }
  }
}

Future<void> loadCatalogFonts() async {
  final roboto = FontLoader('Roboto');
  for (final weight in ['Regular', 'Medium', 'Bold']) {
    roboto.addFont(
      File(
        'tool/widgetbook/fonts/Roboto-$weight.ttf',
      ).readAsBytes().then(ByteData.sublistView),
    );
  }
  await roboto.load();
  final manifest =
      jsonDecode(await rootBundle.loadString('FontManifest.json'))
          as List<dynamic>;
  for (final entry in manifest.cast<Map<String, dynamic>>()) {
    final loader = FontLoader(entry['family'] as String);
    for (final font
        in (entry['fonts'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }
}

Future<void> waitForContent(
  final WidgetTester tester,
  final bool Function() ready,
  final String reason,
) async {
  for (var attempt = 0; attempt < 100 && !ready(); attempt++) {
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    });
    await tester.pump();
  }
  expect(ready(), isTrue, reason: reason);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await loadCatalogFonts();
  });
  for (final useCase in cases(directories)) {
    final example = useCase.builder(_Context()) as CatalogCase;
    for (final brightness in Brightness.values) {
      testWidgets('${example.id} ${brightness.name}', (final tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = Size(example.width, example.height);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        rootBundle.clear();
        await tester.runAsync(() async {
          await tester.pumpWidget(
            CatalogLocalization(
              child: Theme(data: catalogTheme(brightness), child: example),
            ),
          );
        });
        await tester.pump();
        for (var frame = 0; frame < 5; frame++) {
          await tester.pump(const Duration(milliseconds: 300));
        }
        if (find.byType(MarkdownBody).evaluate().isNotEmpty) {
          await waitForContent(
            tester,
            () => tester
                .widgetList<MarkdownBody>(find.byType(MarkdownBody))
                .any((final body) => body.data.trim().isNotEmpty),
            'Markdown must load before capture',
          );
        }
        await waitForContent(
          tester,
          () => tester
              .widgetList<RawImage>(find.byType(RawImage))
              .every((final image) => image.image != null),
          'Images must decode before capture',
        );
        await tester.pump();
        final component = example.id.split('/').first;
        if (!['BrandButton', 'BrandLoader', 'BrandIcons'].contains(component)) {
          expect(
            find.byWidgetPredicate(
              (final widget) => widget.runtimeType.toString() == component,
            ),
            findsWidgets,
            reason: 'Capture must contain $component',
          );
        }
        if (example.host == PreviewHost.sheet) {
          expect(
            find.byType(BottomSheet),
            findsOneWidget,
            reason: 'Sheet must remain open',
          );
        }
        expect(tester.takeException(), isNull, reason: example.id);
        if (Platform.isLinux) {
          await expectLater(
            example.host == PreviewHost.content &&
                    find.byType(Dialog).evaluate().isEmpty
                ? find.byKey(catalogContentKey)
                : find.byType(CatalogCase),
            matchesGoldenFile(
              'goldens/${example.id.replaceAll(RegExp('[^a-zA-Z0-9/]+'), '_')}_${brightness.name}.png',
            ),
          );
        }
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        expect(
          tester.takeException(),
          isNull,
          reason: 'Disposing ${example.id}',
        );
      });
    }
  }
}
