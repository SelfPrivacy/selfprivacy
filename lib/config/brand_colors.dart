import 'package:flutter/material.dart';

class BrandColors {
  static const Color blue = Color(0xFF093CEF);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color gray1 = Color(0xFF555555);
  static const Color gray2 = Color(0xFF7C7C7C);
  static const Color gray3 = Color(0xFFFAFAFA);
  static const Color gray4 = Color(0xFFDDDDDD);
  static const Color gray5 = Color(0xFFEDEEF1);
  static Color gray6 = const Color(0xFF181818).withOpacity(0.7);
  static const Color grey7 = Color(0xFFABABAB);

  static const Color red1 = Color(0xFFFA0E0E);
  static const Color red2 = Color(0xFFE65527);

  static const Color green1 = Color(0xFF00AF54);

  static const Color green2 = Color(0xFF0F8849);

  static Color get navBackgroundLight => white.withOpacity(0.8);
  static Color get navBackgroundDark => black.withOpacity(0.8);

  static const List<Color> uninitializedGradientColors = [
    Color(0xFF555555),
    Color(0xFFABABAB),
  ];
  static const List<Color> stableGradientColors = [
    Color(0xFF093CEF),
    Color(0xFF14A1CB),
  ];

  static const List<Color> progressGradientColors = [
    Color(0xFF093CEF),
    Color(0xFF14A1CB),
  ];
  static const List<Color> warningGradientColors = [
    Color(0xFFEF4E09),
    Color(0xFFEFD135),
  ];

  static const Color primary = blue;
  static const Color headlineColor = black;
  static const Color inactive = gray2;
  static const Color scaffoldBackground = gray3;
  static const Color inputInactive = gray4;

  static const Color textColor1 = black;
  static const Color textColor2 = gray1;
  static const Color dividerColor = gray5;
  static const Color warning = red1;
}
