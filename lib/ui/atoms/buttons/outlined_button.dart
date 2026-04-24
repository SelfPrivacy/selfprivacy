import 'package:flutter/material.dart';

class BrandOutlinedButton extends StatelessWidget {
  const BrandOutlinedButton({
    super.key,
    this.onPressed,
    this.title,
    this.child,
  });

  final VoidCallback? onPressed;
  final String? title;
  final Widget? child;

  @override
  Widget build(final BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(minWidth: double.infinity),
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
      child:
          child ??
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
    ),
  );
}
