import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/outlined_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/server_storage/disk_status.dart';
import 'package:selfprivacy/ui/pages/server_storage/extending_volume.dart';
import 'package:selfprivacy/ui/pages/server_storage/server_storage_list_item.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class ServerStoragePage extends StatefulWidget {
  const ServerStoragePage({required this.diskStatus, final super.key});

  final DiskStatus diskStatus;

  @override
  State<ServerStoragePage> createState() => _ServerStoragePageState();
}

class _ServerStoragePageState extends State<ServerStoragePage> {
  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    if (!isReady) {
      return BrandHeroScreen(
        hasBackButton: true,
        heroTitle: 'providers.storage.card_title'.tr(),
        children: const [],
      );
    }

    return BrandHeroScreen(
      hasBackButton: true,
      heroTitle: 'providers.storage.card_title'.tr(),
      children: [
        // ...sections,
        ...widget.diskStatus.diskVolumes
            .map(
              (final volume) => Column(
                children: [
                  ServerStorageSection(
                    volume: volume,
                    diskStatus: widget.diskStatus,
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
    final super.key,
  });

  final DiskVolume volume;
  final DiskStatus diskStatus;

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          ServerStorageListItem(
            volume: volume,
          ),
          if (volume.isResizable) ...[
            const SizedBox(height: 16),
            BrandOutlinedButton(
              title: 'providers.storage.extend_volume_button.title'.tr(),
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
