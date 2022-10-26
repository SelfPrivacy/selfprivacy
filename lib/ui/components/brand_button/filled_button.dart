import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    super.key,
    this.onPressed,
    this.title,
    this.child,
    this.disabled = false,
  });

  final VoidCallback? onPressed;
  final String? title;
  final Widget? child;
  final bool disabled;

  @override
  Widget build(final BuildContext context) {
    final ButtonStyle enabledStyle = ElevatedButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));

    final ButtonStyle disabledStyle = ElevatedButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onSurface.withAlpha(30),
      backgroundColor: Theme.of(context).colorScheme.onSurface.withAlpha(98),
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 40,
        minWidth: double.infinity,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: disabled ? disabledStyle : enabledStyle,
        child: child ?? Text(title ?? ''),
      ),
    );
  }
}
