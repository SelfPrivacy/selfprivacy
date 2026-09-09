import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/charts/server_charts.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Data', type: ServerMemoryChart, path: '[Organisms]/charts')
Widget serverMemoryChartData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerMemoryChart/Data'),
  id: 'ServerMemoryChart/Data',
  variant: 'Data',
  host: PreviewHost.content,
  width: 640,
  height: 300,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerMemoryChart(state: demoMetrics()),
);

@UseCase(name: 'No data', type: ServerMemoryChart, path: '[Organisms]/charts')
Widget serverMemoryChartNoData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerMemoryChart/No data'),
  id: 'ServerMemoryChart/No data',
  variant: 'No data',
  host: PreviewHost.content,
  width: 640,
  height: 300,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerMemoryChart(state: null),
);
