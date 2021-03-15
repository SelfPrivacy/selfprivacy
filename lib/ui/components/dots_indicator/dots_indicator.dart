import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    Key? key,
    required this.activeIndex,
    required this.count,
  }) : super(key: key);

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    var dots = List.generate(
      count,
      (index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
