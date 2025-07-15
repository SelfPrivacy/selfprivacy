import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

class SnapshotIdTile extends StatelessWidget {
  const SnapshotIdTile({required this.snapshotId, super.key});

  final String snapshotId;

  @override
  Widget build(final BuildContext context) => ListTile(
    onLongPress: () async {
      await PlatformAdapter.setClipboard(snapshotId);
      getIt<NavigationService>().showSnackBar('basis.copied_to_clipboard'.tr());
    },
    leading: Icon(
      Icons.numbers_outlined,
      color: Theme.of(context).colorScheme.onSurface,
    ),
    title: Text('backup.snapshot_id_title'.tr()),
    subtitle: Text(snapshotId),
  );
}
