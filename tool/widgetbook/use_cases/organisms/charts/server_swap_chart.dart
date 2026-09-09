import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/charts/server_charts.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Data', type: ServerSwapChart, path: '[Organisms]/charts')
Widget serverSwapChartData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerSwapChart/Data'),
  id: 'ServerSwapChart/Data',
  variant: 'Data',
  host: PreviewHost.content,
  width: 640,
  height: 300,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerSwapChart(state: demoMetrics()),
);

@UseCase(name: 'No data', type: ServerSwapChart, path: '[Organisms]/charts')
Widget serverSwapChartNoData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerSwapChart/No data'),
  id: 'ServerSwapChart/No data',
  variant: 'No data',
  host: PreviewHost.content,
  width: 640,
  height: 300,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerSwapChart(state: null),
);
