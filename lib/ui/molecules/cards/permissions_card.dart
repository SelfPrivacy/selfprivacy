import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

class PermissionsCard extends StatelessWidget {
  const PermissionsCard({required this.user, super.key});

  final User user;

  @override
  Widget build(final BuildContext context) => FilledCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'users.permissions'.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const Divider(height: 0),
        InkResponse(
          highlightShape: BoxShape.rectangle,
          onTap: () => context.pushRoute(NewUserRoute(user: user)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...user.directmemberof?.map(
                    (final String group) =>
                        ExplicitPermissionTile(group: group),
                  ) ??
                  [],
              ...user.directmemberof?.isEmpty ?? false
                  ? [const ExplicitPermissionTile(group: 'sp.only_email')]
                  : [],
            ],
          ),
        ),
      ],
    ),
  );
}

class ExplicitPermissionTile extends StatelessWidget {
  const ExplicitPermissionTile({required this.group, super.key});

  final String group;

  @override
  Widget build(final BuildContext context) {
    if (group == 'sp.full_users') {
      return ListTile(
        leading: Icon(
          Icons.people_alt_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        title: Text('users.groups_full_user_title'.tr()),
        subtitle: Text('users.groups_full_user_short_description'.tr()),
      );
    }
    if (group == 'sp.admins') {
      return ListTile(
        leading: Icon(
          Icons.admin_panel_settings_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        textColor: Theme.of(context).colorScheme.primary,
        title: Text('users.groups_admin_title'.tr()),
        subtitle: Text('users.groups_admin_short_description'.tr()),
      );
    }
    if (group == 'sp.only_email') {
      return ListTile(
        leading: Icon(
          Icons.email_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        title: Text('users.groups_only_email_title'.tr()),
        subtitle: Text('users.groups_only_email_short_description'.tr()),
      );
    }

    if (group.split('.').length == 3) {
      final parts = group.split('.');
      final service = context.watch<ServicesBloc>().state.getServiceById(
        parts[1],
      );
      return ListTile(
        leading:
            service != null
                ? SvgPicture.string(
                  service.svgIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                )
                : Icon(
                  Icons.question_mark_outlined,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
        textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        title: Text(
          service != null
              ? UiHelpers.permissionTitle(parts[2], service.displayName)
              : group,
        ),
      );
    }
    return ListTile(
      leading: Icon(
        Icons.question_mark_outlined,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      textColor: Theme.of(context).colorScheme.onSurfaceVariant,
      title: Text(group),
    );
  }
}
