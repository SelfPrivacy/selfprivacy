import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    final super.key,
    this.text,
    this.onPressed,
    this.isRed = false,
  });

  final VoidCallback? onPressed;
  final String? text;
  final bool isRed;

  @override
  Widget build(final BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);

    return TextButton(
      child: Text(
        text!,
        style: isRed ? const TextStyle(color: BrandColors.red1) : null,
      ),
      onPressed: () {
        navigator.pop();
        if (onPressed != null) onPressed!();
      },
    );
  }
}
