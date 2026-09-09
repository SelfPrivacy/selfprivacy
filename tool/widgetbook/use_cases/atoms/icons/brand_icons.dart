import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'All icons', type: BrandIcons, path: '[Atoms]/icons')
Widget brandIconsAllIcons(final BuildContext context) => CatalogCase(
  key: const ValueKey('BrandIcons/All icons'),
  id: 'BrandIcons/All icons',
  variant: 'All icons',
  host: PreviewHost.content,
  width: 560,
  height: 120,
  builder: (final context, final fixtures, final controller, final update) =>
      const Wrap(
        spacing: 24,
        runSpacing: 24,
        children: [
          Icon(BrandIcons.save),
          Icon(BrandIcons.globe),
          Icon(BrandIcons.server),
          Icon(BrandIcons.box),
          Icon(BrandIcons.users),
          Icon(BrandIcons.terminal),
        ],
      ),
);
