import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/pages/initializing/initializing.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

import 'about/about.dart';
import 'app_settings/app_setting.dart';
import 'console/console.dart';
import 'info/info.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(title: 'Еще'),
        preferredSize: Size.fromHeight(52),
      ),
      body: ListView(
        children: [
          Padding(
            padding: brandPagePadding2,
            child: Column(
              children: [
                BrandDivider(),
                _NavItem(
                  title: 'Мастер Подключения',
                  iconData: BrandIcons.settings,
                  goTo: InitializingPage(),
                ),
                _NavItem(
                  title: 'Настройки приложения',
                  iconData: BrandIcons.settings,
                  goTo: AppSettingsPage(),
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
                _NavItem(
                  title: 'Onboarding',
                  iconData: BrandIcons.triangle,
                  goTo: OnboardingPage(nextPage: RootPage()),
                ),
                _NavItem(
                  title: 'Console',
                  iconData: BrandIcons.triangle,
                  goTo: Console(),
                ),
              ],
            ),
          )
        ],
      ),
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
            BrandText.body1(title),
            Spacer(),
            SizedBox(
              width: 56,
              child: Icon(
                iconData,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
