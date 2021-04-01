import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/utils/extensions/elevation_extension.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? BrandColors.black
            : BrandColors.white,
        borderRadius: BorderRadius.circular(20),
      ).ev8,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: child,
    );
  }
}
