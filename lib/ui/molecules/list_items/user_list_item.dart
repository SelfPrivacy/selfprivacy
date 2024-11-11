import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
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
  Widget build(final BuildContext context) => InkWell(
        onTap: () {
          context.pushRoute(UserDetailsRoute(login: user.login));
        },
        child: Container(
          padding: paddingH16V0,
          height: 48,
          child: Row(
            children: [
              Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  color: user.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Text(
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
              ),
            ],
          ),
        ),
      );
}
