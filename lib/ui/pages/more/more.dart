import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:selfprivacy/ui/molecules/list_items/more_menu_item.dart';
import 'package:selfprivacy/ui/organisms/headers/brand_header.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';

@RoutePage()
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isReady =
        context.watch<ServerInstallationCubit>().state
            is ServerInstallationFinished;

    return Scaffold(
      appBar:
          Breakpoints.small.isActive(context)
              ? BrandHeader(title: 'basis.more'.tr())
              : null,
      body: ListView(
        children: [
          Padding(
            padding: paddingH16V0,
            child: Column(
              children: [
                if (!isReady)
                  MoreMenuItem(
                    title: 'more_page.configuration_wizard'.tr(),
                    iconData: Icons.change_history_outlined,
                    goTo: () => const InitializingRoute(),
                    subtitle: 'not_ready_card.in_menu'.tr(),
                    accent: true,
                  ),
                if (isReady)
                  MoreMenuItem(
                    title: 'more_page.create_ssh_key'.tr(),
                    iconData: Icons.key_outlined,
                    goTo: () => UserDetailsRoute(login: 'root'),
                  ),
                if (isReady)
                  MoreMenuItem(
                    iconData: Icons.password_outlined,
                    goTo: () => const RecoveryKeyRoute(),
                    title: 'recovery_key.key_main_header'.tr(),
                  ),
                if (isReady)
                  MoreMenuItem(
                    iconData: Icons.devices_outlined,
                    goTo: () => const DevicesRoute(),
                    title: 'devices.main_screen.header'.tr(),
                  ),
                MoreMenuItem(
                  iconData: Icons.token_outlined,
                  title: 'tokens.title'.tr(),
                  goTo: () => const TokensRoute(),
                ),
                MoreMenuItem(
                  title: 'application_settings.title'.tr(),
                  iconData: Icons.settings_outlined,
                  goTo: () => const AppSettingsRoute(),
                ),
                MoreMenuItem(
                  title: 'about_application_page.title'.tr(),
                  iconData: Icons.info_outline,
                  goTo: () => const AboutApplicationRoute(),
                  longGoTo: const DeveloperSettingsRoute(),
                ),
                if (!isReady)
                  MoreMenuItem(
                    title: 'more_page.onboarding'.tr(),
                    iconData: Icons.play_circle_outlined,
                    goTo: () => const OnboardingRoute(),
                  ),
                MoreMenuItem(
                  title: 'console_page.title'.tr(),
                  iconData: BrandIcons.terminal,
                  goTo: () => const ConsoleRoute(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
