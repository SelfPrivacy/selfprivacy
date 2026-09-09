import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/charts/disk_charts.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Data', type: DiskChart, path: '[Molecules]/charts')
Widget diskChartData(final BuildContext context) => CatalogCase(
  key: const ValueKey('DiskChart/Data'),
  id: 'DiskChart/Data',
  variant: 'Data',
  host: PreviewHost.content,
  width: 640,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      SizedBox(
        height: 240,
        child: DiskChart(
          diskData: [
            DiskGraphData(
              volume: demoVolume(),
              color: Theme.of(context).colorScheme.primary,
              diskData: demoSeries(flat: false),
              originalId: 'sda1',
            ),
          ],
          period: Period.hour,
          start: referenceTime,
        ),
      ),
);

@UseCase(name: 'Flat', type: DiskChart, path: '[Molecules]/charts')
Widget diskChartFlat(final BuildContext context) => CatalogCase(
  key: const ValueKey('DiskChart/Flat'),
  id: 'DiskChart/Flat',
  variant: 'Flat',
  host: PreviewHost.content,
  width: 640,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      SizedBox(
        height: 240,
        child: DiskChart(
          diskData: [
            DiskGraphData(
              volume: demoVolume(),
              color: Theme.of(context).colorScheme.primary,
              diskData: demoSeries(flat: true),
              originalId: 'sda1',
            ),
          ],
          period: Period.hour,
          start: referenceTime,
        ),
      ),
);
