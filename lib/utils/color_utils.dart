import 'package:flutter/material.dart';

Color stringToColor(final String string) {
  final int number = string.codeUnits.reduce(
    (final int a, final int b) => a + b,
  );
  final int index = number % colorPalette.length;
  return colorPalette[index];
}

var originalColor = const Color(0xFFDBD8BD);
var count = 40;
var colorPalette = List.generate(
  count,
  (final int index) =>
      HSLColor.fromColor(
        originalColor,
      ).withHue(index * 360.0 / count).toColor(),
);
