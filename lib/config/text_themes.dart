import 'package:flutter/material.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';

import 'package:selfprivacy/config/brand_colors.dart';

const TextStyle defaultTextStyle = TextStyle(
  fontSize: 15,
  color: BrandColors.textColor1,
);

final TextStyle headline1Style = defaultTextStyle.copyWith(
  fontSize: 40,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final TextStyle headline2Style = defaultTextStyle.copyWith(
  fontSize: 24,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final TextStyle onboardingTitle = defaultTextStyle.copyWith(
  fontSize: 30,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final TextStyle headline3Style = defaultTextStyle.copyWith(
  fontSize: 20,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final TextStyle headline4Style = defaultTextStyle.copyWith(
  fontSize: 18,
  fontWeight: NamedFontWeight.medium,
  color: BrandColors.headlineColor,
);

final TextStyle headline4UnderlinedStyle = defaultTextStyle.copyWith(
  fontSize: 18,
  fontWeight: NamedFontWeight.medium,
  color: BrandColors.headlineColor,
  decoration: TextDecoration.underline,
);

final TextStyle headline5Style = defaultTextStyle.copyWith(
  fontSize: 15,
  fontWeight: NamedFontWeight.medium,
  color: BrandColors.headlineColor.withOpacity(0.8),
);

const TextStyle body1Style = defaultTextStyle;
final TextStyle body2Style = defaultTextStyle.copyWith(
  color: BrandColors.textColor2,
);

final TextStyle buttonTitleText = defaultTextStyle.copyWith(
  color: BrandColors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
  height: 1,
);

final TextStyle mediumStyle = defaultTextStyle.copyWith(fontSize: 13, height: 1.53);

final TextStyle smallStyle = defaultTextStyle.copyWith(fontSize: 11, height: 1.45);

const TextStyle progressTextStyleLight = TextStyle(
  fontSize: 11,
  color: BrandColors.textColor1,
  height: 1.7,
);

final TextStyle progressTextStyleDark = progressTextStyleLight.copyWith(
  color: BrandColors.white,
);
