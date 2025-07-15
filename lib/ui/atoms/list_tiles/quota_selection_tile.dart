import 'package:flutter/material.dart';

class QuotaSelectionTile extends StatelessWidget {
  const QuotaSelectionTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.min,
    required this.max,
    required this.callback,
    super.key,
  });

  final String title;
  final String subtitle;
  final int value;
  final int min;
  final int max;
  final void Function(double) callback;

  @override
  Widget build(final BuildContext context) => ExpansionTile(
    title: Text(title),
    subtitle: Text(subtitle),
    trailing: Text(
      value == -1 ? '∞' : value.toString(),
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    children: [
      // Discrete slider to select the new value
      if (value >= -1 && value <= max)
        Slider.adaptive(
          value: value == -1 ? max + 1 : value.toDouble(),
          min: min.toDouble(),
          max: (max + 1).toDouble(),
          divisions: max - min + 1,
          label: value == -1 ? '∞' : value.toString(),
          onChanged: callback,
        ),
      if (value < -1 || value > max)
        Text(
          'Manually set to $value',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
    ],
  );
}
