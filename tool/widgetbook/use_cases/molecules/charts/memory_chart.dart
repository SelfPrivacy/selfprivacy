import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/charts/memory_chart.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Data', type: MemoryChart, path: '[Molecules]/charts')
Widget memoryChartData(final BuildContext context) => CatalogCase(
  key: const ValueKey('MemoryChart/Data'),
  id: 'MemoryChart/Data',
  variant: 'Data',
  host: PreviewHost.content,
  width: 640,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      SizedBox(
        height: 240,
        child: MemoryChart(
          data: [demoSeries(flat: false)],
          period: Period.hour,
          start: referenceTime,
        ),
      ),
);

@UseCase(name: 'Flat', type: MemoryChart, path: '[Molecules]/charts')
Widget memoryChartFlat(final BuildContext context) => CatalogCase(
  key: const ValueKey('MemoryChart/Flat'),
  id: 'MemoryChart/Flat',
  variant: 'Flat',
  host: PreviewHost.content,
  width: 640,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      SizedBox(
        height: 240,
        child: MemoryChart(
          data: [demoSeries(flat: true)],
          period: Period.hour,
          start: referenceTime,
        ),
      ),
);
