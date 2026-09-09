import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/storage_list_items/service_migration_list_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';
import '../../../fixtures.dart';

@UseCase(
  name: 'System disk',
  type: ServiceMigrationListItem,
  path: '[Organisms]/storage_list_items',
)
Widget serviceMigrationListItemSystemDisk(final BuildContext context) {
  String selectedVolume = 'sda1';
  return CatalogCase(
    key: const ValueKey('ServiceMigrationListItem/System disk'),
    id: 'ServiceMigrationListItem/System disk',
    variant: 'System disk',
    host: PreviewHost.content,
    width: 560,
    height: 340,
    builder: (final context, final fixtures, final controller, final update) =>
        ServiceMigrationListItem(
          service: demoService(),
          diskStatus: demoDisks(),
          selectedVolume: selectedVolume,
          onChange: (final volume, final service) =>
              update(() => selectedVolume = volume),
        ),
  );
}

@UseCase(
  name: 'Data disk',
  type: ServiceMigrationListItem,
  path: '[Organisms]/storage_list_items',
)
Widget serviceMigrationListItemDataDisk(final BuildContext context) {
  String selectedVolume = 'data';
  return CatalogCase(
    key: const ValueKey('ServiceMigrationListItem/Data disk'),
    id: 'ServiceMigrationListItem/Data disk',
    variant: 'Data disk',
    host: PreviewHost.content,
    width: 560,
    height: 340,
    builder: (final context, final fixtures, final controller, final update) =>
        ServiceMigrationListItem(
          service: demoService(),
          diskStatus: demoDisks(),
          selectedVolume: selectedVolume,
          onChange: (final volume, final service) =>
              update(() => selectedVolume = volume),
        ),
  );
}
