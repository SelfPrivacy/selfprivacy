import 'package:flutter/material.dart';

class BrandCards {
  static Widget big({required final Widget child}) => _BrandCard(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        shadow: bigShadow,
        borderRadius: BorderRadius.circular(20),
        child: child,
      );
  static Widget small({required final Widget child}) => _BrandCard(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        shadow: bigShadow,
        borderRadius: BorderRadius.circular(10),
        child: child,
      );
}

class _BrandCard extends StatelessWidget {
  const _BrandCard({
    required this.child,
    required this.padding,
    required this.shadow,
    required this.borderRadius,
  });

  final Widget child;
  final EdgeInsets padding;
  final List<BoxShadow> shadow;
  final BorderRadius borderRadius;

  @override
  Widget build(final BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: borderRadius,
          boxShadow: shadow,
        ),
        padding: padding,
        child: child,
      );
}

final List<BoxShadow> bigShadow = [
  BoxShadow(
    offset: const Offset(0, 4),
    blurRadius: 8,
    color: Colors.black.withOpacity(.08),
  )
];
