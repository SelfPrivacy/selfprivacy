import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/list_tile_on_surface_variant.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/ui/organisms/modals/new_ssh_key_modal.dart';

class SshKeysCard extends StatelessWidget {
  const SshKeysCard({required this.user, super.key});

  final User user;

  @override
  Widget build(final BuildContext context) {
    final serverDetailsState = context.watch<ServerDetailsCubit>().state;
    final bool sshDisabled =
        serverDetailsState is Loaded && !serverDetailsState.sshSettings.enable;

    return FilledCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'ssh.title'.tr(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const Divider(height: 0),
          ListTileOnSurfaceVariant(
            title: 'ssh.create'.tr(),
            leadingIcon: Icons.add_circle_outline,
            onTap: () async {
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useRootNavigator: true,
                builder:
                    (final BuildContext context) => DraggableScrollableSheet(
                      expand: false,
                      maxChildSize: 0.9,
                      minChildSize: 0.3,
                      initialChildSize: 0.5,
                      builder:
                          (final context, final scrollController) =>
                              NewSshKeyModal(
                                user: user,
                                scrollController: scrollController,
                              ),
                    ),
              );
            },
          ),
          Column(
            children:
                user.sshKeys.map((final String fullKey) {
                  final keyParts = fullKey.split(' ');
                  final keyType = keyParts[0];
                  final publicKey = keyParts.length > 1 ? keyParts[1] : fullKey;
                  final keyName =
                      keyParts.length > 2
                          ? keyParts[2]
                          : 'ssh.no_key_name'.tr();

                  return ListTileOnSurfaceVariant(
                    title: '$keyName ($keyType)',
                    disableSubtitleOverflow: true,
                    // do not overflow text
                    subtitle: publicKey,
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder:
                            (final BuildContext context) =>
                                _DeleteSshKeyConfirmationDialog(
                                  fullKey: fullKey,
                                  keyType: keyType,
                                  publicKey: publicKey,
                                  keyName: keyName,
                                  user: user,
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
                  padding: const EdgeInsets.all(8),
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

class _DeleteSshKeyConfirmationDialog extends StatelessWidget {
  const _DeleteSshKeyConfirmationDialog({
    required this.fullKey,
    required this.keyName,
    required this.keyType,
    required this.publicKey,
    required this.user,
  });

  final String fullKey;
  final String keyName;
  final String keyType;
  final String publicKey;
  final User user;

  @override
  Widget build(final BuildContext context) => AlertDialog(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.link_off_outlined),
        const SizedBox(height: 16),
        Text(
          'ssh.delete'.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text(
            'ssh.delete_confirm_question'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Gap(8),
          Text('$keyName ($keyType)'),
          Text(
            publicKey,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontFamily: 'RobotoMono'),
          ),
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
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        onPressed: () async {
          context.read<JobsCubit>().addJob(
            DeleteSSHKeyJob(user: user, publicKey: fullKey),
          );
          await context.maybePop();
        },
      ),
    ],
  );
}
