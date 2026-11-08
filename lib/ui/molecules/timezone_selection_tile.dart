import 'package:flutter/material.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';
import 'package:timezone/timezone.dart';

class TimezoneSelectionTile extends StatelessWidget {
  const TimezoneSelectionTile({
    required this.location,
    required this.now,
    this.title,
    this.value,
    this.zoneName,
    this.enabled = true,
    super.key,
  });

  final Location location;
  final DateTime now;
  final String? title;
  final String? value;
  final String? zoneName;
  final bool enabled;

  @override
  Widget build(final BuildContext context) {
    final local = TZDateTime.from(now, location);
    final city = location.name.split('/').last.replaceAll('_', ' ');
    final name = location.timeZone(now.millisecondsSinceEpoch).isDst
        ? local.timeZoneName
        : zoneName ?? local.timeZoneName;
    final offset = local.timeZoneOffset.toTimezoneOffsetFormat();
    final time = MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(local),
      alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
    final timeLabel = Text(
      time,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: enabled
            ? Theme.of(context).colorScheme.onSurfaceVariant
            : Theme.of(context).disabledColor,
      ),
    );
    return LayoutBuilder(
      builder: (final context, final constraints) {
        final scaledFontSize = MediaQuery.textScalerOf(context).scale(14);
        final inlineTime = constraints.maxWidth / (scaledFontSize / 14) >= 280;
        return RadioListTile<String>(
          value: value ?? location.name,
          enabled: enabled,
          title: Text(title ?? city),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${title == null ? '' : '$city · '}$name (GMT$offset)'),
              if (!inlineTime) timeLabel,
            ],
          ),
          secondary: inlineTime ? timeLabel : null,
        );
      },
    );
  }
}
