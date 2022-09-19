part of 'server_details_screen.dart';

class _ServerSettings extends StatefulWidget {
  const _ServerSettings();

  @override
  State<_ServerSettings> createState() => _ServerSettingsState();
}

class _ServerSettingsState extends State<_ServerSettings> {
  bool? allowAutoUpgrade;
  bool? rebootAfterUpgrade;
  bool? didSomethingChange;

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

    didSomethingChange ??= false;

    return Column(
      children: [
        SwitchListTile(
          value: allowAutoUpgrade ?? false,
          onChanged: (final switched) {
            if (didSomethingChange == false) {
              context.read<JobsCubit>().addJob(
                    RebuildServerJob(title: 'jobs.upgradeServer'.tr()),
                  );
            }
            context
                .read<ServerDetailsCubit>()
                .repository
                .setAutoUpgradeSettings(
                  AutoUpgradeSettings(
                    enable: switched,
                    allowReboot: rebootAfterUpgrade ?? false,
                  ),
                );
            setState(() {
              allowAutoUpgrade = switched;
              didSomethingChange = true;
            });
          },
          title: Text('providers.server.settings.allow_autoupgrade'.tr()),
          subtitle: Text(
            'providers.server.settings.allow_autoupgrade_hint'.tr(),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        SwitchListTile(
          value: rebootAfterUpgrade ?? false,
          onChanged: (final switched) {
            if (didSomethingChange == false) {
              context.read<JobsCubit>().addJob(
                    RebuildServerJob(title: 'jobs.upgradeServer'.tr()),
                  );
            }
            context
                .read<ServerDetailsCubit>()
                .repository
                .setAutoUpgradeSettings(
                  AutoUpgradeSettings(
                    enable: allowAutoUpgrade ?? false,
                    allowReboot: switched,
                  ),
                );
            setState(() {
              rebootAfterUpgrade = switched;
              didSomethingChange = true;
            });
          },
          title: Text('providers.server.settings.reboot_after_upgrade'.tr()),
          subtitle: Text(
            'providers.server.settings.reboot_after_upgrade_hint'.tr(),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        ListTile(
          title: Text('providers.server.settings.server_timezone'.tr()),
          subtitle: Text(
            serverDetailsState.serverTimezone.toString(),
          ),
          onTap: () {
            if (didSomethingChange == false) {
              context.read<JobsCubit>().addJob(
                    RebuildServerJob(title: 'jobs.upgradeServer'.tr()),
                  );
            }
            setState(() {
              didSomethingChange = true;
            });
            Navigator.of(context).push(
              materialRoute(
                const SelectTimezone(),
              ),
            );
          },
        ),
      ],
    );
  }
}
