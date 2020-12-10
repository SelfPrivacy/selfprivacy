import 'package:flutter/material.dart';

class BrandColors {
  /// ![](https://www.colorhexa.com/093CEF.png)
  static const Color blue = Color(0xFF093CEF);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  /// ![](https://www.colorhexa.com/555555.png)
  static const Color gray1 = Color(0xFF555555);

  /// ![](https://www.colorhexa.com/7C7C7C.png)
  static const Color gray2 = Color(0xFF7C7C7C);

  /// ![](https://www.colorhexa.com/fafafa.png)
  static const Color gray3 = Color(0xFFFAFAFA);

  /// ![](https://www.colorhexa.com/DDDDDD.png)
  static const Color gray4 = Color(0xFFDDDDDD);

  /// ![](https://www.colorhexa.com/EDEEF1.png)
  static const Color gray5 = Color(0xFFEDEEF1);

  /// ![](https://www.colorhexa.com/FA0E0E.png)
  static const Color red = Color(0xFFFA0E0E);

  /// ![](https://www.colorhexa.com/00AF54.png)
  static const Color green1 = Color(0xFF00AF54);

  /// ![](https://www.colorhexa.com/0F8849.png)
  static const Color green2 = Color(0xFF0F8849);


  static get navBackgroundLight => white.withOpacity(0.8);
  static get navBackgroundDark => black.withOpacity(0.8);

  static const List<Color> uninitializedGradientColors = [
    Color(0xFF555555),
    Color(0xFFABABAB),
  ];
  static const List<Color> stableGradientColors = [
    Color(0xFF093CEF),
    Color(0xFF14A1CB),
  ];
  static const List<Color> warningGradientColors = [
    Color(0xFFEF4E09),
    Color(0xFFEFD135),
  ];


  static const primary = blue;
  static const headlineColor = black;
  static const inactive = gray2;
  static const scaffoldBackground = gray3;
  static const inputInactive = gray4;

  static const textColor1 = black;
  static const textColor2 = gray1;
  static const dividerColor = gray5;
  static const warning = red;


}
