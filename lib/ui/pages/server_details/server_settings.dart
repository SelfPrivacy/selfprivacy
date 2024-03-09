part of 'server_settings_screen.dart';

class _ServerSettings extends StatefulWidget {
  const _ServerSettings();

  @override
  State<_ServerSettings> createState() => _ServerSettingsState();
}

class _ServerSettingsState extends State<_ServerSettings> {
  bool? allowAutoUpgrade;
  bool? rebootAfterUpgrade;
  bool? enableSsh;
  bool? allowPasswordAuthentication;

  @override
  Widget build(final BuildContext context) {
    final serverDetailsState = context.watch<ServerDetailsCubit>().state;
    if (serverDetailsState is ServerDetailsNotReady) {
      return Text('basis.loading'.tr());
    } else if (serverDetailsState is! Loaded) {
      return BrandLoader.horizontal();
    }
    if (allowAutoUpgrade == null || rebootAfterUpgrade == null) {
      allowAutoUpgrade = serverDetailsState.autoUpgradeSettings.enable;
      rebootAfterUpgrade = serverDetailsState.autoUpgradeSettings.allowReboot;
    }

    if (enableSsh == null || allowPasswordAuthentication == null) {
      enableSsh = serverDetailsState.sshSettings.enable;
      allowPasswordAuthentication =
          serverDetailsState.sshSettings.passwordAuthentication;
    }

    return Column(
      children: [
        SwitchListTile(
          value: allowAutoUpgrade ?? false,
          onChanged: (final switched) {
            context.read<JobsCubit>().addJob(
                  ChangeAutoUpgradeSettingsJob(
                    allowReboot: rebootAfterUpgrade ?? false,
                    enable: switched,
                  ),
                );
            setState(() {
              allowAutoUpgrade = switched;
            });
          },
          title: Text(
            'server.allow_autoupgrade'.tr(),
            style: TextStyle(
              fontStyle: allowAutoUpgrade !=
                      serverDetailsState.autoUpgradeSettings.enable
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          subtitle: Text(
            'server.allow_autoupgrade_hint'.tr(),
            style: TextStyle(
              fontStyle: allowAutoUpgrade !=
                      serverDetailsState.autoUpgradeSettings.enable
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        SwitchListTile(
          value: rebootAfterUpgrade ?? false,
          onChanged: (final switched) {
            context.read<JobsCubit>().addJob(
                  ChangeAutoUpgradeSettingsJob(
                    allowReboot: switched,
                    enable: allowAutoUpgrade ?? false,
                  ),
                );
            setState(() {
              rebootAfterUpgrade = switched;
            });
          },
          title: Text(
            'server.reboot_after_upgrade'.tr(),
            style: TextStyle(
              fontStyle: rebootAfterUpgrade !=
                      serverDetailsState.autoUpgradeSettings.allowReboot
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          subtitle: Text(
            'server.reboot_after_upgrade_hint'.tr(),
            style: TextStyle(
              fontStyle: rebootAfterUpgrade !=
                      serverDetailsState.autoUpgradeSettings.allowReboot
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        ListTile(
          title: Text('server.server_timezone'.tr()),
          subtitle: Text(
            serverDetailsState.serverTimezone.toString(),
          ),
          onTap: () {
            Navigator.of(context).push(
              materialRoute(
                const SelectTimezone(),
              ),
            );
          },
        ),
        SwitchListTile(
          value: enableSsh ?? true,
          onChanged: (final switched) {
            context.read<JobsCubit>().addJob(
                  ChangeSshSettingsJob(
                    enable: switched,
                    passwordAuthentication:
                        allowPasswordAuthentication ?? false,
                  ),
                );
            setState(() {
              enableSsh = switched;
            });
          },
          title: Text(
            'server.enable_ssh'.tr(),
            style: TextStyle(
              fontStyle: enableSsh != serverDetailsState.sshSettings.enable
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          subtitle: Text(
            'server.enable_ssh_hint'.tr(),
            style: TextStyle(
              fontStyle: enableSsh != serverDetailsState.sshSettings.enable
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        SwitchListTile(
          value: allowPasswordAuthentication ?? false,
          onChanged: (final switched) {
            context.read<JobsCubit>().addJob(
                  ChangeSshSettingsJob(
                    enable: enableSsh ?? true,
                    passwordAuthentication: switched,
                  ),
                );
            setState(() {
              allowPasswordAuthentication = switched;
            });
          },
          title: Text(
            'server.allow_password_authentication'.tr(),
            style: TextStyle(
              fontStyle: allowPasswordAuthentication !=
                      serverDetailsState.sshSettings.passwordAuthentication
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          subtitle: Text(
            'server.allow_password_authentication_hint'.tr(),
            style: TextStyle(
              fontStyle: allowPasswordAuthentication !=
                      serverDetailsState.sshSettings.passwordAuthentication
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
