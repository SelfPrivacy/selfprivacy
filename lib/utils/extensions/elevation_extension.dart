// ignore_for_file: always_specify_types

library elevation_extension;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

extension ElevationExtension on BoxDecoration {
  BoxDecoration copyWith({
    final Color? color,
    final DecorationImage? image,
    final BoxBorder? border,
    final BorderRadiusGeometry? borderRadius,
    final List<BoxShadow>? boxShadow,
    final Gradient? gradient,
    final BlendMode? backgroundBlendMode,
    final BoxShape? shape,
  }) => BoxDecoration(
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
