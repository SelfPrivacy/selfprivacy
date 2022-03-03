import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/pages/initializing/initializing.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';
import 'package:selfprivacy/ui/pages/ssh_keys/ssh_keys.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

import '../../../logic/cubit/users/users_cubit.dart';
import 'about/about.dart';
import 'app_settings/app_setting.dart';
import 'console/console.dart';
import 'info/info.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var jobsCubit = context.watch<JobsCubit>();
    var isReady = context.watch<AppConfigCubit>().state is AppConfigFinished;

    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(
          title: 'basis.more'.tr(),
          hasFlashButton: true,
        ),
        preferredSize: Size.fromHeight(52),
      ),
      body: ListView(
        children: [
          Padding(
            padding: paddingH15V0,
            child: Column(
              children: [
                BrandDivider(),
                _NavItem(
                  title: 'more.configuration_wizard'.tr(),
                  iconData: BrandIcons.triangle,
                  goTo: InitializingPage(),
                ),
                _NavItem(
                  title: 'more.settings.title'.tr(),
                  iconData: BrandIcons.settings,
                  goTo: AppSettingsPage(),
                ),
                _NavItem(
                  title: 'more.about_project'.tr(),
                  iconData: BrandIcons.engineer,
                  goTo: AboutPage(),
                ),
                _NavItem(
                  title: 'more.about_app'.tr(),
                  iconData: BrandIcons.fire,
                  goTo: InfoPage(),
                ),
                _NavItem(
                  title: 'more.onboarding'.tr(),
                  iconData: BrandIcons.start,
                  goTo: OnboardingPage(nextPage: RootPage()),
                ),
                _NavItem(
                  title: 'more.console'.tr(),
                  iconData: BrandIcons.terminal,
                  goTo: Console(),
                ),
                _NavItem(
                    title: 'more.create_ssh_key'.tr(),
                    iconData: Ionicons.key_outline,
                    goTo: SshKeysPage(
                      user: context.read<UsersCubit>().state.rootUser,
                    )),
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
    Key? key,
    required this.iconData,
    required this.goTo,
    required this.title,
  }) : super(key: key);

  final IconData iconData;
  final Widget goTo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(materialRoute(goTo)),
      child: _MoreMenuItem(
        iconData: iconData,
        title: title,
        isActive: true,
      ),
    );
  }
}

class _MoreMenuTapItem extends StatelessWidget {
  const _MoreMenuTapItem({
    Key? key,
    required this.iconData,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _MoreMenuItem(
        isActive: onTap != null,
        iconData: iconData,
        title: title,
      ),
    );
  }
}

class _MoreMenuItem extends StatelessWidget {
  const _MoreMenuItem({
    Key? key,
    required this.iconData,
    required this.title,
    required this.isActive,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          BrandText.body1(
            title,
            style: TextStyle(
              color: isActive ? null : Colors.grey,
            ),
          ),
          Spacer(),
          SizedBox(
            width: 56,
            child: Icon(
              iconData,
              size: 20,
              color: isActive ? null : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
