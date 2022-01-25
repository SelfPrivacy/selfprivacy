part of 'server_details.dart';

class _ServerSettings extends StatelessWidget {
  const _ServerSettings({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: paddingH15V0,
      children: [
        SizedBox(height: 10),
        Container(
          height: 52,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 1),
          child: Container(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(BrandIcons.arrow_left),
                  onPressed: () => tabController.animateTo(0),
                ),
                SizedBox(width: 10),
                BrandText.h4('basis.settings'.tr()),
              ],
            ),
          ),
        ),
        BrandDivider(),
        SwitcherBlock(
          onChange: (_) {},
          child: _TextColumn(
            title: 'Allow Auto-upgrade',
            value: 'Wether to allow automatic packages upgrades',
          ),
          isActive: true,
        ),
        SwitcherBlock(
          onChange: (_) {},
          child: _TextColumn(
            title: 'Reboot after upgrade',
            value: 'Reboot without prompt after applying updates',
          ),
          isActive: false,
        ),
        _Button(
          onTap: () {
            Navigator.of(context).push(materialRoute(SelectTimezone()));
          },
          child: _TextColumn(
            title: 'Server Timezone',
            value: 'Europe/Kyiv',
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 5),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1, color: BrandColors.dividerColor),
        )),
        child: child,
      ),
    );
  }
}

class _TextColumn extends StatelessWidget {
  const _TextColumn({
    Key? key,
    required this.title,
    required this.value,
    this.hasWarning = false,
  }) : super(key: key);

  final String title;
  final String value;
  final bool hasWarning;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandText.body1(
          title,
          style: TextStyle(color: hasWarning ? BrandColors.warning : null),
        ),
        SizedBox(height: 5),
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
}
