import 'package:flutter/material.dart';

class BrandButton {
  static ConstrainedBox rised({
    required final VoidCallback? onPressed,
    final Key? key,
    final String? text,
    final Widget? child,
  }) {
    assert(text == null || child == null, 'required title or child');
    assert(text != null || child != null, 'required title or child');
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 48,
        minWidth: double.infinity,
      ),
      child: FilledButton(
        key: key,
        onPressed: onPressed,
        child: child ?? Text(text ?? ''),
      ),
    );
  }

  static ConstrainedBox filled({
    required final VoidCallback? onPressed,
    final Key? key,
    final String? text,
    final Widget? child,
  }) {
    assert(text == null || child == null, 'required title or child');
    assert(text != null || child != null, 'required title or child');
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 40,
        minWidth: double.infinity,
      ),
      child: FilledButton(
        key: key,
        onPressed: onPressed,
        child: child ?? Text(text ?? ''),
      ),
    );
  }

  static ConstrainedBox text({
    required final VoidCallback onPressed,
    required final String title,
    final Key? key,
  }) =>
      ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 40,
          minWidth: double.infinity,
        ),
        child: TextButton(onPressed: onPressed, child: Text(title)),
      );
}
