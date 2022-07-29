import 'package:flutter/material.dart';

class BrandLinearIndicator extends StatelessWidget {
  const BrandLinearIndicator({
    required this.value,
    required this.color,
    required this.backgroundColor,
    required this.height,
    final super.key,
  });

  final double value;
  final Color color;
  final Color backgroundColor;
  final double height;

  @override
  Widget build(final BuildContext context) => Container(
        height: height,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(height),
        ),
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: value,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(height),
            ),
          ),
        ),
      );
}
