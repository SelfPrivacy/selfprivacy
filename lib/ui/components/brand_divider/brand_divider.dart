import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class BrandDivider extends StatelessWidget {
  const BrandDivider({final super.key});

  @override
  Widget build(final BuildContext context) => Container(
        width: double.infinity,
        height: 1,
        color: BrandColors.dividerColor,
      );
}
