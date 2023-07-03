// ignore_for_file: unnecessary_this

import 'dart:ui';

import 'package:duration/duration.dart';
import 'package:duration/locale.dart';

extension DurationFormatter on Duration {
  String toTimezoneOffsetFormat() {
    final designator = this >= Duration.zero ? '+' : '-';

    final Iterable<String> segments = [
      this.inHours.remainder(24).abs(),
      this.inMinutes.remainder(60).abs(),
    ].map((final int seg) => seg.toString().padLeft(2, '0'));

    return '$designator${segments.first}:${segments.last}';
  }

  String toPrettyString(final Locale locale) =>
      prettyDuration(this, locale: getDurationLocale(locale));
}

DurationLocale getDurationLocale(final Locale locale) =>
    DurationLocale.fromLanguageCode(locale.languageCode) ??
    const EnglishDurationLocale();
