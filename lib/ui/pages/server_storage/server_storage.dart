import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/components/brand_button/outlined_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/ui/pages/server_storage/extending_volume.dart';
import 'package:selfprivacy/ui/components/storage_list_items/server_storage_list_item.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

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

    final List<Service> services =
        context.watch<ServicesCubit>().state.services;

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
      children: [
        // ...sections,
        ...widget.diskStatus.diskVolumes
            .map(
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
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                ],
              ),
            )
            .toList(),
        const SizedBox(height: 8),
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
          ServerStorageListItem(
            volume: volume,
          ),
          const SizedBox(height: 16),
          ...services
              .map(
                (final service) => ServerConsumptionListTile(
                  service: service,
                  volume: volume,
                ),
              )
              .toList(),
          if (volume.isResizable) ...[
            const SizedBox(height: 16),
            BrandOutlinedButton(
              title: 'storage.extend_volume_button.title'.tr(),
              onPressed: () => Navigator.of(context).push(
                materialRoute(
                  ExtendingVolumePage(
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
    super.key,
  });

  final Service service;
  final DiskVolume volume;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ConsumptionListItem(
          title: service.displayName,
          icon: SvgPicture.string(
            service.svgIcon,
            width: 24.0,
            height: 24.0,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          rightSideText: service.storageUsage.used.toString(),
          percentage: service.storageUsage.used.byte / volume.sizeTotal.byte,
          color: volume.root
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          dense: true,
        ),
      );
}
