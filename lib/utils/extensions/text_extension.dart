library text_extension;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:selfprivacy/config/text_themes.dart';

extension TextExtension on Text {
  Text get h1 => copyWith(style: headline1Style);
  Text get h2 => copyWith(style: headline2Style);
  Text get caption => copyWith(style: captionStyle);

  Text get body2 => copyWith(style: body2TextStyle);

  Text setKey(Key key) => copyWith(key: key);

  Text copyWith(
      {Key key,
      StrutStyle strutStyle,
      TextAlign textAlign,
      TextDirection textDirection = TextDirection.ltr,
      Locale locale,
      bool softWrap,
      TextOverflow overflow,
      double textScaleFactor,
      int maxLines,
      String semanticsLabel,
      TextWidthBasis textWidthBasis,
      TextStyle style}) {
    return Text(data,
        key: key ?? this.key,
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: textAlign ?? this.textAlign,
        textDirection: textDirection ?? this.textDirection,
        locale: locale ?? this.locale,
        softWrap: softWrap ?? this.softWrap,
        overflow: overflow ?? this.overflow,
        textScaleFactor: textScaleFactor ?? this.textScaleFactor,
        maxLines: maxLines ?? this.maxLines,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
        style: style != null ? this.style?.merge(style) ?? style : this.style);
  }
}
