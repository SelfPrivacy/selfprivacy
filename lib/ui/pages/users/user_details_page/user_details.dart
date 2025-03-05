import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/ui/pages/users/user_details_page/widgets/widgets.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

@RoutePage()
class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({
    required this.login,
    super.key,
  });

  final String login;

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationState config =
        context.watch<ServerInstallationCubit>().state;

    final String domainName = UiHelpers.getDomainName(config);

    final User user = context.watch<UsersBloc>().state.users.firstWhere(
          (final User user) => user.login == login,
          orElse: () => const User(
            type: UserType.normal,
            login: 'error',
          ),
        );

    if (user.type == UserType.root) {
      return BrandHeroScreen(
        hasBackButton: true,
        hasFlashButton: true,
        heroTitle: 'ssh.root_title'.tr(),
        heroSubtitle: 'ssh.root_subtitle'.tr(),
        children: [
          SshKeysCard(user: user),
        ],
      );
    }

    return BrandHeroScreen(
      hasBackButton: true,
      hasFlashButton: true,
      heroTitle: user.login,
      heroIconWidget: CircleAvatar(
        backgroundColor: user.color,
        child: Text(
          user.login[0].toUpperCase(),
        ),
      ),
      children: [
        UserLoginTile(user: user, domainName: domainName),
        const Gap(8),
        SshKeysCard(user: user),
        const Gap(8),
        ResetPasswordTile(user: user),
        const Gap(8),
        if (user.type == UserType.normal) DeleteUserTile(user: user),
        const Divider(height: 8),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InfoBox(
            text: 'users.no_ssh_notice'.tr(),
            isWarning: true,
          ),
        ),
      ],
    );
  }
}
