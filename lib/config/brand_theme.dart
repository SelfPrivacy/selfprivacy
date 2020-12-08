import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfprivacy/config/text_themes.dart';

import 'brand_colors.dart';

final ligtTheme = ThemeData(
  primaryColor: BrandColors.primary,
  brightness: Brightness.light,
  scaffoldBackgroundColor: BrandColors.scaffoldBackground,
  inputDecorationTheme: InputDecorationTheme(
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
  ),
  textTheme: GoogleFonts.interTextTheme(
    TextTheme(
      headline1: headline1Style,
      headline2: headline2Style,
      caption: headline4Style,
      bodyText1: body1Style,
      subtitle1: TextStyle(fontSize: 15, height: 1.6), // text input style
    ),
  ),
);

var darkTheme = ligtTheme.copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF202120),
  iconTheme: IconThemeData(color: BrandColors.gray3),
  cardColor: BrandColors.gray1,
  textTheme: GoogleFonts.interTextTheme(
    TextTheme(
      headline1: headline1Style.copyWith(color: BrandColors.white),
      headline2: headline2Style.copyWith(color: BrandColors.white),
      caption: headline4Style.copyWith(color: BrandColors.white),
      bodyText1: body1Style.copyWith(color: BrandColors.white),
      subtitle1: TextStyle(fontSize: 15, height: 1.6), // text input style
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
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

final brandPagePadding1 = EdgeInsets.symmetric(horizontal: 15, vertical: 30);

final brandPagePadding2 = EdgeInsets.symmetric(horizontal: 15);
