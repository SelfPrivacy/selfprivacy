import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/charts/server_charts.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Data', type: ServerDiskChart, path: '[Organisms]/charts')
Widget serverDiskChartData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerDiskChart/Data'),
  id: 'ServerDiskChart/Data',
  variant: 'Data',
  host: PreviewHost.content,
  width: 640,
  height: 300,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerDiskChart(
        state: demoMetrics(),
        diskData: [
          DiskGraphData(
            volume: demoVolume(),
            color: Theme.of(context).colorScheme.primary,
            diskData: demoSeries(),
            originalId: 'sda1',
          ),
        ],
      ),
);

@UseCase(name: 'No data', type: ServerDiskChart, path: '[Organisms]/charts')
Widget serverDiskChartNoData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerDiskChart/No data'),
  id: 'ServerDiskChart/No data',
  variant: 'No data',
  host: PreviewHost.content,
  width: 640,
  height: 300,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerDiskChart(
        state: null,
        diskData: [
          DiskGraphData(
            volume: demoVolume(),
            color: Theme.of(context).colorScheme.primary,
            diskData: demoSeries(),
            originalId: 'sda1',
          ),
        ],
      ),
);
