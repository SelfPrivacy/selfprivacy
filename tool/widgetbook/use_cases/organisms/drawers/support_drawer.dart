import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/drawers/support_drawer.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Article', type: SupportDrawer, path: '[Organisms]/drawers')
Widget supportDrawerArticle(final BuildContext context) => CatalogCase(
  key: const ValueKey('SupportDrawer/Article'),
  id: 'SupportDrawer/Article',
  variant: 'Article',
  host: PreviewHost.drawer,
  width: 600,
  height: 800,
  builder: (final context, final fixtures, final controller, final update) =>
      const SupportDrawer(),
);
