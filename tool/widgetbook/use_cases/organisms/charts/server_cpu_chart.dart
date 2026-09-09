import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/charts/server_charts.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Data', type: ServerCpuChart, path: '[Organisms]/charts')
Widget serverCpuChartData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerCpuChart/Data'),
  id: 'ServerCpuChart/Data',
  variant: 'Data',
  host: PreviewHost.content,
  width: 640,
  height: 300,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerCpuChart(state: demoMetrics()),
);

@UseCase(name: 'No data', type: ServerCpuChart, path: '[Organisms]/charts')
Widget serverCpuChartNoData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerCpuChart/No data'),
  id: 'ServerCpuChart/No data',
  variant: 'No data',
  host: PreviewHost.content,
  width: 640,
  height: 300,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerCpuChart(state: null),
);
