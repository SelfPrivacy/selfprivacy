import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfprivacy/config/get_it_config.dart';

class SnapshotIdListTile extends StatelessWidget {
  const SnapshotIdListTile({
    required this.snapshotId,
    super.key,
  });

  final String snapshotId;

  @override
  Widget build(final BuildContext context) => ListTile(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: snapshotId));
          getIt<NavigationService>().showSnackBar(
            'basis.copied_to_clipboard'.tr(),
            behavior: SnackBarBehavior.floating,
          );
        },
        leading: Icon(
          Icons.numbers_outlined,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        title: Text('backup.snapshot_id_title'.tr()),
        subtitle: Text(snapshotId),
      );
}
