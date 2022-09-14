import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

// TODO: Delete this file.

class BrandRadio extends StatelessWidget {
  const BrandRadio({
    required this.isChecked,
    final super.key,
  });

  final bool isChecked;

  @override
  Widget build(final BuildContext context) => Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: _getBorder(),
        ),
        child: isChecked
            ? Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: BrandColors.primary,
                ),
              )
            : null,
      );

  BoxBorder? _getBorder() => Border.all(
        color: isChecked ? BrandColors.primary : BrandColors.gray1,
        width: 2,
      );
}
