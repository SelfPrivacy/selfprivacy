import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BrandSpanButton extends TextSpan {
  BrandSpanButton({
    required final String text,
    required final VoidCallback onTap,
    final TextStyle? style,
  }) : super(
          recognizer: TapGestureRecognizer()..onTap = onTap,
          text: text,
          style: (style ?? const TextStyle()).copyWith(color: BrandColors.blue),
        );

  BrandSpanButton.link({
    required final String text,
    final String? urlString,
    final TextStyle? style,
  }) : super(
          recognizer: TapGestureRecognizer()
            ..onTap = () => _launchURL(urlString ?? text),
          text: text,
          style: (style ?? const TextStyle()).copyWith(color: BrandColors.blue),
        );

  static Future<void> _launchURL(final String link) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link));
    } else {
      throw 'Could not launch $link';
    }
  }
}
