import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/timezone_selection_tile.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';

@UseCase(name: 'Choices', type: TimezoneSelectionTile, path: '[Molecules]')
Widget timezoneChoices(final BuildContext context) => _example('Choices');

@UseCase(name: 'Device', type: TimezoneSelectionTile, path: '[Molecules]')
Widget timezoneDevice(final BuildContext context) => _example('Device');

@UseCase(name: 'Disabled', type: TimezoneSelectionTile, path: '[Molecules]')
Widget timezoneDisabled(final BuildContext context) => _example('Disabled');

@UseCase(name: 'Large text', type: TimezoneSelectionTile, path: '[Molecules]')
Widget timezoneLargeText(final BuildContext context) => _example('Large text');

@UseCase(name: 'Wide', type: TimezoneSelectionTile, path: '[Molecules]')
Widget timezoneWide(final BuildContext context) => _example('Wide');

CatalogCase _example(final String variant) {
  initializeTimeZones();
  String? selected = variant == 'Device' ? 'device' : 'Europe/Berlin';
  return CatalogCase(
    id: 'TimezoneSelectionTile/$variant',
    variant: variant,
    width: variant == 'Wide' ? 640 : 360,
    builder: (final context, final fixtures, final controller, final update) =>
        MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(variant == 'Large text' ? 2 : 1),
          ),
          child: RadioGroup<String>(
            groupValue: selected,
            onChanged: (final value) => update(() {
              selected = value;
              catalogActions.record('Select time zone: $value');
            }),
            child: Column(
              children: [
                if (variant == 'Device')
                  TimezoneSelectionTile(
                    location: getLocation('Asia/Kathmandu'),
                    now: DateTime.utc(2026, 1, 15, 12),
                    zoneName: 'Nepal Time',
                    title: 'server.timezone.device'.tr(),
                    value: 'device',
                  ),
                for (final (id, name) in [
                  ('Europe/Berlin', 'Central European Standard Time'),
                  ('Europe/Kaliningrad', 'Eastern European Standard Time'),
                  ('Europe/Samara', 'Samara Standard Time'),
                ])
                  TimezoneSelectionTile(
                    location: getLocation(id),
                    now: DateTime.utc(2026, 1, 15, 12),
                    zoneName: name,
                    enabled: variant != 'Disabled',
                  ),
              ],
            ),
          ),
        ),
  );
}
