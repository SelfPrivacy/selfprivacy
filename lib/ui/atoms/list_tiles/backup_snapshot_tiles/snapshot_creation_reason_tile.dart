import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SnapshotCreationReasonTile extends StatelessWidget {
  const SnapshotCreationReasonTile({required this.reason, super.key});

  final String reason;

  @override
  Widget build(final BuildContext context) => ListTile(
    leading: Icon(
      Icons.info_outline,
      color: Theme.of(context).colorScheme.onSurface,
    ),
    title: Text('backup.snapshot_reason_title'.tr()),
    subtitle: Text(reason),
  );
}
