import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class BrandDivider extends StatelessWidget {
  const BrandDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: BrandColors.dividerColor,
    );
  }
}

