import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SnapshotCreationTimeTile extends StatelessWidget {
  const SnapshotCreationTimeTile({required this.time, super.key});

  final DateTime time;

  @override
  Widget build(final BuildContext context) => ListTile(
    leading: Icon(
      Icons.access_time_outlined,
      color: Theme.of(context).colorScheme.onSurface,
    ),
    title: Text('backup.snapshot_creation_time_title'.tr()),
    subtitle: Text(
      '${MaterialLocalizations.of(context).formatShortDate(time.toLocal())} ${TimeOfDay.fromDateTime(time.toLocal()).format(context)}',
    ),
  );
}
