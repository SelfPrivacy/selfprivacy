import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class BrandRadio extends StatelessWidget {
  const BrandRadio({
    Key? key,
    required this.isChecked,
  }) : super(key: key);

  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }

  BoxBorder? _getBorder() {
    return Border.all(
      color: isChecked ? BrandColors.primary : BrandColors.gray1,
      width: 2,
    );
  }
}
