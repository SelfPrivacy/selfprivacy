import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

List<Color> harmonizedBasicColors(final BuildContext context) => [
  Colors.red.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.green.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.blue.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.purple.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.indigo.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.teal.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.amber.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.deepOrange.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.pink.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.deepPurple.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.cyan.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.lime.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.yellow.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.orange.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.lightBlue.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.lightGreen.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.brown.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.blueGrey.harmonizeWith(Theme.of(context).colorScheme.primary),
  Colors.grey.harmonizeWith(Theme.of(context).colorScheme.primary),
];

List<Color> getGraphColors(final BuildContext context, final int length) {
  final colors = [
    Theme.of(context).colorScheme.primary,
    Theme.of(context).colorScheme.tertiary,
    Theme.of(context).colorScheme.secondary,
    ...harmonizedBasicColors(context),
  ];
  if (length <= colors.length) {
    return colors.sublist(0, length);
  } else {
    return List.generate(
      length,
      (final index) => colors[index % colors.length],
    );
  }
}
