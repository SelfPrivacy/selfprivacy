import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/storage_list_items/server_storage_list_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(
  name: 'Root',
  type: ServerStorageListItem,
  path: '[Organisms]/storage_list_items',
)
Widget serverStorageListItemRoot(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerStorageListItem/Root'),
  id: 'ServerStorageListItem/Root',
  variant: 'Root',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerStorageListItem(
        volume: demoVolume(full: false, root: true),
        dense: false,
        showIcon: true,
      ),
);

@UseCase(
  name: 'Data',
  type: ServerStorageListItem,
  path: '[Organisms]/storage_list_items',
)
Widget serverStorageListItemData(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerStorageListItem/Data'),
  id: 'ServerStorageListItem/Data',
  variant: 'Data',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerStorageListItem(
        volume: demoVolume(full: false, root: false),
        dense: false,
        showIcon: true,
      ),
);

@UseCase(
  name: 'Full',
  type: ServerStorageListItem,
  path: '[Organisms]/storage_list_items',
)
Widget serverStorageListItemFull(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerStorageListItem/Full'),
  id: 'ServerStorageListItem/Full',
  variant: 'Full',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerStorageListItem(
        volume: demoVolume(full: true, root: true),
        dense: false,
        showIcon: true,
      ),
);

@UseCase(
  name: 'Dense',
  type: ServerStorageListItem,
  path: '[Organisms]/storage_list_items',
)
Widget serverStorageListItemDense(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerStorageListItem/Dense'),
  id: 'ServerStorageListItem/Dense',
  variant: 'Dense',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerStorageListItem(
        volume: demoVolume(full: false, root: true),
        dense: true,
        showIcon: true,
      ),
);

@UseCase(
  name: 'No icon',
  type: ServerStorageListItem,
  path: '[Organisms]/storage_list_items',
)
Widget serverStorageListItemNoIcon(final BuildContext context) => CatalogCase(
  key: const ValueKey('ServerStorageListItem/No icon'),
  id: 'ServerStorageListItem/No icon',
  variant: 'No icon',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      ServerStorageListItem(
        volume: demoVolume(full: false, root: true),
        dense: false,
        showIcon: false,
      ),
);
