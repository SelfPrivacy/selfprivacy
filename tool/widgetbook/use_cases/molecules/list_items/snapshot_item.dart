import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/list_items/snapshot_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(name: 'Default', type: SnapshotItem, path: '[Molecules]/list_items')
Widget snapshotItemDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('SnapshotItem/Default'),
  id: 'SnapshotItem/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      SnapshotItem(
        backup: demoBackup(),
        preventActions: false,
        overrideColor: null,
      ),
);

@UseCase(name: 'Disabled', type: SnapshotItem, path: '[Molecules]/list_items')
Widget snapshotItemDisabled(final BuildContext context) => CatalogCase(
  key: const ValueKey('SnapshotItem/Disabled'),
  id: 'SnapshotItem/Disabled',
  variant: 'Disabled',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      SnapshotItem(
        backup: demoBackup(),
        preventActions: true,
        overrideColor: null,
      ),
);

@UseCase(
  name: 'Missing service',
  type: SnapshotItem,
  path: '[Molecules]/list_items',
)
Widget snapshotItemMissingService(final BuildContext context) => CatalogCase(
  key: const ValueKey('SnapshotItem/Missing service'),
  id: 'SnapshotItem/Missing service',
  variant: 'Missing service',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      SnapshotItem(
        backup: demoBackup(),
        preventActions: false,
        overrideColor: null,
      ),
);

@UseCase(
  name: 'Custom color',
  type: SnapshotItem,
  path: '[Molecules]/list_items',
)
Widget snapshotItemCustomColor(final BuildContext context) => CatalogCase(
  key: const ValueKey('SnapshotItem/Custom color'),
  id: 'SnapshotItem/Custom color',
  variant: 'Custom color',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      SnapshotItem(
        backup: demoBackup(),
        preventActions: false,
        overrideColor: Theme.of(context).colorScheme.error,
      ),
);
