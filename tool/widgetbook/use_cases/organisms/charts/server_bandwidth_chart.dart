import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/charts/server_charts.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Data', type: ServerBandwidthChart, path: '[Organisms]/charts')
Widget serverBandwidthChartData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerBandwidthChart/Data'),
  id: 'ServerBandwidthChart/Data',
  variant: 'Data',
  host: PreviewHost.content,
  width: 640,
  height: 300,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerBandwidthChart(state: demoMetrics()),
);

@UseCase(
  name: 'No data',
  type: ServerBandwidthChart,
  path: '[Organisms]/charts',
)
Widget serverBandwidthChartNoData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerBandwidthChart/No data'),
  id: 'ServerBandwidthChart/No data',
  variant: 'No data',
  host: PreviewHost.content,
  width: 640,
  height: 300,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerBandwidthChart(state: null),
);
