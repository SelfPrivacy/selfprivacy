import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';

class DeleteUserTile extends StatelessWidget {
  const DeleteUserTile({required this.user, super.key});

  final User user;

  @override
  Widget build(final BuildContext context) => ListTile(
    iconColor: Theme.of(context).colorScheme.error,
    textColor: Theme.of(context).colorScheme.error,
    onTap: () async {
      final confirmed = await showDialog<bool>(
        context: context,
        useRootNavigator: false,
        builder: (final BuildContext context) => AlertDialog(
          title: Text('basis.confirmation'.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('users.delete_confirm_question'.tr())],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('basis.cancel'.tr()),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(
                'basis.delete'.tr(),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );
      if (confirmed != true || !context.mounted) {
        return;
      }
      context.read<JobsCubit>().addJob(DeleteUserJob(user: user));
      await context.router.maybePop();
    },
    leading: const Icon(Icons.person_remove_outlined),
    title: Text('users.delete_user'.tr()),
  );
}
