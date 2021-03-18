import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.text,
    this.onPressed,
    this.isRed = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? text;
  final bool isRed;

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);

    return TextButton(
      child: Text(
        text!,
        style: isRed ? TextStyle(color: BrandColors.red1) : null,
      ),
      onPressed: () {
        navigator.pop();
        if (onPressed != null) onPressed!();
      },
    );
  }
}
