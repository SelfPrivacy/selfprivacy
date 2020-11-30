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

  static const primary = blue;
  static const headlineColor = black;
  static const inactive = gray2;
  static const scaffoldBackground = gray3;
  static const inputInactive = gray4;

  static const textColor1 = black;
  static const textColor2 = gray1;

  static get navBackground => white.withOpacity(0.8);
}
