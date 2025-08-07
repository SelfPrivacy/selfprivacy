import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/cards/permissions_card.dart';
import 'package:selfprivacy/ui/molecules/cards/ssh_keys_card.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/pages/users/reset_password/reset_password_tile.dart';
import 'package:selfprivacy/ui/pages/users/user_details_page/widgets/edit_user_tile.dart';
import 'package:selfprivacy/ui/pages/users/user_details_page/widgets/widgets.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

@RoutePage()
class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({required this.login, super.key});

  final String login;

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationState config =
        context.watch<ServerInstallationCubit>().state;

    final String domainName = UiHelpers.getDomainName(config);

    final User user = context.watch<UsersBloc>().state.users.firstWhere(
      (final User user) => user.login == login,
      orElse:
          () =>
              const User(type: UserType.normal, login: 'error', note: 'ERROR'),
    );

    if (user.note == 'ERROR') {
      return BrandHeroScreen(
        hasBackButton: true,
        hasFlashButton: true,
        heroTitle: 'basis.error'.tr(),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: EmptyPagePlaceholder(
                title: 'users.could_not_load_user'.tr(),
                iconData: Icons.error_outline_outlined,
              ),
            ),
          ),
        ],
      );
    }

    if (user.type == UserType.root) {
      return BrandHeroScreen(
        hasBackButton: true,
        hasFlashButton: true,
        heroTitle: 'ssh.root_title'.tr(),
        heroSubtitle: 'ssh.root_subtitle'.tr(),
        children: [SshKeysCard(user: user)],
      );
    }

    return BrandHeroScreen(
      hasBackButton: true,
      hasFlashButton: true,
      heroTitle: user.displayName ?? user.login,
      heroSubtitle:
          user.displayName != null && user.displayName != user.login
              ? user.login
              : null,
      heroIconWidget: CircleAvatar(child: Text(user.login[0].toUpperCase())),
      children: [
        UserEmailLoginCard(user: user, domainName: domainName),
        const Gap(8),
        PermissionsCard(user: user),
        const Gap(8),
        SshKeysCard(user: user),
        const Gap(8),
        EditUserTile(user: user),
        const Gap(8),
        ResetPasswordTile(user: user),
        const Gap(8),
        DeleteUserTile(user: user),
      ],
    );
  }
}
