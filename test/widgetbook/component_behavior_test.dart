import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/ui/atoms/markdown/brand_md.dart';
import 'package:selfprivacy/ui/molecules/buttons/flash_fab.dart';
import 'package:selfprivacy/ui/organisms/jobs/jobs_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tool/widgetbook/catalog_case.dart';
import 'behavior_test.dart' show pumpCase;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
  });
  setUp(rootBundle.clear);

  testWidgets('markdown reloads when its filename changes', (
    final tester,
  ) async {
    final filename = ValueNotifier('test-first');
    addTearDown(filename.dispose);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final messenger = tester.binding.defaultBinaryMessenger
      ..setMockMessageHandler('flutter/assets', (final message) async {
        final path = utf8.decode(message!.buffer.asUint8List());
        if (path.startsWith('assets/markdown/test-')) {
          return ByteData.sublistView(
            utf8.encode(
              path.contains('first') ? 'First article' : 'Second article',
            ),
          );
        }
        final file = File(path);
        return file.existsSync()
            ? ByteData.sublistView(await file.readAsBytes())
            : null;
      });
    addTearDown(() {
      messenger.setMockMessageHandler('flutter/assets', null);
      rootBundle.clear();
    });
    await pumpCase(
      tester,
      CatalogCase(
        id: 'Markdown/Update',
        variant: 'Default',
        builder:
            (final context, final fixtures, final controller, final update) =>
                ValueListenableBuilder<String>(
                  valueListenable: filename,
                  builder: (final context, final value, final child) =>
                      BrandMarkdown(fileName: value),
                ),
      ),
    );
    expect(find.text('First article'), findsOneWidget);
    filename.value = 'test-second';
    await tester.pumpAndSettle();
    expect(find.text('Second article'), findsOneWidget);
    expect(find.text('First article'), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('markdown falls back to English when translation is absent', (
    final tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final requested = <String>[];
    final messenger = tester.binding.defaultBinaryMessenger
      ..setMockMessageHandler('flutter/assets', (final message) async {
        final path = utf8.decode(message!.buffer.asUint8List());
        if (path.startsWith('assets/markdown/test-')) {
          requested.add(path);
          return path.endsWith('-en.md')
              ? ByteData.sublistView(utf8.encode('English fallback article'))
              : null;
        }
        final file = File(path);
        return file.existsSync()
            ? ByteData.sublistView(await file.readAsBytes())
            : null;
      });
    addTearDown(() {
      messenger.setMockMessageHandler('flutter/assets', null);
      rootBundle.clear();
    });
    await pumpCase(
      tester,
      CatalogCase(
        id: 'Markdown/Fallback',
        variant: 'Default',
        builder:
            (final context, final fixtures, final controller, final update) =>
                const BrandMarkdown(fileName: 'test-fallback'),
      ),
      locale: const Locale('ru'),
    );
    expect(requested, [
      'assets/markdown/test-fallback-ru.md',
      'assets/markdown/test-fallback-en.md',
    ]);
    expect(find.text('English fallback article'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('jobs FAB animates state changes and opens the jobs sheet', (
    final tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final states = StreamController<JobsState>.broadcast();
    addTearDown(states.close);
    await pumpCase(
      tester,
      CatalogCase(
        id: 'BrandFab/Transitions',
        variant: 'Empty',
        host: PreviewHost.screen,
        height: 800,
        builder:
            (final context, final fixtures, final controller, final update) {
              when(() => fixtures.jobs.stream).thenAnswer((_) => states.stream);
              return const Center(child: BrandFab());
            },
      ),
    );
    expect(find.byIcon(Ionicons.flash_outline), findsOneWidget);
    states.add(JobsStateWithJobs(const []));
    await tester.pumpAndSettle();
    expect(find.byIcon(Ionicons.flash), findsOneWidget);
    states.add(JobsStateEmpty());
    await tester.pumpAndSettle();
    expect(find.byIcon(Ionicons.flash_outline), findsOneWidget);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(JobsContent), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
