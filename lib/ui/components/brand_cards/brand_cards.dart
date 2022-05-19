import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class BrandCards {
  static Widget big({required Widget child}) => _BrandCard(
        child: child,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        shadow: bigShadow,
        borderRadius: BorderRadius.circular(20),
      );
  static Widget small({required Widget child}) => _BrandCard(
        child: child,
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        shadow: bigShadow,
        borderRadius: BorderRadius.circular(10),
      );
  static Widget outlined({required Widget child}) => _OutlinedCard(
        child: child,
      );
  static Widget filled({required Widget child}) => _FilledCard(
        child: child,
      );
}

class _BrandCard extends StatelessWidget {
  const _BrandCard({
    Key? key,
    required this.child,
    required this.padding,
    required this.shadow,
    required this.borderRadius,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final List<BoxShadow> shadow;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? BrandColors.black
            : BrandColors.white,
        borderRadius: borderRadius,
        boxShadow: shadow,
      ),
      padding: padding,
      child: child,
    );
  }
}

class _OutlinedCard extends StatelessWidget {
  const _OutlinedCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _FilledCard extends StatelessWidget {
  const _FilledCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
      color: Theme.of(context).colorScheme.surfaceVariant,
    );
  }
}

final bigShadow = [
  BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 8,
    color: Colors.black.withOpacity(.08),
  )
];
