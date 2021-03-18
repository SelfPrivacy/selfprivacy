library elevation_extension;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:selfprivacy/config/brand_shadow.dart';

extension ElevationExtension on BoxDecoration {
  BoxDecoration get ev8 => copyWith(boxShadow: [shadow8]);

  BoxDecoration copyWith({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape? shape,
  }) {
    return BoxDecoration(
      color: color ?? this.color,
      image: image ?? this.image,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: this.boxShadow != null || boxShadow != null
          ? [...this.boxShadow ?? [], ...boxShadow ?? []]
          : null,
      gradient: gradient ?? this.gradient,
      backgroundBlendMode: backgroundBlendMode ?? this.backgroundBlendMode,
      shape: shape ?? this.shape,
    );
  }
}
