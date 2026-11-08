import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/ui/molecules/timezone_selection_tile.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

import '../helpers/widget_harness.dart';

void main() {
  setUpAll(setUpWidgetTestHarness);
  setUpAll(initializeTimeZones);

  for (final (month, offset, time) in [
    (1, 'GMT+01:00', '1:00 PM'),
    (7, 'GMT+02:00', '2:00 PM'),
  ]) {
    testWidgets('row uses the offset at the displayed instant: month=$month', (
      final tester,
    ) async {
      await pumpForTest(
        tester,
        RadioGroup<String>(
          groupValue: 'Europe/Berlin',
          onChanged: (_) {},
          child: TimezoneSelectionTile(
            location: getLocation('Europe/Berlin'),
            now: DateTime.utc(2026, month, 1, 12),
            zoneName: 'Central European Standard Time',
          ),
        ),
      );
      expect(find.text('Berlin'), findsOneWidget);
      expect(find.textContaining(offset), findsOneWidget);
      expect(find.text(time), findsOneWidget);
      if (month == 7) {
        expect(find.textContaining('Standard'), findsNothing);
      }
    });
  }

  testWidgets(
    'device row preserves fractional offset and submits its own choice',
    (final tester) async {
      String? selected;
      await pumpForTest(
        tester,
        RadioGroup<String>(
          groupValue: null,
          onChanged: (final value) => selected = value,
          child: TimezoneSelectionTile(
            location: getLocation('Asia/Kathmandu'),
            now: DateTime.utc(2026, 1, 1, 12),
            title: 'Device time zone',
            value: 'device',
          ),
        ),
      );
      expect(find.textContaining('GMT+05:45'), findsOneWidget);
      expect(find.text('5:45 PM'), findsOneWidget);
      await tester.tap(find.text('Device time zone'));
      expect(selected, 'device');
    },
  );

  testWidgets('disabled long row fits a narrow window with large text', (
    final tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    String? selected;
    await pumpForTest(
      tester,
      MediaQuery(
        data: const MediaQueryData(
          textScaler: TextScaler.linear(2),
          alwaysUse24HourFormat: true,
        ),
        child: RadioGroup<String>(
          groupValue: null,
          onChanged: (final value) => selected = value,
          child: TimezoneSelectionTile(
            location: getLocation('America/Argentina/Buenos_Aires'),
            now: DateTime.utc(2026, 1, 1, 12),
            zoneName: 'Argentina Standard Time',
            enabled: false,
          ),
        ),
      ),
    );
    expect(find.text('Buenos Aires'), findsOneWidget);
    expect(find.text('09:00'), findsOneWidget);
    expect(
      tester
          .widget<RadioListTile<String>>(find.byType(RadioListTile<String>))
          .secondary,
      isNull,
    );
    await tester.tap(find.text('Buenos Aires'));
    expect(selected, isNull);
    expect(tester.takeException(), isNull);
  });
}
