import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    Key? key,
    this.onPressed,
    this.title,
    this.child,
    this.disabled = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? title;
  final Widget? child;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _enabledStyle = ElevatedButton.styleFrom(
      onPrimary: Theme.of(context).colorScheme.onPrimary,
      primary: Theme.of(context).colorScheme.primary,
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));

    final ButtonStyle _disabledStyle = ElevatedButton.styleFrom(
      onPrimary: Theme.of(context).colorScheme.onSurface.withAlpha(30),
      primary: Theme.of(context).colorScheme.onSurface.withAlpha(98),
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 40,
        minWidth: double.infinity,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: disabled ? _disabledStyle : _enabledStyle,
        child: child ?? Text(title ?? ''),
      ),
    );
  }
}
