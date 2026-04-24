import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/router/router.dart';

class ResetPasswordTile extends StatelessWidget {
  const ResetPasswordTile({required this.user, super.key});

  final User user;

  @override
  Widget build(final BuildContext context) => ListTile(
    iconColor: Theme.of(context).colorScheme.onSurface,
    onTap: () => context.pushRoute(ResetPasswordRoute(user: user)),
    leading: const Icon(Icons.lock_reset_outlined),
    title: Text('users.request_password_reset_link'.tr()),
  );
}
