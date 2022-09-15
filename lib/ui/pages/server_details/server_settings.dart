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
        SwitcherBlock(
          onChange: (final switched) {
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
          isActive: allowAutoUpgrade ?? false,
          child: _TextColumn(
            title: 'providers.server.settings.allow_autoupgrade'.tr(),
            value: 'providers.server.settings.allow_autoupgrade_hint'.tr(),
          ),
        ),
        const Divider(height: 0),
        SwitcherBlock(
          onChange: (final switched) {
            context
                .read<ServerDetailsCubit>()
                .repository
                .setAutoUpgradeSettings(
                  AutoUpgradeSettings(
                    enable: allowAutoUpgrade ?? false,
                    allowReboot: switched,
                  ),
                );
            setState(
              () {
                rebootAfterUpgrade = switched;
              },
            );
          },
          isActive: rebootAfterUpgrade ?? false,
          child: _TextColumn(
            title: 'providers.server.settings.reboot_after_upgrade'.tr(),
            value: 'providers.server.settings.reboot_after_upgrade_hint'.tr(),
          ),
        ),
        const Divider(height: 0),
        _Button(
          onTap: () {
            Navigator.of(context).push(
              materialRoute(
                const SelectTimezone(),
              ),
            );
          },
          child: _TextColumn(
            title: 'providers.server.settings.server_timezone'.tr(),
            value: serverDetailsState.serverTimezone.toString(),
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onTap,
    required this.child,
  });

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: child,
        ),
      );
}

class _TextColumn extends StatelessWidget {
  const _TextColumn({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;
  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BrandText.body1(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          BrandText.body1(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
}
