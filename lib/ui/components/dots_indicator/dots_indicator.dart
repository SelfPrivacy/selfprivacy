import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    required this.activeIndex,
    required this.count,
    final super.key,
  });

  final int activeIndex;
  final int count;

  @override
  Widget build(final BuildContext context) {
    final List<Container> dots = List.generate(
      count,
      (final index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == activeIndex ? BrandColors.blue : BrandColors.gray2,
        ),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }
}
