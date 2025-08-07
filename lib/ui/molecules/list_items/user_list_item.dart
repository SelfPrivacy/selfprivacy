import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    required this.user,
    required this.isPrimaryUser,
    super.key,
  });

  final User user;
  final bool isPrimaryUser;

  // TODO(inex): Show user's display name and avatar when supported by backend
  @override
  Widget build(final BuildContext context) => ListTile(
    onTap: () async {
      await context.pushRoute(UserDetailsRoute(login: user.login));
    },
    leading: Skeleton.leaf(
      child: CircleAvatar(child: Text(user.login[0].toUpperCase())),
    ),
    trailing:
        isPrimaryUser
            ? Icon(
              Icons.admin_panel_settings_outlined,
              color: Theme.of(context).colorScheme.primary,
            )
            : null,
    title: Text(
      user.displayName ?? user.login,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
        decoration:
            user.isFoundOnServer
                ? TextDecoration.none
                : TextDecoration.lineThrough,
      ),
    ),
    subtitle:
        user.displayName != null && user.displayName != user.login
            ? Text(user.login)
            : null,
  );
}
