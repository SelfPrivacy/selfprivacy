import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/list_tile_on_surface_variant.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/ui/organisms/modals/new_ssh_key_modal.dart';
import 'package:selfprivacy/ui/organisms/modals/reset_password_modal.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';
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
          _SshKeysCard(user: user),
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
        _UserLogins(user: user, domainName: domainName),
        const SizedBox(height: 8),
        _SshKeysCard(user: user),
        const SizedBox(height: 8),
        ListTile(
          iconColor: Theme.of(context).colorScheme.onSurface,
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            builder: (final BuildContext context) => DraggableScrollableSheet(
              expand: false,
              maxChildSize: 0.9,
              minChildSize: 0.3,
              initialChildSize: 0.5,
              builder: (final context, final scrollController) =>
                  ResetPasswordModal(
                user: user,
                scrollController: scrollController,
              ),
            ),
          ),
          leading: const Icon(Icons.lock_reset_outlined),
          title: Text(
            'users.reset_password'.tr(),
          ),
        ),
        if (user.type == UserType.normal) _DeleteUserTile(user: user),
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

class _DeleteUserTile extends StatelessWidget {
  const _DeleteUserTile({
    required this.user,
  });

  final User user;

  @override
  Widget build(final BuildContext context) => ListTile(
        iconColor: Theme.of(context).colorScheme.error,
        textColor: Theme.of(context).colorScheme.error,
        onTap: () => showDialog(
          context: context,
          // useRootNavigator: false,
          builder: (final BuildContext context) => AlertDialog(
            title: Text('basis.confirmation'.tr()),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'users.delete_confirm_question'.tr(),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('basis.cancel'.tr()),
                onPressed: () {
                  context.router.maybePop();
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
                  context.read<JobsCubit>().addJob(DeleteUserJob(user: user));
                  context.router.childControllers.first.maybePop();
                  context.router.maybePop();
                },
              ),
            ],
          ),
        ),
        leading: const Icon(Icons.person_remove_outlined),
        title: Text(
          'users.delete_user'.tr(),
        ),
      );
}

class _UserLogins extends StatelessWidget {
  const _UserLogins({
    required this.user,
    required this.domainName,
  });

  final User user;
  final String domainName;

  @override
  Widget build(final BuildContext context) {
    final email = '${user.login}@$domainName';
    return FilledCard(
      child: Column(
        children: [
          ListTileOnSurfaceVariant(
            onTap: () {
              PlatformAdapter.setClipboard(email);
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
            title: email,
            subtitle: 'users.email_login'.tr(),
            leadingIcon: Icons.alternate_email_outlined,
          ),
        ],
      ),
    );
  }
}

class _SshKeysCard extends StatelessWidget {
  const _SshKeysCard({
    required this.user,
  });

  final User user;

  @override
  Widget build(final BuildContext context) {
    final serverDetailsState = context.watch<ServerDetailsCubit>().state;
    final bool sshDisabled =
        serverDetailsState is Loaded && !serverDetailsState.sshSettings.enable;

    return FilledCard(
      child: Column(
        children: [
          ListTileOnSurfaceVariant(
            title: 'ssh.title'.tr(),
          ),
          const Divider(height: 0),
          ListTileOnSurfaceVariant(
            title: 'ssh.create'.tr(),
            leadingIcon: Icons.add_circle_outline,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useRootNavigator: true,
                builder: (final BuildContext context) =>
                    DraggableScrollableSheet(
                  expand: false,
                  maxChildSize: 0.9,
                  minChildSize: 0.3,
                  initialChildSize: 0.5,
                  builder: (final context, final scrollController) =>
                      NewSshKeyModal(
                    user: user,
                    scrollController: scrollController,
                  ),
                ),
              );
            },
          ),
          Column(
            children: user.sshKeys.map((final String key) {
              final publicKey =
                  key.split(' ').length > 1 ? key.split(' ')[1] : key;
              final keyType = key.split(' ')[0];
              final keyName = key.split(' ').length > 2
                  ? key.split(' ')[2]
                  : 'ssh.no_key_name'.tr();
              return ListTileOnSurfaceVariant(
                title: '$keyName ($keyType)',
                disableSubtitleOverflow: true,
                // do not overflow text
                subtitle: publicKey,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (final BuildContext context) => AlertDialog(
                      title: Text('ssh.delete'.tr()),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('ssh.delete_confirm_question'.tr()),
                            Text('$keyName ($keyType)'),
                            Text(publicKey),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('basis.cancel'.tr()),
                          onPressed: () {
                            Navigator.of(context).pop();
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
                                  DeleteSSHKeyJob(
                                    user: user,
                                    publicKey: key,
                                  ),
                                );
                            context.maybePop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          if (sshDisabled)
            Column(
              children: [
                const Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InfoBox(
                    text: 'ssh.ssh_disabled_warning'.tr(),
                    isWarning: true,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
