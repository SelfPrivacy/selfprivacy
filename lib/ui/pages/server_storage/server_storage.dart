import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/atoms/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/organisms/storage_list_items/server_storage_list_item.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';

@RoutePage()
class ServerStoragePage extends StatefulWidget {
  const ServerStoragePage({super.key});

  @override
  State<ServerStoragePage> createState() => _ServerStoragePageState();
}

class _ServerStoragePageState extends State<ServerStoragePage> {
  @override
  Widget build(final BuildContext context) {
    final bool isReady =
        context.watch<ServerInstallationCubit>().state
            is ServerInstallationFinished;

    final DiskStatus diskStatus = context.watch<VolumesBloc>().state.diskStatus;

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
      bodyPadding: const EdgeInsets.symmetric(vertical: 16),
      hasFlashButton: true,
      children: [
        ...diskStatus.diskVolumes.map(
          (final volume) =>
              DiskConsumptionOverview(volume: volume, diskStatus: diskStatus),
        ),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BrandOutlinedButton(
            title: 'jobs.collect_nix_garbage'.tr(),
            onPressed: () async {
              unawaited(context.read<JobsCubit>().collectNixGarbage());
              await showModalJobsSheet(context: context);
            },
          ),
        ),
      ],
    );
  }
}

class DiskConsumptionOverview extends StatelessWidget {
  const DiskConsumptionOverview({
    required this.volume,
    required this.diskStatus,
    super.key,
  });

  final DiskVolume volume;
  final DiskStatus diskStatus;

  @override
  Widget build(final BuildContext context) {
    final List<Service> services = context.watch<ServicesBloc>().state.services;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ServerStorageSection(
          volume: volume,
          diskStatus: diskStatus,
          services:
              services
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ServerStorageListItem(volume: volume),
      ),
      const Gap(16),
      ...services.map(
        (final service) => ServerConsumptionListTile(
          service: service,
          volume: volume,
          onTap: () async {
            await context.pushRoute(ServiceRoute(serviceId: service.id));
          },
        ),
      ),
      if (volume.isResizable) ...[
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BrandOutlinedButton(
            title: 'storage.extend_volume_button.title'.tr(),
            onPressed:
                () => context.pushRoute(
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ConsumptionListItem(
        title: service.displayName,
        icon: SvgPicture.string(
          service.svgIcon,
          width: 22,
          height: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
        rightSideText: service.storageUsage.used.toString(),
        percentage: service.storageUsage.used.byte / volume.sizeTotal.byte,
        color:
            volume.root
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        dense: true,
      ),
    ),
  );
}
