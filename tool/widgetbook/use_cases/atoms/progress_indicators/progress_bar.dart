import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/progress_indicators/progress_bar.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(
  name: 'First step',
  type: ProgressBar,
  path: '[Atoms]/progress_indicators',
)
Widget progressBarFirstStep(final BuildContext context) => CatalogCase(
  key: const ValueKey('ProgressBar/First step'),
  id: 'ProgressBar/First step',
  variant: 'First step',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      const ProgressBar(steps: 5, activeIndex: 0),
);

@UseCase(
  name: 'Middle step',
  type: ProgressBar,
  path: '[Atoms]/progress_indicators',
)
Widget progressBarMiddleStep(final BuildContext context) => CatalogCase(
  key: const ValueKey('ProgressBar/Middle step'),
  id: 'ProgressBar/Middle step',
  variant: 'Middle step',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      const ProgressBar(steps: 5, activeIndex: 2),
);

@UseCase(
  name: 'Last step',
  type: ProgressBar,
  path: '[Atoms]/progress_indicators',
)
Widget progressBarLastStep(final BuildContext context) => CatalogCase(
  key: const ValueKey('ProgressBar/Last step'),
  id: 'ProgressBar/Last step',
  variant: 'Last step',
  host: PreviewHost.content,
  width: 560,
  height: 100,
  builder: (final context, final fixtures, final controller, final update) =>
      const ProgressBar(steps: 5, activeIndex: 4),
);
