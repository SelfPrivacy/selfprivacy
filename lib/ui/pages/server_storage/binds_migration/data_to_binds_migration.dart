import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_jobs/server_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/info_box/info_box.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/ui/components/storage_list_items/server_storage_list_item.dart';
import 'package:selfprivacy/ui/components/storage_list_items/service_migration_list_item.dart';
import 'package:selfprivacy/ui/pages/server_storage/binds_migration/migration_process_page.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class DataToBindsMigrationPage extends StatefulWidget {
  const DataToBindsMigrationPage({
    required this.services,
    required this.diskStatus,
    final super.key,
  });

  final DiskStatus diskStatus;
  final List<Service> services;

  @override
  State<DataToBindsMigrationPage> createState() =>
      _DataToBindsMigrationPageState();
}

class _DataToBindsMigrationPageState extends State<DataToBindsMigrationPage> {
  /// Service id to target migration disk name
  final Map<String, String> serviceToDisk = {};

  static const headerHeight = 52.0;
  static const headerVerticalPadding = 8.0;
  static const listItemHeight = 62.0;

  @override
  void initState() {
    super.initState();

    for (final Service service in widget.services) {
      if (service.storageUsage.volume != null) {
        serviceToDisk[service.id] = service.storageUsage.volume!;
      }
    }
  }

  void onChange(final String volumeName, final String serviceId) {
    setState(() {
      serviceToDisk[serviceId] = volumeName;
    });
  }

  /// Check the services and if a service is moved (in a serviceToDisk entry)
  /// subtract the used storage from the old volume and add it to the new volume.
  /// The old volume is the volume the service is currently on, shown in services list.
  DiskVolume recalculatedDiskUsages(
    final DiskVolume volume,
    final List<Service> services,
  ) {
    DiskSize used = volume.sizeUsed;

    for (final Service service in services) {
      if (service.storageUsage.volume != null) {
        if (service.storageUsage.volume == volume.name) {
          if (serviceToDisk[service.id] != null &&
              serviceToDisk[service.id] != volume.name) {
            used -= service.storageUsage.used;
          }
        } else {
          if (serviceToDisk[service.id] != null &&
              serviceToDisk[service.id] == volume.name) {
            used += service.storageUsage.used;
          }
        }
      }
    }

    return volume.copyWith(sizeUsed: used);
  }

  @override
  Widget build(final BuildContext context) {
    final Size appBarHeight = Size.fromHeight(
      headerHeight +
          headerVerticalPadding * 2 +
          listItemHeight * widget.diskStatus.diskVolumes.length +
          headerVerticalPadding * widget.diskStatus.diskVolumes.length,
    );
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: appBarHeight,
          child: Column(
            children: [
              BrandHeader(
                title: 'providers.storage.data_migration_title'.tr(),
                hasBackButton: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: headerVerticalPadding,
                ),
                child: Column(
                  children: [
                    ...widget.diskStatus.diskVolumes
                        .map(
                          (final volume) => Column(
                            children: [
                              ServerStorageListItem(
                                volume: recalculatedDiskUsages(
                                  volume,
                                  widget.services,
                                ),
                                dense: true,
                              ),
                              const SizedBox(height: headerVerticalPadding),
                            ],
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
              const Divider(height: 0),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            if (widget.services.isEmpty)
              const Center(child: CircularProgressIndicator()),
            ...widget.services
                .map(
                  (final service) => Column(
                    children: [
                      const SizedBox(height: 8),
                      ServiceMigrationListItem(
                        service: service,
                        diskStatus: widget.diskStatus,
                        selectedVolume: serviceToDisk[service.id]!,
                        onChange: onChange,
                      ),
                      const SizedBox(height: 4),
                      const Divider(),
                    ],
                  ),
                )
                .toList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InfoBox(
                text: 'providers.storage.data_migration_notice'.tr(),
                isWarning: true,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              title: 'providers.storage.start_migration_button'.tr(),
              onPressed: () {
                context.read<ServerJobsCubit>().migrateToBinds(serviceToDisk);
                Navigator.of(context).push(
                  materialRoute(const MigrationProcessPage()),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
