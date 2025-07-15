import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/ui/atoms/progress_indicators/brand_linear_indicator.dart';

class ServerStorageListItem extends StatelessWidget {
  const ServerStorageListItem({
    required this.volume,
    this.showIcon = true,
    this.dense = false,
    super.key,
  });

  final DiskVolume volume;
  final bool showIcon;
  final bool dense;

  @override
  Widget build(final BuildContext context) => ConsumptionListItem(
    title: 'storage.disk_usage'.tr(args: [volume.sizeUsed.toString()]),
    subtitle: 'storage.disk_total'.tr(
      namedArgs: {
        'sizeTotal': volume.sizeTotal.toString(),
        'displayName': volume.displayName,
      },
    ),
    dense: dense,
    color:
        volume.root
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    percentage: volume.percentage,
    icon:
        showIcon
            ? Icon(
              Icons.storage_outlined,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            )
            : null,
  );
}

class ConsumptionListItem extends StatelessWidget {
  const ConsumptionListItem({
    required this.title,
    required this.color,
    required this.backgroundColor,
    required this.percentage,
    this.subtitle,
    this.rightSideText,
    this.icon,
    this.dense = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? rightSideText;
  final Color color;
  final Color backgroundColor;
  final double percentage;
  final Widget? icon;
  final bool dense;

  @override
  Widget build(final BuildContext context) {
    final TextStyle? titleStyle =
        dense
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.titleLarge;

    final TextStyle? subtitleStyle =
        dense
            ? Theme.of(context).textTheme.bodySmall
            : Theme.of(context).textTheme.bodyMedium;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) icon!,
        if (icon != null) const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    rightSideText != null
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                children: [
                  Text(title, style: titleStyle, textAlign: TextAlign.start),
                  if (rightSideText != null)
                    Text(
                      rightSideText!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.end,
                    ),
                ],
              ),
              const SizedBox(height: 4),
              BrandLinearIndicator(
                value: percentage,
                color: color,
                backgroundColor: backgroundColor,
                height: dense ? 8.0 : 14.0,
              ),
              const SizedBox(height: 4),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: subtitleStyle,
                  textAlign: TextAlign.start,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
