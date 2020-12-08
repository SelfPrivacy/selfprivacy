import 'package:flutter/material.dart';
import 'package:selfprivacy/config/text_themes.dart';

enum TextType {
  h1, // right now only at onboarding and opened providers
  h2, // cards titles
  h3, // titles in about page
  h4, // caption
  body1, // normal
  body2, // with opacity
  small
}

class BrandText extends StatelessWidget {
  const BrandText(
    this.text, {
    Key key,
    this.style,
    @required this.type,
    this.overflow,
    this.softWrap,
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final TextType type;
  final TextOverflow overflow;
  final bool softWrap;

  factory BrandText.h1(
    String text, {
    TextStyle style,
    TextOverflow overflow,
    bool softWrap,
  }) =>
      BrandText(
        text,
        type: TextType.h1,
        style: style,
      );
  factory BrandText.h2(String text, {TextStyle style}) => BrandText(
        text,
        type: TextType.h2,
        style: style,
      );
  factory BrandText.h3(String text, {TextStyle style}) => BrandText(
        text,
        type: TextType.h3,
        style: style,
      );
  factory BrandText.h4(String text, {TextStyle style}) => BrandText(
        text,
        type: TextType.h4,
        style: style,
      );
  factory BrandText.body1(String text, {TextStyle style}) => BrandText(
        text,
        type: TextType.body1,
        style: style,
      );
  factory BrandText.body2(String text, {TextStyle style}) => BrandText(
        text,
        type: TextType.body2,
        style: style,
      );
  factory BrandText.small(String text, {TextStyle style}) => BrandText(
        text,
        type: TextType.small,
        style: style,
      );
  @override
  Text build(BuildContext context) {
    TextStyle style;
    var isDark = Theme.of(context).brightness == Brightness.dark;

    switch (type) {
      case TextType.h1:
        style = isDark
            ? headline1Style.copyWith(color: Colors.white)
            : headline1Style;
        break;
      case TextType.h2:
        style = isDark
            ? headline2Style.copyWith(color: Colors.white)
            : headline2Style;
        break;
      case TextType.h3:
        style = isDark
            ? headline3Style.copyWith(color: Colors.white)
            : headline3Style;
        break;
      case TextType.h4:
        style = isDark
            ? headline4Style.copyWith(color: Colors.white)
            : headline4Style;
        break;
      case TextType.body1:
        style = isDark ? body1Style.copyWith(color: Colors.white) : body1Style;
        break;
      case TextType.body2:
        style = isDark
            ? body2Style.copyWith(color: Colors.white.withOpacity(0.6))
            : body2Style;
        break;
      case TextType.small:
        style = isDark ? smallStyle.copyWith(color: Colors.white) : smallStyle;
        break;
    }
    if (this.style != null) {
      style = style.merge(this.style);
    }
    return Text(
      text,
      style: style,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
