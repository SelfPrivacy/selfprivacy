import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/job.dart';

class DeleteUserTile extends StatelessWidget {
  const DeleteUserTile({required this.user, super.key});

  final User user;

  @override
  Widget build(final BuildContext context) => ListTile(
    iconColor: Theme.of(context).colorScheme.error,
    textColor: Theme.of(context).colorScheme.error,
    onTap:
        () => showDialog(
          context: context,
          // useRootNavigator: false,
          builder:
              (final BuildContext context) => AlertDialog(
                title: Text('basis.confirmation'.tr()),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('users.delete_confirm_question'.tr()),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('basis.cancel'.tr()),
                    onPressed: () async {
                      await context.router.maybePop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      'basis.delete'.tr(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    onPressed: () {
                      context.read<JobsCubit>().addJob(
                        DeleteUserJob(user: user),
                      );
                      unawaited(
                        context.router.childControllers.first.maybePop(),
                      );
                      unawaited(context.router.maybePop());
                    },
                  ),
                ],
              ),
        ),
    leading: const Icon(Icons.person_remove_outlined),
    title: Text('users.delete_user'.tr()),
  );
}
