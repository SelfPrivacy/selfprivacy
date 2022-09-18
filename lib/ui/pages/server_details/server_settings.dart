part of 'server_details_screen.dart';

class _ServerSettings extends StatefulWidget {
  const _ServerSettings();

  @override
  State<_ServerSettings> createState() => _ServerSettingsState();
}

class _ServerSettingsState extends State<_ServerSettings> {
  bool? allowAutoUpgrade;
  bool? rebootAfterUpgrade;

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

    return Column(
      children: [
        SwitchListTile(
          value: allowAutoUpgrade ?? false,
          onChanged: (final switched) {
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
