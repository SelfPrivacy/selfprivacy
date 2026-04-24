import 'package:flutter/material.dart';

class ColoredCircle extends StatelessWidget {
  const ColoredCircle({required this.color, super.key});

  final Color color;

  @override
  Widget build(final BuildContext context) => Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: color.withAlpha(102),
      border: Border.all(color: color, width: 1.5),
    ),
  );
}
