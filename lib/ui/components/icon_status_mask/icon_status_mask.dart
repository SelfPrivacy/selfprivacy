import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/logic/models/service.dart';

class IconStatusMaks extends StatelessWidget {
  IconStatusMaks({this.child, this.status});
  final Icon child;

  final ServiceStateType status;

  @override
  Widget build(BuildContext context) {
    List<Color> colors;
    switch (status) {
      case ServiceStateType.uninitialized:
        colors = BrandColors.uninitializedGradientColors;
        break;
      case ServiceStateType.stable:
        colors = BrandColors.stableGradientColors;
        break;
      case ServiceStateType.warning:
        colors = BrandColors.warningGradientColors;
        break;
    }
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment(-1, -0.8),
        end: Alignment(0.9, 0.9),
        colors: colors,
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
