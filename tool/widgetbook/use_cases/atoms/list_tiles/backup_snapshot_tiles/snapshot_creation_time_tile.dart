import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/backup_snapshot_tiles/snapshot_creation_time_tile.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../../catalog_case.dart';
import '../../../../fixtures.dart';

@UseCase(
  name: 'Default',
  type: SnapshotCreationTimeTile,
  path: '[Atoms]/list_tiles/backup_snapshot_tiles',
)
Widget snapshotCreationTimeTileDefault(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('SnapshotCreationTimeTile/Default'),
      id: 'SnapshotCreationTimeTile/Default',
      variant: 'Default',
      host: PreviewHost.content,
      width: 560,
      height: 170,
      builder:
          (final context, final fixtures, final controller, final update) =>
              SnapshotCreationTimeTile(time: referenceTime),
    );
