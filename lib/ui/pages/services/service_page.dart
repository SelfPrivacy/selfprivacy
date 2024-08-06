import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/components/cards/filled_card.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/launch_url.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

@RoutePage()
class ServicePage extends StatefulWidget {
  const ServicePage({required this.serviceId, super.key});

  final String serviceId;

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(final BuildContext context) {
    final Service? service =
        context.watch<ServicesBloc>().state.getServiceById(widget.serviceId);

    if (service == null) {
      return const BrandHeroScreen(
        hasBackButton: true,
        children: [
          Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ],
      );
    }

    final bool serviceDisabled = service.status == ServiceStatus.inactive ||
        service.status == ServiceStatus.off;

    final bool serviceLocked =
        context.watch<ServicesBloc>().state.isServiceLocked(service.id);

    final bool isRestartingEnabled = !serviceDisabled && !serviceLocked;
    final bool isMovingEnabled = !serviceDisabled &&
        !serviceLocked &&
        service.storageUsage.volume != null;

    final enabledTitleStyle = Theme.of(context).textTheme.titleMedium;
    final disabledTitleStyle = enabledTitleStyle?.copyWith(
      color: Theme.of(context).colorScheme.outline,
    );

    return BrandHeroScreen(
      hasBackButton: true,
      hasFlashButton: true,
      heroIconWidget: SvgPicture.string(
        service.svgIcon,
        width: 48.0,
        height: 48.0,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onBackground,
          BlendMode.srcIn,
        ),
      ),
      heroTitle: service.displayName,
      children: [
        ServiceStatusCard(status: service.status),
        const SizedBox(height: 16),
        if (service.url != null && !serviceDisabled)
          ListTile(
            iconColor: Theme.of(context).colorScheme.onBackground,
            onTap: () => launchURL(service.url),
            onLongPress: () {
              PlatformAdapter.setClipboard(service.url!);
              getIt<NavigationService>()
                  .showSnackBar('basis.copied_to_clipboard'.tr());
            },
            leading: const Icon(Icons.open_in_browser),
            title: Text(
              'service_page.open_in_browser'.tr(),
              style: enabledTitleStyle,
            ),
            subtitle: Text(
              service.url!.replaceAll('https://', ''),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
        ListTile(
          iconColor: Theme.of(context).colorScheme.onBackground,
          onTap: () =>
              context.read<ServicesBloc>().add(ServiceRestart(service)),
          leading: const Icon(Icons.restart_alt_outlined),
          title: Text(
            'service_page.restart'.tr(),
            style: isRestartingEnabled ? enabledTitleStyle : disabledTitleStyle,
          ),
          enabled: isRestartingEnabled,
        ),
        if (!service.isRequired)
          ListTile(
            iconColor: Theme.of(context).colorScheme.onBackground,
            onTap: () => context.read<JobsCubit>().addJob(
                  ServiceToggleJob(
                    service: service,
                    needToTurnOn: serviceDisabled,
                  ),
                ),
            leading: const Icon(Icons.power_settings_new),
            title: Text(
              serviceDisabled
                  ? 'service_page.enable'.tr()
                  : 'service_page.disable'.tr(),
              style: !serviceLocked ? enabledTitleStyle : disabledTitleStyle,
            ),
            enabled: !serviceLocked,
          ),
        if (service.configuration.isNotEmpty)
          ListTile(
            iconColor: Theme.of(context).colorScheme.onBackground,
            onTap: () => context.pushRoute(
              ServiceSettingsRoute(serviceId: service.id),
            ),
            leading: const Icon(Icons.settings_outlined),
            title: Text(
              'service_page.settings'.tr(),
              style: enabledTitleStyle,
            ),
          ),
        if (service.isMovable)
          ListTile(
            iconColor: Theme.of(context).colorScheme.onBackground,
            // Open page ServicesMigrationPage
            onTap: () => context.pushRoute(
              ServicesMigrationRoute(
                services: [service],
                diskStatus: context.read<VolumesBloc>().state.diskStatus,
                isMigration: false,
              ),
            ),
            leading: const Icon(Icons.drive_file_move_outlined),
            title: Text(
              'service_page.move'.tr(),
              style: isMovingEnabled ? enabledTitleStyle : disabledTitleStyle,
            ),
            subtitle: Text(
              'service_page.uses'.tr(
                namedArgs: {
                  'usage': service.storageUsage.used.toString(),
                  'volume': context
                      .read<VolumesBloc>()
                      .state
                      .getVolume(service.storageUsage.volume ?? '')
                      .displayName,
                },
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
            enabled: isMovingEnabled,
          ),
        if (service.canBeBackedUp)
          ListTile(
            iconColor: Theme.of(context).colorScheme.onBackground,
            // Open page ServicesMigrationPage
            onTap: () => context.pushRoute(
              BackupsListRoute(service: service),
            ),
            leading: const Icon(Icons.settings_backup_restore_outlined),
            title: Text(
              'service_page.snapshots'.tr(),
              style: enabledTitleStyle,
            ),
          ),
        ListTile(
          iconColor: Theme.of(context).colorScheme.onBackground,
          onTap: () => context.pushRoute(
            ServerLogsRoute(serviceId: service.id),
          ),
          leading: const Icon(Icons.manage_search_outlined),
          title: Text(
            'service_page.logs'.tr(),
            style: enabledTitleStyle,
          ),
        ),
      ],
    );
  }
}

class ServiceStatusCard extends StatelessWidget {
  const ServiceStatusCard({
    required this.status,
    super.key,
  });
  final ServiceStatus status;

  @override
  Widget build(final BuildContext context) {
    late IconData icon;
    late String buttonTitle;

    switch (status) {
      case ServiceStatus.active:
        icon = Icons.check_circle_outline;
        buttonTitle = 'service_page.status.active';
        break;

      case ServiceStatus.inactive:
        icon = Icons.stop_circle_outlined;
        buttonTitle = 'service_page.status.inactive';
        break;

      case ServiceStatus.failed:
        icon = Icons.error_outline;
        buttonTitle = 'service_page.status.failed';
        break;

      case ServiceStatus.off:
        icon = Icons.power_settings_new;
        buttonTitle = 'service_page.status.off';
        break;

      case ServiceStatus.activating:
        icon = Icons.restart_alt_outlined;
        buttonTitle = 'service_page.status.activating';
        break;

      case ServiceStatus.deactivating:
        icon = Icons.restart_alt_outlined;
        buttonTitle = 'service_page.status.deactivating';
        break;

      case ServiceStatus.reloading:
        icon = Icons.restart_alt_outlined;
        buttonTitle = 'service_page.status.reloading';
    }

    return FilledCard(
      tertiary: true,
      child: ListTile(
        leading: Icon(
          icon,
          size: 24,
        ),
        title: Text(buttonTitle.tr()),
      ),
    );
  }
}
