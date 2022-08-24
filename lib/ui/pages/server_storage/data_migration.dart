import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/server_storage/disk_status.dart';
import 'package:selfprivacy/ui/pages/server_storage/server_storage_list_item.dart';

class DataMigrationPage extends StatefulWidget {
  const DataMigrationPage({
    required this.diskVolumeToResize,
    required this.diskStatus,
    required this.resizeTarget,
    final super.key,
  });

  final DiskVolume diskVolumeToResize;
  final DiskStatus diskStatus;
  final DiskSize resizeTarget;

  @override
  State<DataMigrationPage> createState() => _DataMigrationPageState();
}

class _DataMigrationPageState extends State<DataMigrationPage> {
  @override
  Widget build(final BuildContext context) {
    int a = 0;
    return BrandHeroScreen(
      hasBackButton: true,
      heroTitle: 'providers.storage.data_migration_title'.tr(),
      children: [
        ...widget.diskStatus.diskVolumes
            .map(
              (final volume) => Column(
                children: [
                  ServerStorageListItem(
                    volume: volume,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )
            .toList(),
      ],
    );
  }
}
