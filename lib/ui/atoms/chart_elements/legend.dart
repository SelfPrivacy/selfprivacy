import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/chart_elements/colored_circle.dart';

class Legend extends StatelessWidget {
  const Legend({required this.color, required this.text, super.key});

  final String text;
  final Color color;
  @override
  Widget build(final BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      ColoredCircle(color: color),
      const SizedBox(width: 4),
      Text(text, style: Theme.of(context).textTheme.labelSmall),
    ],
  );
}
