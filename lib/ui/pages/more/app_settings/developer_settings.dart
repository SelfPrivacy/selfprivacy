import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/ui/components/list_tiles/section_title.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/router/router.dart';

@RoutePage()
class DeveloperSettingsPage extends StatefulWidget {
  const DeveloperSettingsPage({super.key});

  @override
  State<DeveloperSettingsPage> createState() => _DeveloperSettingsPageState();
}

class _DeveloperSettingsPageState extends State<DeveloperSettingsPage> {
  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
        hasBackButton: true,
        hasFlashButton: false,
        bodyPadding: const EdgeInsets.symmetric(vertical: 16),
        heroTitle: 'developer_settings.title'.tr(),
        heroSubtitle: 'developer_settings.subtitle'.tr(),
        children: [
          SectionTitle(title: 'developer_settings.server_setup'.tr()),
          SwitchListTile(
            title: Text('developer_settings.use_staging_acme'.tr()),
            subtitle:
                Text('developer_settings.use_staging_acme_description'.tr()),
            value: TlsOptions.stagingAcme,
            onChanged: (final bool value) => setState(
              () => TlsOptions.stagingAcme = value,
            ),
          ),
          SwitchListTile(
            title: Text('developer_settings.ignore_tls'.tr()),
            subtitle: Text('developer_settings.ignore_tls_description'.tr()),
            value: TlsOptions.verifyCertificate,
            onChanged: (final bool value) => setState(
              () => TlsOptions.verifyCertificate = value,
            ),
          ),
          SwitchListTile(
            title: Text('developer_settings.allow_ssh_key_at_setup'.tr()),
            subtitle: Text(
              'developer_settings.allow_ssh_key_at_setup_description'.tr(),
            ),
            value: TlsOptions.allowCustomSshKeyDuringSetup,
            onChanged: (final bool value) => setState(
              () => TlsOptions.allowCustomSshKeyDuringSetup = value,
            ),
          ),
          SectionTitle(title: 'developer_settings.routing'.tr()),
          ListTile(
            title: Text('developer_settings.reset_onboarding'.tr()),
            subtitle:
                Text('developer_settings.reset_onboarding_description'.tr()),
            enabled:
                !context.watch<AppSettingsCubit>().state.isOnboardingShowing,
            onTap: () => context
                .read<AppSettingsCubit>()
                .turnOffOnboarding(isOnboardingShowing: true),
          ),
          ListTile(
            title: Text('storage.start_migration_button'.tr()),
            subtitle: Text('storage.data_migration_notice'.tr()),
            enabled:
                !context.watch<AppSettingsCubit>().state.isOnboardingShowing,
            onTap: () => context.pushRoute(
              ServicesMigrationRoute(
                diskStatus: context.read<VolumesBloc>().state.diskStatus,
                services: context
                    .read<ServicesBloc>()
                    .state
                    .services
                    .where(
                      (final service) =>
                          service.id == 'bitwarden' ||
                          service.id == 'gitea' ||
                          service.id == 'pleroma' ||
                          service.id == 'email' ||
                          service.id == 'nextcloud',
                    )
                    .toList(),
                isMigration: true,
              ),
            ),
          ),
          SectionTitle(title: 'developer_settings.cubit_statuses'.tr()),
          ListTile(
            title: const Text('ApiConnectionRepository status'),
            subtitle: Text(
              getIt<ApiConnectionRepository>()
                  .currentConnectionStatus
                  .toString(),
            ),
          ),
        ],
      );
}
