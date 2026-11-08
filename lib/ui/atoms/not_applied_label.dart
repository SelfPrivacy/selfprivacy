import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotAppliedLabel extends StatelessWidget {
  const NotAppliedLabel({super.key});

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Text(
      'data_status.not_applied'.tr(),
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}
