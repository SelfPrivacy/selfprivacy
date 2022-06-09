import 'package:flutter/material.dart';
import 'package:selfprivacy/config/text_themes.dart';

import 'package:selfprivacy/config/brand_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: BrandColors.primary,
  fontFamily: 'Inter',
  brightness: Brightness.light,
  scaffoldBackgroundColor: BrandColors.scaffoldBackground,
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: BrandColors.inputInactive),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: BrandColors.blue),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        width: 1,
        color: BrandColors.red1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        width: 1,
        color: BrandColors.red1,
      ),
    ),
    errorStyle: TextStyle(
      fontSize: 12,
      color: BrandColors.red1,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    minLeadingWidth: 24.0,
  ),
  textTheme: TextTheme(
    headline1: headline1Style,
    headline2: headline2Style,
    headline3: headline3Style,
    headline4: headline4Style,
    bodyText1: body1Style,
    subtitle1: const TextStyle(fontSize: 15, height: 1.6), // text input style
  ),
);

ThemeData darkTheme = lightTheme.copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF202120),
  iconTheme: const IconThemeData(color: BrandColors.gray3),
  cardColor: BrandColors.gray1,
  dialogBackgroundColor: const Color(0xFF202120),
  textTheme: TextTheme(
    headline1: headline1Style.copyWith(color: BrandColors.white),
    headline2: headline2Style.copyWith(color: BrandColors.white),
    headline3: headline3Style.copyWith(color: BrandColors.white),
    headline4: headline4Style.copyWith(color: BrandColors.white),
    bodyText1: body1Style.copyWith(color: BrandColors.white),
    subtitle1: const TextStyle(fontSize: 15, height: 1.6), // text input style
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: BrandColors.white),
    hintStyle: TextStyle(color: BrandColors.white),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: BrandColors.white,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: BrandColors.white,
      ),
    ),
  ),
);

const EdgeInsets paddingH15V30 =
    EdgeInsets.symmetric(horizontal: 15, vertical: 30);

const EdgeInsets paddingH15V0 = EdgeInsets.symmetric(horizontal: 15);
