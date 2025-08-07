import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/service.dart';

class ServiceMigrationListItem extends StatelessWidget {
  const ServiceMigrationListItem({
    required this.service,
    required this.diskStatus,
    required this.selectedVolume,
    required this.onChange,
    super.key,
  });

  final Service service;
  final DiskStatus diskStatus;
  final String selectedVolume;
  final Function(String, String) onChange;

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      ServiceConsumptionTitle(service: service),
      const SizedBox(height: 16),
      ..._radioRows(context),
    ],
  );

  List<Widget> _radioRows(final BuildContext context) {
    final List<Widget> volumeRows = [];

    for (final DiskVolume volume in diskStatus.diskVolumes) {
      volumeRows.add(
        RadioListTile(
          title: Text(volume.displayName),
          contentPadding: EdgeInsets.zero,
          activeColor: Theme.of(context).colorScheme.secondary,
          dense: true,
          value: volume.name,
          groupValue: selectedVolume,
          onChanged: (final String? value) {
            if (value == null) {
              return;
            }
            onChange(value, service.id);
          },
        ),
      );
    }

    return volumeRows;
  }
}

class ServiceConsumptionTitle extends StatelessWidget {
  const ServiceConsumptionTitle({required this.service, super.key});

  final Service service;

  @override
  Widget build(final BuildContext context) => SizedBox(
    height: 24,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: SvgPicture.string(
              service.svgIcon,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
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
}
