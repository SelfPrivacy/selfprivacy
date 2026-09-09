import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/chart_elements/legend.dart';
import 'package:selfprivacy/ui/molecules/cards/chart_card.dart';
import 'package:selfprivacy/ui/molecules/charts/cpu_chart.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Loading', type: ChartCard, path: '[Molecules]/cards')
Widget chartCardLoading(final BuildContext context) => CatalogCase(
  key: const ValueKey('ChartCard/Loading'),
  id: 'ChartCard/Loading',
  variant: 'Loading',
  host: PreviewHost.content,
  width: 560,
  height: 440,
  builder: (final context, final fixtures, final controller, final update) =>
      ChartCard(
        title: 'CPU usage',
        isLoading: true,
        chart: SizedBox(
          height: 200,
          child: CpuChart(
            data: [demoSeries()],
            period: Period.hour,
            start: referenceTime,
          ),
        ),
        legendItems: const [],
        trailing: const [],
      ),
);

@UseCase(name: 'Chart', type: ChartCard, path: '[Molecules]/cards')
Widget chartCardChart(final BuildContext context) => CatalogCase(
  key: const ValueKey('ChartCard/Chart'),
  id: 'ChartCard/Chart',
  variant: 'Chart',
  host: PreviewHost.content,
  width: 560,
  height: 440,
  builder: (final context, final fixtures, final controller, final update) =>
      ChartCard(
        title: 'CPU usage',
        isLoading: false,
        chart: SizedBox(
          height: 200,
          child: CpuChart(
            data: [demoSeries()],
            period: Period.hour,
            start: referenceTime,
          ),
        ),
        legendItems: const [],
        trailing: const [],
      ),
);

@UseCase(name: 'Legend and action', type: ChartCard, path: '[Molecules]/cards')
Widget chartCardLegendAndAction(final BuildContext context) => CatalogCase(
  key: const ValueKey('ChartCard/Legend and action'),
  id: 'ChartCard/Legend and action',
  variant: 'Legend and action',
  host: PreviewHost.content,
  width: 560,
  height: 440,
  builder: (final context, final fixtures, final controller, final update) =>
      ChartCard(
        title: 'CPU usage',
        isLoading: false,
        chart: SizedBox(
          height: 200,
          child: CpuChart(
            data: [demoSeries()],
            period: Period.hour,
            start: referenceTime,
          ),
        ),
        legendItems: [
          Legend(color: Theme.of(context).colorScheme.primary, text: 'CPU'),
        ],
        trailing: [
          ListTile(
            title: const Text('Details'),
            onTap: () => catalogActions.record('Details'),
          ),
        ],
      ),
);
