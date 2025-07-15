import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, this.error = false, super.key});

  final String title;
  final bool error;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Text(
      title,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
        color:
            error
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.secondary,
      ),
    ),
  );
}
