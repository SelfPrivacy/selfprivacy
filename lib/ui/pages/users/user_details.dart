part of 'users.dart';

class _UserDetails extends StatelessWidget {
  const _UserDetails({
    required this.user,
    required this.isRootUser,
  });

  final User user;
  final bool isRootUser;
  @override
  Widget build(final BuildContext context) {
    final ServerInstallationState config =
        context.watch<ServerInstallationCubit>().state;

    final String domainName = UiHelpers.getDomainName(config);

    return BrandHeroScreen(
      hasBackButton: true,
      heroTitle: user.login,
      children: [
        BrandCards.filled(
          child: Column(
            children: [
              ListTile(
                title: Text('${user.login}@$domainName'),
                subtitle: Text('users.email_login'.tr()),
                textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                leading: const Icon(Icons.alternate_email_outlined),
                iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        BrandCards.filled(
          child: Column(
            children: [
              ListTile(
                title: Text('ssh.title'.tr()),
                textColor: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const Divider(height: 0),
              ListTile(
                iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
                textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                title: Text(
                  'ssh.create'.tr(),
                ),
                leading: const Icon(Icons.add_circle_outlined),
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (final BuildContext context) => Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: NewSshKey(user),
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
                  return ListTile(
                    textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    title: Text('$keyName ($keyType)'),
                    // do not overflow text
                    subtitle: Text(
                      publicKey,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                                style: const TextStyle(
                                  color: BrandColors.red1,
                                ),
                              ),
                              onPressed: () {
                                context.read<JobsCubit>().addJob(
                                      DeleteSSHKeyJob(
                                        user: user,
                                        publicKey: key,
                                      ),
                                    );
                                Navigator.of(context)
                                  ..pop()
                                  ..pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          iconColor: Theme.of(context).colorScheme.onBackground,
          onTap: () => {},
          leading: const Icon(Icons.lock_reset_outlined),
          title: Text(
            'users.reset_password'.tr(),
          ),
        ),
        if (!isRootUser)
          ListTile(
            iconColor: Theme.of(context).colorScheme.error,
            textColor: Theme.of(context).colorScheme.error,
            onTap: () => {
              showDialog(
                context: context,
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
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        'basis.delete'.tr(),
                        style: const TextStyle(
                          color: BrandColors.red1,
                        ),
                      ),
                      onPressed: () {
                        context
                            .read<JobsCubit>()
                            .addJob(DeleteUserJob(user: user));
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                    ),
                  ],
                ),
              )
            },
            leading: const Icon(Icons.person_remove_outlined),
            title: Text(
              'users.delete_user'.tr(),
            ),
          ),
        const Divider(height: 8),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_outlined, size: 24),
              const SizedBox(height: 16),
              Text(
                'users.no_sso_notice'.tr(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
