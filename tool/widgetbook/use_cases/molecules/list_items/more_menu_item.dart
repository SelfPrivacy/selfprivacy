import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/list_items/more_menu_item.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Default', type: MoreMenuItem, path: '[Molecules]/list_items')
Widget moreMenuItemDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('MoreMenuItem/Default'),
  id: 'MoreMenuItem/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      MoreMenuItem(
        iconData: Icons.settings_outlined,
        title: 'Settings',
        subtitle: null,
        accent: false,
        goTo: () => const InitializingRoute(),
      ),
);

@UseCase(name: 'Subtitle', type: MoreMenuItem, path: '[Molecules]/list_items')
Widget moreMenuItemSubtitle(final BuildContext context) => CatalogCase(
  key: const ValueKey('MoreMenuItem/Subtitle'),
  id: 'MoreMenuItem/Subtitle',
  variant: 'Subtitle',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      MoreMenuItem(
        iconData: Icons.settings_outlined,
        title: 'Settings',
        subtitle: 'Appearance and language',
        accent: false,
        goTo: () => const InitializingRoute(),
      ),
);

@UseCase(name: 'Accent', type: MoreMenuItem, path: '[Molecules]/list_items')
Widget moreMenuItemAccent(final BuildContext context) => CatalogCase(
  key: const ValueKey('MoreMenuItem/Accent'),
  id: 'MoreMenuItem/Accent',
  variant: 'Accent',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      MoreMenuItem(
        iconData: Icons.settings_outlined,
        title: 'Settings',
        subtitle: null,
        accent: true,
        goTo: () => const InitializingRoute(),
      ),
);
