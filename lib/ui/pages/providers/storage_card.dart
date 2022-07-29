import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_linear_indicator/brand_linear_indicator.dart';
import 'package:selfprivacy/ui/components/icon_status_mask/icon_status_mask.dart';

class DiskVolume {
  int gbUsed = 0;
  int gbTotal = 0;
  String name = '';
  bool root = false;

  /// from 0.0 to 1.0
  double percentage = 0.0;
}

class DiskStatus {
  bool isDiskOkay = false;
  List<DiskVolume> diskVolumes = [];
}

class StorageCard extends StatelessWidget {
  const StorageCard({required this.volumes, final super.key});

  final List<ServerDiskVolume> volumes;

  @override
  Widget build(
    final BuildContext context,
  ) {
    final DiskStatus diskStatus = toDiskStatus(volumes);

    final List<Widget> sections = [];
    for (final DiskVolume volume in diskStatus.diskVolumes) {
      sections.add(
        const SizedBox(height: 16),
      );
      sections.add(
        Text(
          'providers.storage.disk_usage'.tr(args: [volume.gbUsed.toString()]),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
      sections.add(
        const SizedBox(height: 4),
      );
      sections.add(
        BrandLinearIndicator(
          value: volume.percentage,
          color: volume.root
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          height: 14.0,
        ),
      );
      sections.add(
        const SizedBox(height: 4),
      );
      sections.add(
        Text(
          'providers.storage.disk_total'.tr(args: [
            volume.gbTotal.toString(),
            volume.name,
          ]),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }

    return GestureDetector(
      onTap: null,
      child: BrandCards.big(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const IconStatusMask(
                  status: StateType.stable,
                  child: Icon(
                    Icons.storage_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                IconStatusMask(
                  status: StateType.stable,
                  child: Icon(
                    diskStatus.isDiskOkay
                        ? Icons.check_circle_outline
                        : Icons.error_outline,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'providers.storage.card_title'.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              diskStatus.isDiskOkay
                  ? 'providers.storage.status_ok'.tr()
                  : 'providers.storage.status_error'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            ...sections,
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  DiskStatus toDiskStatus(final List<ServerDiskVolume> status) {
    final DiskStatus diskStatus = DiskStatus();
    diskStatus.isDiskOkay = true;

    diskStatus.diskVolumes = status.map((
      final ServerDiskVolume volume,
    ) {
      final DiskVolume diskVolume = DiskVolume();
      diskVolume.gbUsed = volume.usedSpace == 'None'
          ? 0
          : int.parse(volume.usedSpace) ~/ 1000000000;
      diskVolume.gbTotal = volume.totalSpace == 'None'
          ? 0
          : int.parse(volume.totalSpace) ~/ 1000000000;
      diskVolume.name = volume.name;
      diskVolume.root = volume.root;
      diskVolume.percentage =
          volume.usedSpace != 'None' && volume.totalSpace != 'None'
              ? 1.0 / int.parse(volume.totalSpace) * int.parse(volume.usedSpace)
              : 0.0;
      if (diskVolume.percentage >= 0.8 ||
          diskVolume.gbTotal - diskVolume.gbUsed <= 2) {
        diskStatus.isDiskOkay = false;
      }
      return diskVolume;
    }).toList();

    return diskStatus;
  }
}
