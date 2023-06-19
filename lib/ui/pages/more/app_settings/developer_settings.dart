import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/cubit/devices/devices_cubit.dart';
import 'package:selfprivacy/logic/cubit/recovery_key/recovery_key_cubit.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:easy_localization/easy_localization.dart';

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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'developer_settings.server_setup'.tr(),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
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
            subtitle:
            Text('developer_settings.ignore_tls_description'.tr()),
            value: TlsOptions.verifyCertificate,
            onChanged: (final bool value) => setState(
                  () => TlsOptions.verifyCertificate = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'developer_settings.routing'.tr(),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'developer_settings.cubit_statuses'.tr(),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          ListTile(
            title: const Text('ApiDevicesCubit'),
            subtitle: Text(
              context.watch<ApiDevicesCubit>().state.status.toString(),
            ),
          ),
          ListTile(
            title: const Text('RecoveryKeyCubit'),
            subtitle: Text(
              context.watch<RecoveryKeyCubit>().state.loadingStatus.toString(),
            ),
          ),
        ],
      );
}
