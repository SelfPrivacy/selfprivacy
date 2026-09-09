import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/molecules/cards/permissions_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Email only', type: PermissionsCard, path: '[Molecules]/cards')
Widget permissionsCardEmailOnly(final BuildContext context) => CatalogCase(
  key: const ValueKey('PermissionsCard/Email only'),
  id: 'PermissionsCard/Email only',
  variant: 'Email only',
  host: PreviewHost.content,
  width: 560,
  height: 400,
  builder: (final context, final fixtures, final controller, final update) =>
      const PermissionsCard(
        user: User.fake(login: 'alice', directmemberof: []),
      ),
);

@UseCase(
  name: 'Administrator',
  type: PermissionsCard,
  path: '[Molecules]/cards',
)
Widget permissionsCardAdministrator(final BuildContext context) => CatalogCase(
  key: const ValueKey('PermissionsCard/Administrator'),
  id: 'PermissionsCard/Administrator',
  variant: 'Administrator',
  host: PreviewHost.content,
  width: 560,
  height: 400,
  builder: (final context, final fixtures, final controller, final update) =>
      const PermissionsCard(
        user: User.fake(
          login: 'alice',
          directmemberof: ['sp.admins', 'sp.full_users'],
        ),
      ),
);

@UseCase(
  name: 'Service permissions',
  type: PermissionsCard,
  path: '[Molecules]/cards',
)
Widget permissionsCardServicePermissions(final BuildContext context) =>
    CatalogCase(
      key: const ValueKey('PermissionsCard/Service permissions'),
      id: 'PermissionsCard/Service permissions',
      variant: 'Service permissions',
      host: PreviewHost.content,
      width: 560,
      height: 400,
      builder:
          (final context, final fixtures, final controller, final update) =>
              const PermissionsCard(
                user: User.fake(
                  login: 'alice',
                  directmemberof: ['sp.nextcloud.user', 'custom-group'],
                ),
              ),
    );
