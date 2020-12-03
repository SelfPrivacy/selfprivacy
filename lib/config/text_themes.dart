import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';

import 'brand_colors.dart';

final defaultTextStyle = GoogleFonts.inter(
  textStyle: TextStyle(
    fontSize: 15,
    color: BrandColors.textColor1,
  ),
);

final headline1Style = GoogleFonts.inter(
  fontSize: 40,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final headline2Style = GoogleFonts.inter(
  fontSize: 24,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final headline3Style = GoogleFonts.inter(
  fontSize: 20,
  fontWeight: NamedFontWeight.extraBold,
  color: BrandColors.headlineColor,
);

final captionStyle = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: NamedFontWeight.medium,
  color: BrandColors.headlineColor,
);

final body1Style = defaultTextStyle;
final body2Style = defaultTextStyle.copyWith(
  color: BrandColors.textColor2,
);

final smallStyle = defaultTextStyle.copyWith(fontSize: 11, height: 1.45);
