// ignore_for_file: deprecated_member_use_from_same_package
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/progress_indicators/brand_loader.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(
  name: 'Horizontal (deprecated)',
  type: BrandLoader,
  path: '[Atoms]/progress_indicators',
)
Widget brandLoaderHorizontalDeprecated(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('BrandLoader/Horizontal (deprecated)'),
      id: 'BrandLoader/Horizontal (deprecated)',
      variant: 'Horizontal (deprecated)',
      host: PreviewHost.content,
      width: 560,
      height: 140,
      builder:
          (final context, final fixtures, final controller, final update) =>
              BrandLoader.horizontal(),
    );
