import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/app_controller/inherited_app_controller.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_title.dart';
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
    heroTitle: 'developer_settings.title'.tr(),
    heroSubtitle: 'developer_settings.subtitle'.tr(),
    heroIcon: Icons.developer_mode_outlined,
    children: [
      SectionTitle(title: 'developer_settings.server_setup'.tr()),
      SwitchListTile.adaptive(
        title: Text('developer_settings.use_staging_acme'.tr()),
        subtitle: Text('developer_settings.use_staging_acme_description'.tr()),
        value: TlsOptions.stagingAcme,
        onChanged:
            (final bool value) =>
                setState(() => TlsOptions.stagingAcme = value),
      ),
      SwitchListTile.adaptive(
        title: Text('developer_settings.ignore_tls'.tr()),
        subtitle: Text('developer_settings.ignore_tls_description'.tr()),
        value: !TlsOptions.verifyCertificate,
        onChanged:
            (final bool value) =>
                setState(() => TlsOptions.verifyCertificate = !value),
      ),
      SwitchListTile.adaptive(
        title: Text('developer_settings.allow_ssh_key_at_setup'.tr()),
        subtitle: Text(
          'developer_settings.allow_ssh_key_at_setup_description'.tr(),
        ),
        value: TlsOptions.allowCustomSshKeyDuringSetup,
        onChanged:
            (final bool value) =>
                setState(() => TlsOptions.allowCustomSshKeyDuringSetup = value),
      ),
      SectionTitle(title: 'troubleshooting.title'.tr()),
      ListTile(
        title: Text('troubleshooting.configuration_switch_logs'.tr()),
        subtitle: Text(
          'troubleshooting.configuration_switch_logs_description'.tr(),
        ),
        enabled: !InheritedAppController.of(context).shouldShowOnboarding,
        onTap:
            () => context.pushRoute(
              ServerLogsRoute(
                unitId: 'nixos-rebuild-switch-to-configuration.service',
              ),
            ),
      ),
      SectionTitle(title: 'developer_settings.routing'.tr()),
      ListTile(
        title: Text('developer_settings.reset_onboarding'.tr()),
        subtitle: Text('developer_settings.reset_onboarding_description'.tr()),
        enabled: !InheritedAppController.of(context).shouldShowOnboarding,
        onTap:
            () => InheritedAppController.of(
              context,
            ).setShouldShowOnboarding(shouldOnboard: true),
      ),
      ListTile(
        title: Text('storage.start_migration_button'.tr()),
        subtitle: Text('storage.data_migration_notice'.tr()),
        onTap:
            () => context.pushRoute(
              ServicesMigrationRoute(
                diskStatus: context.read<VolumesBloc>().state.diskStatus,
                services:
                    context
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
          getIt<ApiConnectionRepository>().currentConnectionStatus.toString(),
        ),
      ),
      SectionTitle(title: 'developer_settings.servers'.tr()),
      ...getIt<ResourcesModel>().servers.map(
        (final server) => ListTile(
          title: Text(server.domain.domainName),
          subtitle: Text('developer_settings.tap_for_more_info'.tr()),
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              builder:
                  (final BuildContext context) => DraggableScrollableSheet(
                    expand: false,
                    maxChildSize: 0.9,
                    minChildSize: 0.4,
                    initialChildSize: 0.6,
                    builder:
                        (final context, final scrollController) => ListView(
                          controller: scrollController,
                          children: [
                            ListTile(
                              title: Text('server.server_id'.tr()),
                              subtitle: Text(
                                server.hostingDetails.id.toString(),
                              ),
                            ),
                            ListTile(
                              title: Text('server.location'.tr()),
                              subtitle: Text(
                                server.hostingDetails.serverLocation ??
                                    'developer_settings.unknown'.tr(),
                              ),
                            ),
                            ListTile(
                              title: Text('server.server_provider'.tr()),
                              subtitle: Text(
                                server.hostingDetails.provider.displayName,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'developer_settings.server_type'.tr(),
                              ),
                              subtitle: Text(
                                server.hostingDetails.serverType ??
                                    'developer_settings.unknown'.tr(),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'developer_settings.server_volume_name'.tr(),
                              ),
                              subtitle: Text(server.hostingDetails.volume.name),
                            ),
                            ListTile(
                              title: Text(
                                'developer_settings.server_volume_size'.tr(),
                              ),
                              subtitle: Text(
                                server.hostingDetails.volume.sizeByte
                                    .toString(),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'developer_settings.server_volume_location'
                                    .tr(),
                              ),
                              subtitle: Text(
                                server.hostingDetails.volume.location ??
                                    'developer_settings.unknown'.tr(),
                              ),
                            ),
                            ListTile(
                              title: Text('developer_settings.server_ip'.tr()),
                              subtitle: Text(server.hostingDetails.ip4),
                            ),
                            ListTile(
                              title: Text(
                                'developer_settings.server_domain'.tr(),
                              ),
                              subtitle: Text(server.domain.domainName),
                            ),
                            ListTile(
                              title: Text('server.dns_provider'.tr()),
                              subtitle: Text(
                                server.domain.provider.displayName,
                              ),
                            ),
                          ],
                        ),
                  ),
            );
          },
        ),
      ),
    ],
  );
}
