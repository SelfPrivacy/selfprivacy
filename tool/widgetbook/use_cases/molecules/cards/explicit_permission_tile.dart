import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/cards/permissions_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(
  name: 'Full user',
  type: ExplicitPermissionTile,
  path: '[Molecules]/cards',
)
Widget explicitPermissionTileFullUser(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('ExplicitPermissionTile/Full user'),
      id: 'ExplicitPermissionTile/Full user',
      variant: 'Full user',
      host: PreviewHost.content,
      width: 560,
      height: 220,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const ExplicitPermissionTile(group: 'sp.full_users'),
    );

@UseCase(name: 'Admin', type: ExplicitPermissionTile, path: '[Molecules]/cards')
Widget explicitPermissionTileAdmin(final BuildContext context) => CatalogCase(
  key: const ValueKey('ExplicitPermissionTile/Admin'),
  id: 'ExplicitPermissionTile/Admin',
  variant: 'Admin',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      const ExplicitPermissionTile(group: 'sp.admins'),
);

@UseCase(name: 'Email', type: ExplicitPermissionTile, path: '[Molecules]/cards')
Widget explicitPermissionTileEmail(final BuildContext context) => CatalogCase(
  key: const ValueKey('ExplicitPermissionTile/Email'),
  id: 'ExplicitPermissionTile/Email',
  variant: 'Email',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      const ExplicitPermissionTile(group: 'sp.only_email'),
);

@UseCase(
  name: 'Service',
  type: ExplicitPermissionTile,
  path: '[Molecules]/cards',
)
Widget explicitPermissionTileService(final BuildContext context) => CatalogCase(
  key: const ValueKey('ExplicitPermissionTile/Service'),
  id: 'ExplicitPermissionTile/Service',
  variant: 'Service',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      const ExplicitPermissionTile(group: 'sp.nextcloud.user'),
);

@UseCase(
  name: 'Missing service',
  type: ExplicitPermissionTile,
  path: '[Molecules]/cards',
)
Widget explicitPermissionTileMissingService(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('ExplicitPermissionTile/Missing service'),
      id: 'ExplicitPermissionTile/Missing service',
      variant: 'Missing service',
      host: PreviewHost.content,
      width: 560,
      height: 220,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const ExplicitPermissionTile(group: 'sp.missing.user'),
    );

@UseCase(
  name: 'Unknown',
  type: ExplicitPermissionTile,
  path: '[Molecules]/cards',
)
Widget explicitPermissionTileUnknown(final BuildContext context) => CatalogCase(
  key: const ValueKey('ExplicitPermissionTile/Unknown'),
  id: 'ExplicitPermissionTile/Unknown',
  variant: 'Unknown',
  host: PreviewHost.content,
  width: 560,
  height: 220,
  builder: (final context, final fixtures, final controller, final update) =>
      const ExplicitPermissionTile(group: 'custom-group'),
);
