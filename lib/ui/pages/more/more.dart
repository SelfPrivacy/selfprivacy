import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_volumes/server_volume_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/ui/components/brand_cards/filled_card.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/pages/devices/devices.dart';
import 'package:selfprivacy/ui/pages/recovery_key/recovery_key.dart';
import 'package:selfprivacy/ui/pages/server_storage/binds_migration/services_migration.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/initializing.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/ui/pages/users/users.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

import 'package:selfprivacy/ui/pages/more/about_us.dart';
import 'package:selfprivacy/ui/pages/more/app_settings/app_setting.dart';
import 'package:selfprivacy/ui/pages/more/console.dart';
import 'package:selfprivacy/ui/pages/more/about_application.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    final bool? usesBinds =
        context.watch<ApiServerVolumeCubit>().state.usesBinds;

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
                if (isReady && usesBinds != null && !usesBinds)
                  _MoreMenuItem(
                    title: 'storage.start_migration_button'.tr(),
                    iconData: Icons.drive_file_move_outline,
                    goTo: ServicesMigrationPage(
                      diskStatus: context
                          .watch<ApiServerVolumeCubit>()
                          .state
                          .diskStatus,
                      services: context
                          .read<ServicesCubit>()
                          .state
                          .services
                          .where(
                            (final service) =>
                                service.id == 'bitwarden' ||
                                service.id == 'gitea' ||
                                service.id == 'pleroma' ||
                                service.id == 'mailserver' ||
                                service.id == 'nextcloud',
                          )
                          .toList(),
                      isMigration: true,
                    ),
                    subtitle: 'storage.data_migration_notice'.tr(),
                    accent: true,
                  ),
                if (!isReady)
                  _MoreMenuItem(
                    title: 'more_page.configuration_wizard'.tr(),
                    iconData: Icons.change_history_outlined,
                    goTo: const InitializingPage(),
                    subtitle: 'not_ready_card.in_menu'.tr(),
                    accent: true,
                  ),
                if (isReady)
                  _MoreMenuItem(
                    title: 'more_page.create_ssh_key'.tr(),
                    iconData: Ionicons.key_outline,
                    goTo: const UserDetails(
                      login: 'root',
                    ),
                  ),
                if (isReady)
                  _MoreMenuItem(
                    iconData: Icons.password_outlined,
                    goTo: const RecoveryKey(),
                    title: 'recovery_key.key_main_header'.tr(),
                  ),
                if (isReady)
                  _MoreMenuItem(
                    iconData: Icons.devices_outlined,
                    goTo: const DevicesScreen(),
                    title: 'devices.main_screen.header'.tr(),
                  ),
                _MoreMenuItem(
                  title: 'more_page.application_settings'.tr(),
                  iconData: Icons.settings_outlined,
                  goTo: const AppSettingsPage(),
                ),
                _MoreMenuItem(
                  title: 'more_page.about_project'.tr(),
                  iconData: BrandIcons.engineer,
                  goTo: const AboutUsPage(),
                ),
                _MoreMenuItem(
                  title: 'more_page.about_application'.tr(),
                  iconData: BrandIcons.fire,
                  goTo: const AboutApplicationPage(),
                ),
                if (!isReady)
                  _MoreMenuItem(
                    title: 'more_page.onboarding'.tr(),
                    iconData: BrandIcons.start,
                    goTo: const OnboardingPage(nextPage: RootPage()),
                  ),
                _MoreMenuItem(
                  title: 'more_page.console'.tr(),
                  iconData: BrandIcons.terminal,
                  goTo: const Console(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _MoreMenuItem extends StatelessWidget {
  const _MoreMenuItem({
    required this.iconData,
    required this.title,
    this.subtitle,
    this.goTo,
    this.accent = false,
  });

  final IconData iconData;
  final String title;
  final Widget? goTo;
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
        onTap: goTo != null
            ? () => Navigator.of(context).push(materialRoute(goTo!))
            : null,
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
