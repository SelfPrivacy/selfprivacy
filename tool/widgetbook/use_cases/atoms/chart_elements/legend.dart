import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/chart_elements/legend.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Default', type: Legend, path: '[Atoms]/chart_elements')
Widget legendDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('Legend/Default'),
  id: 'Legend/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      Legend(
        color: Theme.of(context).colorScheme.primary,
        text: textKnob(context, 'Incoming'),
      ),
);

@UseCase(name: 'Long label', type: Legend, path: '[Atoms]/chart_elements')
Widget legendLongLabel(final BuildContext context) => CatalogCase(
  key: const ValueKey('Legend/Long label'),
  id: 'Legend/Long label',
  variant: 'Long label',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      Legend(
        color: Theme.of(context).colorScheme.primary,
        text: textKnob(
          context,
          'Incoming network traffic on the primary interface',
        ),
      ),
);
