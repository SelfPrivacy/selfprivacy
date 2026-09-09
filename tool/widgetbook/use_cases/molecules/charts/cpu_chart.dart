import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/charts/cpu_chart.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Data', type: CpuChart, path: '[Molecules]/charts')
Widget cpuChartData(final BuildContext context) => CatalogCase(
  key: const ValueKey('CpuChart/Data'),
  id: 'CpuChart/Data',
  variant: 'Data',
  host: PreviewHost.content,
  width: 640,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      SizedBox(
        height: 240,
        child: CpuChart(
          data: [demoSeries(flat: false)],
          period: Period.hour,
          start: referenceTime,
        ),
      ),
);

@UseCase(name: 'Flat', type: CpuChart, path: '[Molecules]/charts')
Widget cpuChartFlat(final BuildContext context) => CatalogCase(
  key: const ValueKey('CpuChart/Flat'),
  id: 'CpuChart/Flat',
  variant: 'Flat',
  host: PreviewHost.content,
  width: 640,
  height: 330,
  builder: (final context, final fixtures, final controller, final update) =>
      SizedBox(
        height: 240,
        child: CpuChart(
          data: [demoSeries(flat: true)],
          period: Period.hour,
          start: referenceTime,
        ),
      ),
);
