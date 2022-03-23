import 'package:flutter/material.dart';

Color stringToColor(String string) {
  var number = string.codeUnits.reduce((a, b) => a + b);
  var index = number % colorPalette.length;
  return colorPalette[index];
}

var originalColor = Color(0xFFDBD8BD);
var count = 40;
var colorPalette = List.generate(
  count,
  (index) => HSLColor.fromColor(originalColor)
      .withHue((index) * 360.0 / count)
      .toColor(),
);
