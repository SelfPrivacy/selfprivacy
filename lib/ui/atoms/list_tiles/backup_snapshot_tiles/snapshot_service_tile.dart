import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selfprivacy/logic/models/service.dart';

class SnapshotServiceTile extends StatelessWidget {
  const SnapshotServiceTile({
    required this.service,
    required this.fallbackServiceName,
    super.key,
  });

  final Service? service;
  final String fallbackServiceName;

  @override
  Widget build(final BuildContext context) => ListTile(
    leading:
        service != null
            ? SvgPicture.string(
              service!.svgIcon,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            )
            : const Icon(Icons.question_mark_outlined),
    title: Text('backup.snapshot_service_title'.tr()),
    subtitle: Text(service?.displayName ?? fallbackServiceName),
  );
}
