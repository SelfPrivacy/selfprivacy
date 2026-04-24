import 'package:flutter/material.dart';

class FilledCard extends StatelessWidget {
  const FilledCard({
    required this.child,
    this.secondary = false,
    this.tertiary = false,
    this.error = false,
    this.clipped = true,
    this.mergeSemantics = true,
    super.key,
  });

  final Widget child;
  final bool tertiary;
  final bool error;
  final bool clipped;
  final bool secondary;
  final bool mergeSemantics;
  @override
  Widget build(final BuildContext context) => Card.filled(
    clipBehavior: clipped ? Clip.antiAlias : Clip.none,
    color:
        error
            ? Theme.of(context).colorScheme.errorContainer
            : secondary
            ? Theme.of(context).colorScheme.secondaryContainer
            : tertiary
            ? Theme.of(context).colorScheme.tertiaryContainer
            : Theme.of(context).colorScheme.surfaceContainerHighest,
    semanticContainer: mergeSemantics,
    child: child,
  );
}
