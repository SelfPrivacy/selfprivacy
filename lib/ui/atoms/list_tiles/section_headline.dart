import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SectionHeadline extends StatelessWidget {
  const SectionHeadline({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(final BuildContext context) => ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      );
}
