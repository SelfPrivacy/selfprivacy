import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/components/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/components/storage_list_items/server_storage_list_item.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';

@RoutePage()
class ServerStoragePage extends StatefulWidget {
  const ServerStoragePage({
    required this.diskStatus,
    super.key,
  });

  final DiskStatus diskStatus;

  @override
  State<ServerStoragePage> createState() => _ServerStoragePageState();
}

class _ServerStoragePageState extends State<ServerStoragePage> {
  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    final List<Service> services = context.watch<ServicesBloc>().state.services;

    if (!isReady) {
      return BrandHeroScreen(
        hasBackButton: true,
        heroTitle: 'storage.card_title'.tr(),
        children: const [],
      );
    }

    return BrandHeroScreen(
      hasBackButton: true,
      heroTitle: 'storage.card_title'.tr(),
      bodyPadding: const EdgeInsets.symmetric(vertical: 16.0),
      hasFlashButton: true,
      children: [
        ...widget.diskStatus.diskVolumes.map(
          (final volume) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ServerStorageSection(
                volume: volume,
                diskStatus: widget.diskStatus,
                services: services
                    .where(
                      (final service) =>
                          service.storageUsage.volume == volume.name,
                    )
                    .toList(),
              ),
              const Gap(16),
              const Divider(),
              const Gap(16),
            ],
          ),
        ),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BrandOutlinedButton(
            title: 'jobs.collect_nix_garbage'.tr(),
            onPressed: () {
              context.read<JobsCubit>().collectNixGarbage();
              showModalJobsSheet(context: context);
            },
          ),
        ),
      ],
    );
  }
}

class ServerStorageSection extends StatelessWidget {
  const ServerStorageSection({
    required this.volume,
    required this.diskStatus,
    required this.services,
    super.key,
  });

  final DiskVolume volume;
  final DiskStatus diskStatus;
  final List<Service> services;

  @override
  Widget build(final BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ServerStorageListItem(
              volume: volume,
            ),
          ),
          const Gap(16),
          ...services.map(
            (final service) => ServerConsumptionListTile(
              service: service,
              volume: volume,
              onTap: () {
                context.pushRoute(
                  ServiceRoute(serviceId: service.id),
                );
              },
            ),
          ),
          if (volume.isResizable) ...[
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BrandOutlinedButton(
                title: 'storage.extend_volume_button.title'.tr(),
                onPressed: () => context.pushRoute(
                  ExtendingVolumeRoute(
                    diskVolumeToResize: volume,
                    diskStatus: diskStatus,
                  ),
                ),
              ),
            ),
          ],
        ],
      );
}

class ServerConsumptionListTile extends StatelessWidget {
  const ServerConsumptionListTile({
    required this.service,
    required this.volume,
    required this.onTap,
    super.key,
  });

  final Service service;
  final DiskVolume volume;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ConsumptionListItem(
            title: service.displayName,
            icon: SvgPicture.string(
              service.svgIcon,
              width: 22.0,
              height: 24.0,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onBackground,
                BlendMode.srcIn,
              ),
            ),
            rightSideText: service.storageUsage.used.toString(),
            percentage: service.storageUsage.used.byte / volume.sizeTotal.byte,
            color: volume.root
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            dense: true,
          ),
        ),
      );
}
