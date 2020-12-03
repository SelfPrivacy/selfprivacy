import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfprivacy/config/text_themes.dart';

import 'brand_colors.dart';

final theme = ThemeData(
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
      caption: captionStyle,
      bodyText1: body1Style,
      subtitle1: TextStyle(fontSize: 15, height: 1.6), // text input style
    ),
  ),
);

final brandPagePadding1 = EdgeInsets.symmetric(horizontal: 15, vertical: 30);

final brandPagePadding2 = EdgeInsets.symmetric(horizontal: 15);
