import 'package:flutter/material.dart';

class BrandButton {
  static ConstrainedBox filled({
    required final VoidCallback? onPressed,
    final Key? key,
    final String? title,
    final Widget? child,
  }) {
    assert((title ?? child) != null, 'either title or child must not be empty');
    assert(title != null || child != null, 'title or child must be provided');

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: FilledButton(
        key: key,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.padded,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child:
            child ??
            Text(
              title ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
      ),
    );
  }

  static ConstrainedBox text({
    required final VoidCallback onPressed,
    required final String title,
    final Key? key,
  }) => ConstrainedBox(
    constraints: const BoxConstraints(minHeight: 40, minWidth: double.infinity),
    child: TextButton(onPressed: onPressed, child: Text(title)),
  );
}
