import 'package:flutter/material.dart';

class OutlinedCard extends StatelessWidget {
  const OutlinedCard({
    required this.child,
    this.borderColor,
    this.borderWidth,
    super.key,
  });

  final Widget child;
  final Color? borderColor;
  final double? borderWidth;
  @override
  Widget build(final BuildContext context) => Card.outlined(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      side: BorderSide(
        color: borderColor ?? Theme.of(context).colorScheme.outline,
        width: borderWidth ?? 1.0,
      ),
    ),
    clipBehavior: Clip.antiAlias,
    child: child,
  );
}
