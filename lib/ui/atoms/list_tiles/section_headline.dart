import 'package:flutter/material.dart';

class SectionHeadline extends StatelessWidget {
  const SectionHeadline({required this.title, this.subtitle, super.key});

  final String title;
  final String? subtitle;

  @override
  Widget build(final BuildContext context) => ListTile(
    title: Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        color: Theme.of(context).colorScheme.secondary,
      ),
    ),
    subtitle:
        subtitle != null
            ? Text(subtitle!, style: Theme.of(context).textTheme.labelMedium)
            : null,
  );
}
