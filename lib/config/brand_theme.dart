import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfprivacy/config/text_themes.dart';

import 'brand_colors.dart';

var theme = ThemeData(
  primaryColor: BrandColors.primary,
  brightness: Brightness.light,
  scaffoldBackgroundColor: BrandColors.scaffoldBackground,
  textTheme: GoogleFonts.interTextTheme(
    TextTheme(
      headline1: headline1Style,
      headline2: headline2Style,
      caption: captionStyle,
      bodyText1: bodyText1Style,
    ),
  ),
);
