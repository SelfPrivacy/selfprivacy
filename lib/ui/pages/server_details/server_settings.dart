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
      return const Text('not ready');
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
          child: const _TextColumn(
            title: 'Allow Auto-upgrade',
            value: 'Wether to allow automatic packages upgrades',
            hasWarning: false,
          ),
        ),
        SwitcherBlock(
          onChange: (final _) {},
          isActive: serverDetailsState.autoUpgradeSettings.allowReboot,
          child: const _TextColumn(
            title: 'Reboot after upgrade',
            value: 'Reboot without prompt after applying updates',
            hasWarning: false,
          ),
        ),
        _Button(
          onTap: () {
            Navigator.of(context).push(materialRoute(const SelectTimezone()));
          },
          child: _TextColumn(
            title: 'Server Timezone',
            value: serverDetailsState.serverTimezone.timezone.name,
            hasWarning: false,
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
            style: TextStyle(color: hasWarning ? BrandColors.warning : null),
          ),
          const SizedBox(height: 5),
          BrandText.body1(
            value,
            style: TextStyle(
              fontSize: 13,
              height: 1.53,
              color: hasWarning ? BrandColors.warning : BrandColors.gray1,
            ),
          ),
        ],
      );
}
