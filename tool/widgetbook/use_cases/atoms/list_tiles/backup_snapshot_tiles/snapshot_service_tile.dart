import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/backup_snapshot_tiles/snapshot_service_tile.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../../catalog_case.dart';
import '../../../../fixtures.dart';

@UseCase(
  name: 'Known service',
  type: SnapshotServiceTile,
  path: '[Atoms]/list_tiles/backup_snapshot_tiles',
)
Widget snapshotServiceTileKnownService(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('SnapshotServiceTile/Known service'),
      id: 'SnapshotServiceTile/Known service',
      variant: 'Known service',
      host: PreviewHost.content,
      width: 560,
      height: 170,
      builder:
          (final context, final fixtures, final controller, final update) =>
              SnapshotServiceTile(
                service: demoService(),
                fallbackServiceName: 'Archived service',
              ),
    );

@UseCase(
  name: 'Missing service',
  type: SnapshotServiceTile,
  path: '[Atoms]/list_tiles/backup_snapshot_tiles',
)
Widget snapshotServiceTileMissingService(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('SnapshotServiceTile/Missing service'),
      id: 'SnapshotServiceTile/Missing service',
      variant: 'Missing service',
      host: PreviewHost.content,
      width: 560,
      height: 170,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const SnapshotServiceTile(
                service: null,
                fallbackServiceName: 'Archived service',
              ),
    );
