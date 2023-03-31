part of 'users.dart';

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

    final User user = context.watch<UsersCubit>().state.users.firstWhere(
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
      children: [
        _UserLogins(user: user, domainName: domainName),
        const SizedBox(height: 8),
        _SshKeysCard(user: user),
        const SizedBox(height: 8),
        ListTile(
          iconColor: Theme.of(context).colorScheme.onBackground,
          onTap: () => {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (final BuildContext context) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: ResetPassword(user: user),
              ),
            ),
          },
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
        onTap: () => {
          showDialog(
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
                    context.router.pop();
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
                    context.router.childControllers.first.pop();
                    context.router.pop();
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
  Widget build(final BuildContext context) => FilledCard(
        child: Column(
          children: [
            ListTileOnSurfaceVariant(
              title: '${user.login}@$domainName',
              subtitle: 'users.email_login'.tr(),
              leadingIcon: Icons.alternate_email_outlined,
            ),
          ],
        ),
      );
}

class _SshKeysCard extends StatelessWidget {
  const _SshKeysCard({
    required this.user,
  });

  final User user;

  @override
  Widget build(final BuildContext context) => FilledCard(
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
                              context.popRoute();
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
      );
}

class NewSshKey extends StatelessWidget {
  const NewSshKey(this.user, {super.key});
  final User user;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) {
      final jobCubit = context.read<JobsCubit>();
      final jobState = jobCubit.state;
      if (jobState is JobsStateWithJobs) {
        final jobs = jobState.clientJobList;
        for (final job in jobs) {
          if (job is CreateSSHKeyJob && job.user.login == user.login) {
            user.sshKeys.add(job.publicKey);
          }
        }
      }
      return SshFormCubit(
        jobsCubit: jobCubit,
        user: user,
      );
    },
    child: Builder(
      builder: (final context) {
        final formCubitState = context.watch<SshFormCubit>().state;

        return BlocListener<SshFormCubit, FormCubitState>(
          listener: (final context, final state) {
            if (state.isSubmitted) {
              Navigator.pop(context);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BrandHeader(
                title: user.login,
              ),
              const SizedBox(width: 14),
              Padding(
                padding: paddingH15V0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IntrinsicHeight(
                      child: CubitFormTextField(
                        formFieldCubit: context.read<SshFormCubit>().key,
                        decoration: InputDecoration(
                          labelText: 'ssh.input_label'.tr(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    BrandButton.rised(
                      onPressed: formCubitState.isSubmitting
                          ? null
                          : () =>
                              context.read<SshFormCubit>().trySubmit(),
                      text: 'ssh.create'.tr(),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
