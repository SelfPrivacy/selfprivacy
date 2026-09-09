import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/progress_indicators/brand_loader.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(
  name: 'Loading',
  type: HorizontalLoader,
  path: '[Atoms]/progress_indicators',
)
Widget horizontalLoaderLoading(final BuildContext context) => CatalogCase(
  key: const ValueKey('HorizontalLoader/Loading'),
  id: 'HorizontalLoader/Loading',
  variant: 'Loading',
  host: PreviewHost.content,
  width: 560,
  height: 140,
  builder: (final context, final fixtures, final controller, final update) =>
      const HorizontalLoader(),
);
