import 'package:flutter/material.dart';

import 'package:selfprivacy/config/brand_colors.dart';

class BrandSwitch extends StatelessWidget {
  const BrandSwitch({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: BrandColors.green1,
      activeTrackColor: BrandColors.green2,
      value: value,
      onChanged: onChanged,
    );
  }
}
