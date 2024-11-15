import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/router/router.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    required this.user,
    required this.isPrimaryUser,
    super.key,
  });

  final User user;
  final bool isPrimaryUser;

  // TODO: Show user's display name and avatar when supported by backend
  @override
  Widget build(final BuildContext context) => ListTile(
        onTap: () {
          context.pushRoute(UserDetailsRoute(login: user.login));
        },
        leading: CircleAvatar(
          backgroundColor: user.color,
          child: Text(
            user.login[0].toUpperCase(),
          ),
        ),
        trailing: isPrimaryUser
            ? Icon(
                Icons.admin_panel_settings_outlined,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
        title: Text(
          user.login,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                decoration: user.isFoundOnServer
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
              ),
        ),
      );
}