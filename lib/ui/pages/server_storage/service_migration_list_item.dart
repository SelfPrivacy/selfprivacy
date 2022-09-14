import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/pages/server_storage/disk_status.dart';

class ServiceMigrationListItem extends StatelessWidget {
  const ServiceMigrationListItem({
    required this.service,
    required this.diskStatus,
    required this.selectedVolume,
    required this.onChange,
    final super.key,
  });

  final Service service;
  final DiskStatus diskStatus;
  final String selectedVolume;
  final Function onChange;

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          _headerRow(context),
          const SizedBox(height: 16),
          ..._radioRows(context),
        ],
      );

  Widget _headerRow(final BuildContext context) => SizedBox(
        height: 24,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: SvgPicture.string(
                  service.svgIcon,
                  width: 24.0,
                  height: 24.0,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  service.displayName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    service.storageUsage.used.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  List<Widget> _radioRows(final BuildContext context) {
    final List<Widget> volumeRows = [];

    for (final DiskVolume volume in diskStatus.diskVolumes) {
      volumeRows.add(
        RadioListTile(
          title: Text(
            volume.displayName,
          ),
          contentPadding: EdgeInsets.zero,
          activeColor: Theme.of(context).colorScheme.secondary,
          dense: true,
          value: volume.name,
          groupValue: selectedVolume,
          onChanged: (final value) {
            onChange(value, service.id);
          },
        ),
      );
    }

    return volumeRows;
  }
}
