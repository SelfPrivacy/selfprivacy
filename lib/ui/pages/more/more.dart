import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/cards/filled_card.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';

@RoutePage()
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    return Scaffold(
      appBar: Breakpoints.small.isActive(context)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(52),
              child: BrandHeader(
                title: 'basis.more'.tr(),
              ),
            )
          : null,
      body: ListView(
        children: [
          Padding(
            padding: paddingH15V0,
            child: Column(
              children: [
                if (!isReady)
                  _MoreMenuItem(
                    title: 'more_page.configuration_wizard'.tr(),
                    iconData: Icons.change_history_outlined,
                    goTo: () => const InitializingRoute(),
                    subtitle: 'not_ready_card.in_menu'.tr(),
                    accent: true,
                  ),
                if (isReady)
                  _MoreMenuItem(
                    title: 'more_page.create_ssh_key'.tr(),
                    iconData: Ionicons.key_outline,
                    goTo: () => UserDetailsRoute(
                      login: 'root',
                    ),
                  ),
                if (isReady)
                  _MoreMenuItem(
                    iconData: Icons.password_outlined,
                    goTo: () => const RecoveryKeyRoute(),
                    title: 'recovery_key.key_main_header'.tr(),
                  ),
                if (isReady)
                  _MoreMenuItem(
                    iconData: Icons.devices_outlined,
                    goTo: () => const DevicesRoute(),
                    title: 'devices.main_screen.header'.tr(),
                  ),
                _MoreMenuItem(
                  title: 'more_page.application_settings'.tr(),
                  iconData: Icons.settings_outlined,
                  goTo: () => const AppSettingsRoute(),
                ),
                _MoreMenuItem(
                  title: 'more_page.about_application'.tr(),
                  iconData: BrandIcons.fire,
                  goTo: () => const AboutApplicationRoute(),
                  longGoTo: const DeveloperSettingsRoute(),
                ),
                if (!isReady)
                  _MoreMenuItem(
                    title: 'more_page.onboarding'.tr(),
                    iconData: BrandIcons.start,
                    goTo: () => const OnboardingRoute(),
                  ),
                _MoreMenuItem(
                  title: 'more_page.console'.tr(),
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

class _MoreMenuItem extends StatelessWidget {
  const _MoreMenuItem({
    required this.iconData,
    required this.title,
    required this.goTo,
    this.subtitle,
    this.longGoTo,
    this.accent = false,
  });

  final IconData iconData;
  final String title;
  final PageRouteInfo Function() goTo;
  final PageRouteInfo? longGoTo;
  final String? subtitle;
  final bool accent;

  @override
  Widget build(final BuildContext context) {
    final Color color = accent
        ? Theme.of(context).colorScheme.onTertiaryContainer
        : Theme.of(context).colorScheme.onSurface;
    return FilledCard(
      tertiary: accent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () => context.pushRoute(goTo()),
        onLongPress:
            longGoTo != null ? () => context.pushRoute(longGoTo!) : null,
        leading: Icon(
          iconData,
          size: 24,
          color: color,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
              ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: color,
                    ),
              )
            : null,
      ),
    );
  }
}
