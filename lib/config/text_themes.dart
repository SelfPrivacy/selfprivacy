import 'package:flutter/material.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';

import 'brand_colors.dart';

final defaultTextStyle = TextStyle(
  fontSize: 15,
  color: BrandColors.textColor1,
);

final headline1Style = defaultTextStyle.copyWith(
  fontSize: 40,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final headline2Style = defaultTextStyle.copyWith(
  fontSize: 24,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final onboardingTitle = defaultTextStyle.copyWith(
  fontSize: 30,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final headline3Style = defaultTextStyle.copyWith(
  fontSize: 20,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final headline4Style = defaultTextStyle.copyWith(
  fontSize: 18,
  fontWeight: NamedFontWeight.medium,
  color: BrandColors.headlineColor,
);

final headline4UnderlinedStyle = defaultTextStyle.copyWith(
  fontSize: 18,
  fontWeight: NamedFontWeight.medium,
  color: BrandColors.headlineColor,
  decoration: TextDecoration.underline,
);

final headline5Style = defaultTextStyle.copyWith(
  fontSize: 15,
  fontWeight: NamedFontWeight.medium,
  color: BrandColors.headlineColor.withOpacity(0.8),
);

final body1Style = defaultTextStyle;
final body2Style = defaultTextStyle.copyWith(
  color: BrandColors.textColor2,
);

final buttonTitleText = defaultTextStyle.copyWith(
  color: BrandColors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
  height: 1,
);

final mediumStyle = defaultTextStyle.copyWith(fontSize: 13, height: 1.53);

final smallStyle = defaultTextStyle.copyWith(fontSize: 11, height: 1.45);

final linkStyle = defaultTextStyle.copyWith(color: BrandColors.blue);

final progressTextStyleLight = TextStyle(
  fontSize: 11,
  color: BrandColors.textColor1,
  height: 1.7,
);

final progressTextStyleDark = progressTextStyleLight.copyWith(
  color: BrandColors.white,
);
