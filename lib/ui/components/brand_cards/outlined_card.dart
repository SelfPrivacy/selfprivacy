import 'package:flutter/material.dart';

class OutlinedCard extends StatelessWidget {
  const OutlinedCard({
    required this.child,
    final super.key,
  });

  final Widget child;
  @override
  Widget build(final BuildContext context) => Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      );
}
