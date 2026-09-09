import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/charts/server_charts.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Loaded', type: ServerCharts, path: '[Organisms]/charts')
Widget serverChartsLoaded(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerCharts/Loaded'),
  id: 'ServerCharts/Loaded',
  variant: 'Loaded',
  host: PreviewHost.scroll,
  width: 700,
  height: 1900,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerCharts(),
);

@UseCase(name: 'Loading', type: ServerCharts, path: '[Organisms]/charts')
Widget serverChartsLoading(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerCharts/Loading'),
  id: 'ServerCharts/Loading',
  variant: 'Loading',
  host: PreviewHost.scroll,
  width: 700,
  height: 1900,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerCharts(),
);

@UseCase(name: 'Legacy', type: ServerCharts, path: '[Organisms]/charts')
Widget serverChartsLegacy(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerCharts/Legacy'),
  id: 'ServerCharts/Legacy',
  variant: 'Legacy',
  host: PreviewHost.scroll,
  width: 700,
  height: 1900,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerCharts(),
);

@UseCase(name: 'Unsupported', type: ServerCharts, path: '[Organisms]/charts')
Widget serverChartsUnsupported(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerCharts/Unsupported'),
  id: 'ServerCharts/Unsupported',
  variant: 'Unsupported',
  host: PreviewHost.scroll,
  width: 700,
  height: 1900,
  builder: (final context, final fixtures, final controller, final update) =>
      const ServerCharts(),
);
