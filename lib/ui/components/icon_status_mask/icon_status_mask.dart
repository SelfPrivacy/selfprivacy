import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/logic/models/state_types.dart';

class IconStatusMask extends StatelessWidget {
  IconStatusMask({this.child, this.status});
  final Icon child;

  final StateType status;

  @override
  Widget build(BuildContext context) {
    List<Color> colors;
    switch (status) {
      case StateType.uninitialized:
        colors = BrandColors.uninitializedGradientColors;
        break;
      case StateType.stable:
        colors = BrandColors.stableGradientColors;
        break;
      case StateType.warning:
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
