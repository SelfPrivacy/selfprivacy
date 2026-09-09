import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/backup_snapshot_tiles/snapshot_id_tile.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../../catalog_case.dart';

@UseCase(
  name: 'Default',
  type: SnapshotIdTile,
  path: '[Atoms]/list_tiles/backup_snapshot_tiles',
)
Widget snapshotIdTileDefault(final BuildContext context) => CatalogCase(
  key: const ValueKey('SnapshotIdTile/Default'),
  id: 'SnapshotIdTile/Default',
  variant: 'Default',
  host: PreviewHost.content,
  width: 560,
  height: 170,
  builder: (final context, final fixtures, final controller, final update) =>
      const SnapshotIdTile(snapshotId: 'a1b2c3d4'),
);
