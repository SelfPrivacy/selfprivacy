import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/progress_indicators/brand_linear_indicator.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(
  name: 'Empty',
  type: BrandLinearIndicator,
  path: '[Atoms]/progress_indicators',
)
Widget brandLinearIndicatorEmpty(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandLinearIndicator/Empty'),
  id: 'BrandLinearIndicator/Empty',
  variant: 'Empty',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandLinearIndicator(
        value: numberKnob(context, 0),
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        height: 12,
      ),
);

@UseCase(
  name: 'Partial',
  type: BrandLinearIndicator,
  path: '[Atoms]/progress_indicators',
)
Widget brandLinearIndicatorPartial(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandLinearIndicator/Partial'),
  id: 'BrandLinearIndicator/Partial',
  variant: 'Partial',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandLinearIndicator(
        value: numberKnob(context, 0.45),
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        height: 12,
      ),
);

@UseCase(
  name: 'Full',
  type: BrandLinearIndicator,
  path: '[Atoms]/progress_indicators',
)
Widget brandLinearIndicatorFull(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandLinearIndicator/Full'),
  id: 'BrandLinearIndicator/Full',
  variant: 'Full',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandLinearIndicator(
        value: numberKnob(context, 1),
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        height: 12,
      ),
);
