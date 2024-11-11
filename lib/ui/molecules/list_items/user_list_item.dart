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
        title: Text(
          user.login,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                decoration: isPrimaryUser
                    ? TextDecoration.underline
                    : user.isFoundOnServer
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
              ),
        ),
      );
}
