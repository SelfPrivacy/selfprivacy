import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/chart_elements/colored_circle.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Primary', type: ColoredCircle, path: '[Atoms]/chart_elements')
Widget coloredCirclePrimary(final BuildContext context) => CatalogCase(
  key: const ValueKey('ColoredCircle/Primary'),
  id: 'ColoredCircle/Primary',
  variant: 'Primary',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      ColoredCircle(color: Theme.of(context).colorScheme.primary),
);

@UseCase(name: 'Error', type: ColoredCircle, path: '[Atoms]/chart_elements')
Widget coloredCircleError(final BuildContext context) => CatalogCase(
  key: const ValueKey('ColoredCircle/Error'),
  id: 'ColoredCircle/Error',
  variant: 'Error',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      ColoredCircle(color: Theme.of(context).colorScheme.error),
);
