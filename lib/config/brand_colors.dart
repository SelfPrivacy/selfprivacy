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

  static const primary = blue;
  static const headlineColor = black;
  static const textColor = gray1;
  static const inactive = gray2;
  static const scaffoldBackground = gray3;

  static get navBackground => white.withOpacity(0.8);
}
