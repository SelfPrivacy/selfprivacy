import 'package:flutter/material.dart';

/// Basically a [TextButton] to be used in dialogs
class DialogActionButton extends StatelessWidget {
  const DialogActionButton({
    super.key,
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
        style:
            isRed
                ? TextStyle(color: Theme.of(context).colorScheme.error)
                : null,
      ),
      onPressed: () {
        navigator.pop();
        onPressed?.call();
      },
    );
  }
}
