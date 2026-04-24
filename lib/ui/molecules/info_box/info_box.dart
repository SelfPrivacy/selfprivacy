import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({required this.text, this.isWarning = false, super.key});

  final String text;
  final bool isWarning;

  @override
  Widget build(final BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 16,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      Icon(
        isWarning ? Icons.warning_amber_outlined : Icons.info_outline,
        size: 24,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    ],
  );
}
