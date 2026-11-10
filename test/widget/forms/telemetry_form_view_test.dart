import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/forms/telemetry_form.dart';
import 'package:selfprivacy/logic/models/telemetry_settings.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/forms/telemetry_form_view.dart';
import 'package:selfprivacy/ui/molecules/cards/status_card.dart';

import '../../helpers/fixtures/telemetry_fixtures.dart';
import '../../helpers/widget_harness.dart';

void main() {
  setUpAll(setUpWidgetTestHarness);
  late List<TelemetryUpdate> submitted;
  var refreshes = 0;
  setUp(() {
    submitted = [];
    refreshes = 0;
  });

  Future<void> show(
    final WidgetTester tester, {
    final bool enabled = true,
    final bool pending = false,
    final bool applying = false,
    final bool loaded = true,
    final bool telemetryEnabled = false,
    final bool memoryTracingEnabled = false,
    final Object? error,
    final Freshness freshness = Freshness.fresh,
  }) async {
    final settings = aTelemetrySettings(
      enable: telemetryEnabled,
      memoryTracingEnabled: memoryTracingEnabled,
    );
    final form = loaded ? TelemetryForm(settings) : null;
    if (form != null) {
      addTearDown(form.dispose);
    }
    await pumpForTest(
      tester,
      SingleChildScrollView(
        child: TelemetryFormView(
          form: form,
          snapshot: CachedValue(
            data: loaded ? settings : null,
            support: DomainSupport.supported,
            freshness: freshness,
            lastError: error,
          ),
          enabled: enabled,
          pending: pending,
          applying: applying,
          onAdd: submitted.add,
          onRefresh: () => refreshes++,
        ),
      ),
    );
  }

  testWidgets(
    'master switch preserves disabled values and queues only on confirmation',
    (final tester) async {
      await show(tester);
      final switches = tester
          .widgetList<SwitchListTile>(find.byType(SwitchListTile))
          .toList();
      expect(switches.first.onChanged, isNotNull);
      expect(
        switches.skip(1).every((final tile) => tile.onChanged == null),
        true,
      );
      expect(
        tester.widget<TextField>(find.byType(TextField).first).enabled,
        false,
      );
      expect(
        tester
            .widgetList<IconButton>(
              find.widgetWithIcon(IconButton, Icons.delete_outline),
            )
            .every((final button) => button.onPressed == null),
        true,
      );
      await tester.tap(find.text('Enable telemetry'));
      await tester.pump();
      expect(submitted, isEmpty);
      await tester.ensureVisible(find.text('Create job'));
      await tester.tap(find.text('Create job'));
      await tester.pump();
      expect(submitted.single.enable, true);
      expect(submitted.single.uploadSystemLogs, true);
      expect(submitted.single.headers, isEmpty);
      expect(find.byType(AlertDialog), findsNothing);
      final warning = find.ancestor(
        of: find.text('Protect your data'),
        matching: find.byType(FilledCard),
      );
      expect(warning, findsOneWidget);
      expect(
        tester.getTopLeft(warning).dy,
        greaterThanOrEqualTo(
          tester
              .getBottomLeft(
                find.widgetWithText(SwitchListTile, 'Enable telemetry'),
              )
              .dy,
        ),
      );
      expect(
        tester.getBottomLeft(warning).dy,
        lessThan(tester.getTopLeft(find.text('Diagnostic data')).dy),
      );
      expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);
    },
  );

  testWidgets(
    'header replacement stays obscured and reaches the queued input',
    (final tester) async {
      await show(tester);
      await tester.tap(find.text('Enable telemetry'));
      await tester.pump();
      final secret = find.widgetWithText(TextField, 'Header value').first;
      await tester.ensureVisible(secret);
      await tester.enterText(secret, ' header-secret ');
      await tester.pump();
      expect(tester.widget<TextField>(secret).obscureText, true);
      await tester.ensureVisible(find.text('Create job'));
      await tester.tap(find.text('Create job'));
      await tester.pump();
      expect(submitted.single.headers, {'authorization': ' header-secret '});
    },
  );

  testWidgets('removing a saved header can be undone before queueing', (
    final tester,
  ) async {
    await show(tester, telemetryEnabled: true);
    final secret = find.widgetWithText(TextField, 'Header value').first;
    await tester.ensureVisible(secret);
    await tester.enterText(secret, 'replacement');
    await tester.pump();
    final remove = find.byTooltip('Remove header').first;
    await tester.ensureVisible(remove);
    await tester.tap(remove);
    await tester.pump();
    expect(find.text('Will be removed'), findsOneWidget);
    final undo = find.byTooltip('Undo removal');
    await tester.ensureVisible(undo);
    await tester.tap(undo);
    await tester.pump();
    expect(find.text('Will be removed'), findsNothing);
    expect(tester.widget<TextField>(secret).controller!.text, 'replacement');
    await tester.ensureVisible(remove);
    await tester.tap(remove);
    await tester.pump();
    await tester.ensureVisible(find.text('Create job'));
    await tester.tap(find.text('Create job'));
    await tester.pump();
    expect(submitted.single.headers, {'authorization': null});
  });

  for (final tracing in [false, true]) {
    testWidgets('both API rows explain their read-only state: $tracing', (
      final tester,
    ) async {
      await show(tester, memoryTracingEnabled: tracing);
      final apiRow = find.ancestor(
        of: find.text('API traces'),
        matching: find.byType(ListTile),
      );
      final memoryRow = find.ancestor(
        of: find.text('API memory tracing'),
        matching: find.byType(ListTile),
      );
      expect(tester.widget<ListTile>(memoryRow).enabled, false);
      final api = tester.widget<Switch>(
        find.descendant(of: apiRow, matching: find.byType(Switch)),
      );
      final memory = tester.widget<Switch>(
        find.descendant(of: memoryRow, matching: find.byType(Switch)),
      );
      expect(tester.widget<ListTile>(apiRow).leading, isA<Icon>());
      expect(tester.widget<ListTile>(apiRow).subtitle, isNotNull);
      expect(api.onChanged, isNull);
      expect(api.value, false);
      expect(tester.widget<ListTile>(memoryRow).leading, isA<Icon>());
      expect(tester.widget<ListTile>(memoryRow).subtitle, isNotNull);
      expect(memory.onChanged, isNull);
      expect(memory.value, tracing);
      await tester.tap(find.text('Enable telemetry'));
      await tester.pump();
      final enabledApi = tester.widget<Switch>(
        find.descendant(of: apiRow, matching: find.byType(Switch)),
      );
      expect(enabledApi.value, true);
      expect(enabledApi.onChanged, isNull);
      expect(tester.widget<ListTile>(memoryRow).enabled, true);
    });
  }

  testWidgets('queued status clears when the draft is removed', (
    final tester,
  ) async {
    await show(tester, pending: true);
    expect(find.text('Not applied'), findsOneWidget);
    expect(find.text('Update job'), findsOneWidget);
    await show(tester);
    expect(find.text('Not applied'), findsNothing);
    expect(find.text('Create job'), findsOneWidget);
  });

  testWidgets('stale and error cards can refresh without a gesture', (
    final tester,
  ) async {
    await show(tester, freshness: Freshness.stale);
    await tester.tap(find.text('Showing cached data'));
    expect(refreshes, 1);
    await show(tester, loaded: false, error: StateError('secret-sentinel'));
    await tester.tap(find.text('Could not load telemetry settings'));
    expect(refreshes, 2);
    expect(find.textContaining('secret-sentinel'), findsNothing);
    expect(find.byType(ReactiveForm), findsNothing);
  });

  testWidgets(
    'applying disables editing and opens operation through its card',
    (final tester) async {
      await show(tester, enabled: false, applying: true);
      expect(find.byType(StatusCard), findsOneWidget);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
      expect(find.byType(LinearProgressIndicator), findsNothing);
    },
  );

  testWidgets('telemetry remains usable with large text in a narrow window', (
    final tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final settings = aTelemetrySettings(enable: true);
    final form = TelemetryForm(settings);
    addTearDown(form.dispose);
    await pumpForTest(
      tester,
      Builder(
        builder: (final context) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(2)),
          child: SingleChildScrollView(
            child: TelemetryFormView(
              form: form,
              snapshot: CachedValue(
                data: settings,
                support: DomainSupport.supported,
              ),
              onAdd: submitted.add,
              onRefresh: () {},
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    final secret = find.widgetWithText(TextField, 'Header value').first;
    await tester.ensureVisible(secret);
    await tester.enterText(secret, 'replacement');
    await tester.pump();
    final remove = find.byTooltip('Remove header').first;
    await tester.ensureVisible(remove);
    await tester.tap(remove);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
