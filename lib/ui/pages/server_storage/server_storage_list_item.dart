import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_linear_indicator/brand_linear_indicator.dart';
import 'package:selfprivacy/ui/pages/server_storage/disk_status.dart';

class ServerStorageListItem extends StatelessWidget {
  const ServerStorageListItem({
    required this.volume,
    final this.showIcon = true,
    final this.dense = false,
    final super.key,
  });

  final DiskVolume volume;
  final bool showIcon;
  final bool dense;

  @override
  Widget build(final BuildContext context) {
    final TextStyle? titleStyle = dense
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.titleLarge;

    final TextStyle? subtitleStyle = dense
        ? Theme.of(context).textTheme.bodySmall
        : Theme.of(context).textTheme.bodyMedium;

    return Row(
      children: [
        if (showIcon)
          Icon(
            Icons.storage_outlined,
            size: 24,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        if (showIcon) const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'providers.storage.disk_usage'.tr(
                  args: [
                    volume.sizeUsed.toString(),
                  ],
                ),
                style: titleStyle,
              ),
              const SizedBox(height: 4),
              BrandLinearIndicator(
                value: volume.percentage,
                color: volume.root
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                height: 14.0,
              ),
              const SizedBox(height: 4),
              Text(
                'providers.storage.disk_total'.tr(
                  args: [
                    volume.sizeTotal.toString(),
                    volume.displayName,
                  ],
                ),
                style: subtitleStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
