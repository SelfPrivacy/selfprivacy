import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/charts/network_charts.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Data', type: NetworkChart, path: '[Molecules]/charts')
Widget networkChartData(final BuildContext context) => CatalogCase(
  key: const ValueKey('NetworkChart/Data'),
  id: 'NetworkChart/Data',
  variant: 'Data',
  host: PreviewHost.content,
  width: 640,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      SizedBox(
        height: 240,
        child: NetworkChart(
          data: [demoSeries(flat: false), demoSeries(scale: 0.5, flat: false)],
          period: Period.hour,
          start: referenceTime,
        ),
      ),
);

@UseCase(name: 'Flat', type: NetworkChart, path: '[Molecules]/charts')
Widget networkChartFlat(final BuildContext context) => CatalogCase(
  key: const ValueKey('NetworkChart/Flat'),
  id: 'NetworkChart/Flat',
  variant: 'Flat',
  host: PreviewHost.content,
  width: 640,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      SizedBox(
        height: 240,
        child: NetworkChart(
          data: [demoSeries(flat: true), demoSeries(scale: 0.5, flat: true)],
          period: Period.hour,
          start: referenceTime,
        ),
      ),
);
