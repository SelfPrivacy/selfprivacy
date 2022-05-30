import 'package:flutter/material.dart';

class BrandSwitch extends StatelessWidget {
  const BrandSwitch({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Theme.of(context).colorScheme.primary,
      value: value,
      onChanged: onChanged,
    );
  }
}
