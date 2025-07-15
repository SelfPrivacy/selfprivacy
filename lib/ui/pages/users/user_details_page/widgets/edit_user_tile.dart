import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/router/router.dart';

class EditUserTile extends StatelessWidget {
  const EditUserTile({required this.user, super.key});

  final User user;

  @override
  Widget build(final BuildContext context) => ListTile(
    iconColor: Theme.of(context).colorScheme.onSurface,
    onTap: () => context.pushRoute(NewUserRoute(user: user)),
    leading: const Icon(Icons.edit_outlined),
    title: Text('users.edit_user'.tr()),
  );
}
