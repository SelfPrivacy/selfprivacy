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

final captionStyle = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: NamedFontWeight.medium,
  color: BrandColors.headlineColor,
);

final bodyText1Style = defaultTextStyle;
final body2TextStyle = defaultTextStyle.copyWith(
  color: BrandColors.textColor2,
);
