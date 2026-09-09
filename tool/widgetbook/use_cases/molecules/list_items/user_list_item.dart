import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/molecules/list_items/user_list_item.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import '../../../catalog_case.dart';

@UseCase(name: 'Regular', type: UserListItem, path: '[Molecules]/list_items')
Widget userListItemRegular(final BuildContext context) => CatalogCase(
  key: const ValueKey('UserListItem/Regular'),
  id: 'UserListItem/Regular',
  variant: 'Regular',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const UserListItem(
        user: User.fake(
          login: 'alice',
          displayName: null,
          isFoundOnServer: true,
        ),
        isPrimaryUser: false,
      ),
);

@UseCase(name: 'Primary', type: UserListItem, path: '[Molecules]/list_items')
Widget userListItemPrimary(final BuildContext context) => CatalogCase(
  key: const ValueKey('UserListItem/Primary'),
  id: 'UserListItem/Primary',
  variant: 'Primary',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const UserListItem(
        user: User.fake(
          login: 'alice',
          displayName: null,
          isFoundOnServer: true,
        ),
        isPrimaryUser: true,
      ),
);

@UseCase(
  name: 'Display name',
  type: UserListItem,
  path: '[Molecules]/list_items',
)
Widget userListItemDisplayName(final BuildContext context) => CatalogCase(
  key: const ValueKey('UserListItem/Display name'),
  id: 'UserListItem/Display name',
  variant: 'Display name',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const UserListItem(
        user: User.fake(
          login: 'alice',
          displayName: 'Alice Example',
          isFoundOnServer: true,
        ),
        isPrimaryUser: false,
      ),
);

@UseCase(
  name: 'Missing on server',
  type: UserListItem,
  path: '[Molecules]/list_items',
)
Widget userListItemMissingOnServer(final BuildContext context) => CatalogCase(
  key: const ValueKey('UserListItem/Missing on server'),
  id: 'UserListItem/Missing on server',
  variant: 'Missing on server',
  host: PreviewHost.content,
  width: 560,
  height: 180,
  builder: (final context, final fixtures, final controller, final update) =>
      const UserListItem(
        user: User.fake(
          login: 'alice',
          displayName: null,
          isFoundOnServer: false,
        ),
        isPrimaryUser: false,
      ),
);
