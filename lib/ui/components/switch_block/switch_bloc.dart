import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

// TODO: Delete this file.

class SwitcherBlock extends StatelessWidget {
  const SwitcherBlock({
    required this.child,
    required this.isActive,
    required this.onChange,
    final super.key,
  });

  final Widget child;
  final bool isActive;
  final ValueChanged<bool> onChange;

  @override
  Widget build(final BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: child),
            const SizedBox(width: 5),
            Switch(
              activeColor: BrandColors.green1,
              activeTrackColor: BrandColors.green2,
              onChanged: onChange,
              value: isActive,
            ),
          ],
        ),
      );
}
