import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/buttons/flash_fab.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Default', type: BrandFab, path: '[Molecules]/buttons')
Widget brandFabDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandFab/Default'),
  id: 'BrandFab/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 170,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandFab(onPressed: () => catalogActions.record('Open jobs')),
);

@UseCase(name: 'Extended', type: BrandFab, path: '[Molecules]/buttons')
Widget brandFabExtended(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandFab/Extended'),
  id: 'BrandFab/Extended',
  variant: 'Extended',
  host: PreviewHost.content,
  width: 560,
  height: 170,
  builder: (final context, final fixtures, final controller, final update) =>
      BrandFab(
        extended: true,
        onPressed: () => catalogActions.record('Open jobs'),
      ),
);
