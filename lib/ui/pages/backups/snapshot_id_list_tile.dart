import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SnapshotIdListTile extends StatefulWidget {
  const SnapshotIdListTile({
    required this.snapshotId,
    super.key,
  });

  final String snapshotId;

  @override
  State<SnapshotIdListTile> createState() => _SnapshotIdListTileState();
}

class _SnapshotIdListTileState extends State<SnapshotIdListTile> {
  bool copiedToClipboard = false;

  void handleTimeout() {
    setState(() {
      copiedToClipboard = false;
    });
  }

  @override
  Widget build(final BuildContext context) => ListTile(
        onLongPress: () {
          if (copiedToClipboard == false) {
            Clipboard.setData(ClipboardData(text: widget.snapshotId));
            Timer(const Duration(seconds: 2), handleTimeout);
            setState(() {
              copiedToClipboard = true;
            });
          }
        },
        leading: Icon(
          Icons.numbers_outlined,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        title: Text(
          copiedToClipboard
              ? 'basis.copied_to_clipboard'.tr()
              : 'backup.snapshot_id_title'.tr(),
        ),
        subtitle: Text(
          copiedToClipboard ? '' : widget.snapshotId,
        ),
      );
}
