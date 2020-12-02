import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/pages/about/about.dart';
import 'package:selfprivacy/ui/pages/info/info.dart';
import 'package:selfprivacy/ui/pages/settings/setting.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BrandHeader(title: 'Еще'),
        Padding(
          padding: brandPagePadding2,
          child: Column(
            children: [
              BrandDivider(),
              _NavItem(
                title: 'Настройки',
                iconData: BrandIcons.settings,
                goTo: SettingsPage(),
              ),
              _NavItem(
                title: 'О проекте Selfprivacy',
                iconData: BrandIcons.triangle,
                goTo: AboutPage(),
              ),
              _NavItem(
                title: 'О приложении',
                iconData: BrandIcons.help,
                goTo: InfoPage(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    Key key,
    @required this.iconData,
    @required this.goTo,
    @required this.title,
  }) : super(key: key);

  final IconData iconData;
  final Widget goTo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(materialRoute(goTo)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: BrandColors.dividerColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(title).body1,
            Spacer(),
            Icon(iconData, size: 20),
            SizedBox(width: 18),
          ],
        ),
      ),
    );
  }
}
