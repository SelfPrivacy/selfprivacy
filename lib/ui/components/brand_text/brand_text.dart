import 'package:flutter/material.dart';
import 'package:selfprivacy/config/text_themes.dart';
export 'package:selfprivacy/utils/extensions/text_extensions.dart';

enum TextType {
  h1, // right now only at onboarding and opened providers
  h2, // cards titles
  h3, // titles in about page
  h4, // caption
  h5, // Table data
  body1, // normal
  body2, // with opacity
  medium,
  small,
  onboardingTitle,
  buttonTitleText, // risen button title text,
  h4Underlined,
}

class BrandText extends StatelessWidget {
  factory BrandText.h4(
    final String? text, {
    final TextStyle? style,
    final TextAlign? textAlign,
  }) =>
      BrandText(
        text,
        type: TextType.h4,
        style: style,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: textAlign,
      );

  factory BrandText.onboardingTitle(final String text, {final TextStyle? style}) =>
      BrandText(
        text,
        type: TextType.onboardingTitle,
        style: style,
      );
  factory BrandText.h3(final String text, {final TextStyle? style, final TextAlign? textAlign}) =>
      BrandText(
        text,
        type: TextType.h3,
        style: style,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
      );

  factory BrandText.h4Underlined(
    final String? text, {
    final TextStyle? style,
    final TextAlign? textAlign,
  }) =>
      BrandText(
        text,
        type: TextType.h4Underlined,
        style: style,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: textAlign,
      );

  factory BrandText.h1(
    final String? text, {
    final TextStyle? style,
    final TextOverflow? overflow,
    final bool? softWrap,
  }) =>
      BrandText(
        text,
        type: TextType.h1,
        style: style,
      );
  factory BrandText.h2(
    final String? text, {
    final TextStyle? style,
    final TextAlign? textAlign,
  }) =>
      BrandText(
        text,
        type: TextType.h2,
        style: style,
        textAlign: textAlign,
      );
  factory BrandText.body1(final String? text, {final TextStyle? style}) => BrandText(
        text,
        type: TextType.body1,
        style: style,
      );
  factory BrandText.small(final String text, {final TextStyle? style}) => BrandText(
        text,
        type: TextType.small,
        style: style,
      );
  factory BrandText.body2(final String? text, {final TextStyle? style}) => BrandText(
        text,
        type: TextType.body2,
        style: style,
      );
  factory BrandText.buttonTitleText(final String? text, {final TextStyle? style}) =>
      BrandText(
        text,
        type: TextType.buttonTitleText,
        style: style,
      );

  factory BrandText.h5(
    final String? text, {
    final TextStyle? style,
    final TextAlign? textAlign,
  }) =>
      BrandText(
        text,
        type: TextType.h5,
        style: style,
        textAlign: textAlign,
      );
  factory BrandText.medium(final String? text,
          {final TextStyle? style, final TextAlign? textAlign}) =>
      BrandText(
        text,
        type: TextType.medium,
        style: style,
        textAlign: textAlign,
      );
  const BrandText(
    this.text, {
    super.key,
    this.style,
    required this.type,
    this.overflow,
    this.softWrap,
    this.textAlign,
    this.maxLines,
  });

  final String? text;
  final TextStyle? style;
  final TextType type;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLines;
  @override
  Text build(final BuildContext context) {
    TextStyle style;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
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
      case TextType.h4Underlined:
        style = isDark
            ? headline4UnderlinedStyle.copyWith(color: Colors.white)
            : headline4UnderlinedStyle;
        break;
      case TextType.h5:
        style = isDark
            ? headline5Style.copyWith(color: Colors.white)
            : headline5Style;
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
      case TextType.onboardingTitle:
        style = isDark
            ? onboardingTitle.copyWith(color: Colors.white)
            : onboardingTitle;
        break;
      case TextType.medium:
        style =
            isDark ? mediumStyle.copyWith(color: Colors.white) : mediumStyle;
        break;
      case TextType.buttonTitleText:
        style = !isDark
            ? buttonTitleText.copyWith(color: Colors.white)
            : buttonTitleText;
        break;
    }
    if (this.style != null) {
      style = style.merge(this.style);
    }
    return Text(
      text!,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
    );
  }
}
