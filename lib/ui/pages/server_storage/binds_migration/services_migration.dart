import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/ui/organisms/headers/brand_header.dart';
import 'package:selfprivacy/ui/organisms/storage_list_items/server_storage_list_item.dart';
import 'package:selfprivacy/ui/organisms/storage_list_items/service_migration_list_item.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';

@RoutePage()
class ServicesMigrationPage extends StatefulWidget {
  const ServicesMigrationPage({
    required this.services,
    required this.diskStatus,
    required this.isMigration,
    super.key,
  });

  final DiskStatus diskStatus;
  final List<Service> services;
  final bool isMigration;

  @override
  State<ServicesMigrationPage> createState() => _ServicesMigrationPageState();
}

class _ServicesMigrationPageState extends State<ServicesMigrationPage> {
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

  bool get isVolumePicked {
    bool isChangeFound = false;
    for (final Service service in widget.services) {
      for (final String serviceId in serviceToDisk.keys) {
        if (serviceId == service.id &&
            serviceToDisk[serviceId] != service.storageUsage.volume!) {
          isChangeFound = true;
        }
      }
    }

    return isChangeFound;
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBarHeight,
        child: Column(
          children: [
            BrandHeader(
              title: 'storage.data_migration_title'.tr(),
              hasBackButton: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: headerVerticalPadding,
              ),
              child: Column(
                children: [
                  ...widget.diskStatus.diskVolumes.map(
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
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          if (widget.services.isEmpty)
            const Center(child: CircularProgressIndicator.adaptive()),
          ...widget.services.map(
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
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: InfoBox(
              text: 'storage.data_migration_notice'.tr(),
              isWarning: true,
            ),
          ),
          const SizedBox(height: 16),
          if (widget.isMigration || (!widget.isMigration && isVolumePicked))
            BrandButton.filled(
              child: Text('storage.start_migration_button'.tr()),
              onPressed: () {
                if (widget.isMigration) {
                  unawaited(
                    context.read<ServerJobsBloc>().migrateToBinds(
                      serviceToDisk,
                    ),
                  );
                } else {
                  for (final service in widget.services) {
                    if (serviceToDisk[service.id] != null) {
                      context.read<ServicesBloc>().add(
                        ServiceMove(service, serviceToDisk[service.id]!),
                      );
                    }
                  }
                }
                context.router.popUntilRoot();
                unawaited(showModalJobsSheet(context: context));
              },
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
