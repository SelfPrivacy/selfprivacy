import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/components/cards/filled_card.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/launch_url.dart';

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
            child: CircularProgressIndicator(),
          ),
        ],
      );
    }

    final bool serviceDisabled = service.status == ServiceStatus.inactive ||
        service.status == ServiceStatus.off;

    final bool serviceLocked =
        context.watch<ServicesBloc>().state.isServiceLocked(service.id);

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
        if (service.url != null)
          ListTile(
            iconColor: Theme.of(context).colorScheme.onBackground,
            onTap: () => launchURL(service.url),
            leading: const Icon(Icons.open_in_browser),
            title: Text(
              'service_page.open_in_browser'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          enabled: !serviceDisabled && !serviceLocked,
        ),
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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          enabled: !serviceLocked,
        ),
        if (service.isMovable)
          ListTile(
            iconColor: Theme.of(context).colorScheme.onBackground,
            // Open page ServicesMigrationPage
            onTap: () => context.pushRoute(
              ServicesMigrationRoute(
                services: [service],
                diskStatus: context.read<VolumesBloc>().state.diskStatus,
              ),
            ),
            leading: const Icon(Icons.drive_file_move_outlined),
            title: Text(
              'service_page.move'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
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
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            enabled: !serviceDisabled &&
                !serviceLocked &&
                service.storageUsage.volume != null,
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
              style: Theme.of(context).textTheme.titleMedium,
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
    switch (status) {
      case ServiceStatus.active:
        return FilledCard(
          child: ListTile(
            leading: const Icon(
              Icons.check_circle_outline,
              size: 24,
            ),
            title: Text('service_page.status.active'.tr()),
          ),
        );
      case ServiceStatus.inactive:
        return FilledCard(
          tertiary: true,
          child: ListTile(
            leading: const Icon(
              Icons.stop_circle_outlined,
              size: 24,
            ),
            title: Text('service_page.status.inactive'.tr()),
          ),
        );
      case ServiceStatus.failed:
        return FilledCard(
          error: true,
          child: ListTile(
            leading: const Icon(
              Icons.error_outline,
              size: 24,
            ),
            title: Text('service_page.status.failed'.tr()),
          ),
        );
      case ServiceStatus.off:
        return FilledCard(
          tertiary: true,
          child: ListTile(
            leading: const Icon(
              Icons.power_settings_new,
              size: 24,
            ),
            title: Text('service_page.status.off'.tr()),
          ),
        );
      case ServiceStatus.activating:
        return FilledCard(
          tertiary: true,
          child: ListTile(
            leading: const Icon(
              Icons.restart_alt_outlined,
              size: 24,
            ),
            title: Text('service_page.status.activating'.tr()),
          ),
        );
      case ServiceStatus.deactivating:
        return FilledCard(
          tertiary: true,
          child: ListTile(
            leading: const Icon(
              Icons.restart_alt_outlined,
              size: 24,
            ),
            title: Text('service_page.status.deactivating'.tr()),
          ),
        );
      case ServiceStatus.reloading:
        return FilledCard(
          tertiary: true,
          child: ListTile(
            leading: const Icon(
              Icons.restart_alt_outlined,
              size: 24,
            ),
            title: Text('service_page.status.reloading'.tr()),
          ),
        );
    }
  }
}
