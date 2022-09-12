part of 'server_details_screen.dart';

class _ServerSettings extends StatelessWidget {
  const _ServerSettings({
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(final BuildContext context) {
    final serverDetailsState = context.watch<ServerDetailsCubit>().state;
    if (serverDetailsState is ServerDetailsNotReady) {
      return Text('basis.loading'.tr());
    } else if (serverDetailsState is! Loaded) {
      return BrandLoader.horizontal();
    }
    return ListView(
      padding: paddingH15V0,
      children: [
        const SizedBox(height: 10),
        Container(
          height: 52,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 1),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(BrandIcons.arrowLeft),
                onPressed: () => tabController.animateTo(0),
              ),
              const SizedBox(width: 10),
              BrandText.h4('basis.settings'.tr()),
            ],
          ),
        ),
        const BrandDivider(),
        SwitcherBlock(
          onChange: (final _) {},
          isActive: serverDetailsState.autoUpgradeSettings.enable,
          child: _TextColumn(
            title: 'providers.server.settings.allow_autoupgrade'.tr(),
            value: 'providers.server.settings.allow_autoupgrade_hint'.tr(),
          ),
        ),
        SwitcherBlock(
          onChange: (final _) {},
          isActive: serverDetailsState.autoUpgradeSettings.allowReboot,
          child: _TextColumn(
            title: 'providers.server.settings.reboot_after_upgrade'.tr(),
            value: 'providers.server.settings.reboot_after_upgrade_hint'.tr(),
          ),
        ),
        _Button(
          onTap: () {
            Navigator.of(context).push(materialRoute(const SelectTimezone()));
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
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: BrandColors.dividerColor),
            ),
          ),
          child: child,
        ),
      );
}

class _TextColumn extends StatelessWidget {
  const _TextColumn({
    required this.title,
    required this.value,
    this.hasWarning = false,
  });

  final String title;
  final String value;
  final bool hasWarning;
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
