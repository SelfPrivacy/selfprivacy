import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/pages/recovery_key/recovery_key.dart';
import 'package:selfprivacy/ui/pages/setup/initializing.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: BrandHeader(
          title: 'basis.more'.tr(),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: paddingH15V0,
            child: Column(
              children: [
                const BrandDivider(),
                _NavItem(
                  title: 'more.configuration_wizard'.tr(),
                  iconData: BrandIcons.triangle,
                  goTo: const InitializingPage(),
                ),
                _NavItem(
                  title: 'more.settings.title'.tr(),
                  iconData: BrandIcons.settings,
                  goTo: const AppSettingsPage(),
                ),
                _NavItem(
                  title: 'more.about_project'.tr(),
                  iconData: BrandIcons.engineer,
                  goTo: const AboutPage(),
                ),
                _NavItem(
                  title: 'more.about_app'.tr(),
                  iconData: BrandIcons.fire,
                  goTo: const InfoPage(),
                ),
                _NavItem(
                  title: 'more.onboarding'.tr(),
                  iconData: BrandIcons.start,
                  goTo: const OnboardingPage(nextPage: RootPage()),
                ),
                _NavItem(
                  title: 'more.console'.tr(),
                  iconData: BrandIcons.terminal,
                  goTo: const Console(),
                ),
                _NavItem(
                    isEnabled: context.read<ServerInstallationCubit>().state
                        is ServerInstallationFinished,
                    title: 'more.create_ssh_key'.tr(),
                    iconData: Ionicons.key_outline,
                    goTo: SshKeysPage(
                      user: context.read<UsersCubit>().state.rootUser,
                    )),
                _NavItem(
                  isEnabled: context.read<ServerInstallationCubit>().state
                      is ServerInstallationFinished,
                  iconData: Icons.password_outlined,
                  goTo: const RecoveryKey(),
                  title: 'recovery_key.key_main_header'.tr(),
                )
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
    this.isEnabled = true,
    required this.iconData,
    required this.goTo,
    required this.title,
  }) : super(key: key);

  final IconData iconData;
  final Widget goTo;
  final String title;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled
          ? () => Navigator.of(context).push(materialRoute(goTo))
          : null,
      child: _MoreMenuItem(
        iconData: iconData,
        title: title,
        isActive: isEnabled,
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
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: const BoxDecoration(
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
          const Spacer(),
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
