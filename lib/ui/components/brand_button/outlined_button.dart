import 'package:flutter/material.dart';

class BrandOutlinedButton extends StatelessWidget {
  const BrandOutlinedButton({
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
  Widget build(final BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 40,
          minWidth: double.infinity,
        ),
        child: OutlinedButton(
          onPressed: onPressed,
          child: child ??
              Text(
                title ?? '',
                style: Theme.of(context).textTheme.button?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
        ),
      );
}
