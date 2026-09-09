import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/backup_snapshot_tiles/snapshot_creation_reason_tile.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../../catalog_case.dart';

@UseCase(
  name: 'Manual',
  type: SnapshotCreationReasonTile,
  path: '[Atoms]/list_tiles/backup_snapshot_tiles',
)
Widget snapshotCreationReasonTileManual(final BuildContext context) {
  const variant = 'Manual';

  return CatalogCase(
    key: const ValueKey('SnapshotCreationReasonTile/Manual'),
    id: 'SnapshotCreationReasonTile/Manual',
    variant: 'Manual',
    host: PreviewHost.content,
    width: 560,
    height: 170,
    builder: (final context, final fixtures, final controller, final update) =>
        const SnapshotCreationReasonTile(
          reason: variant == 'Manual' ? 'Manual backup' : 'Automatic backup',
        ),
  );
}

@UseCase(
  name: 'Automatic',
  type: SnapshotCreationReasonTile,
  path: '[Atoms]/list_tiles/backup_snapshot_tiles',
)
Widget snapshotCreationReasonTileAutomatic(final BuildContext context) {
  const variant = 'Automatic';

  return CatalogCase(
    key: const ValueKey('SnapshotCreationReasonTile/Automatic'),
    id: 'SnapshotCreationReasonTile/Automatic',
    variant: 'Automatic',
    host: PreviewHost.content,
    width: 560,
    height: 170,
    builder: (final context, final fixtures, final controller, final update) =>
        const SnapshotCreationReasonTile(
          reason: variant == 'Manual' ? 'Manual backup' : 'Automatic backup',
        ),
  );
}
