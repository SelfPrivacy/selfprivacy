import 'package:flutter/material.dart';

class BrandSwitch extends StatelessWidget {
  const BrandSwitch({
    required this.onChanged,
    required this.value,
    super.key,
  });

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  Widget build(final BuildContext context) => Switch(
        activeColor: Theme.of(context).colorScheme.primary,
        value: value,
        onChanged: onChanged,
      );
}
