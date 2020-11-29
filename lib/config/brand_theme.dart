import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';

import 'brand_colors.dart';

var theme = ThemeData(
  primaryColor: BrandColors.primary,
  brightness: Brightness.light,
  scaffoldBackgroundColor: BrandColors.scaffoldBackground,
  textTheme: GoogleFonts.interTextTheme(
    TextTheme(
      headline1: TextStyle(
        fontSize: 40,
        fontWeight: NamedFontWeight.extraBold,
        color: BrandColors.headlineColor,
      ),
      headline2: TextStyle(
        fontSize: 24,
        fontWeight: NamedFontWeight.extraBold,
        color: BrandColors.headlineColor,
      ),
      caption: TextStyle(
          fontSize: 18,
          fontWeight: NamedFontWeight.medium,
          color: BrandColors.headlineColor),
      bodyText1: TextStyle(
        fontSize: 15,
        color: BrandColors.textColor,
      ),
    ),
  ),
);
