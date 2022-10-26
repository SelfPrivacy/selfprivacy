import 'package:flutter/material.dart';

class BrandAlert extends AlertDialog {
  BrandAlert({
    super.key,
    final String? title,
    final String? contentText,
    super.actions,
  }) : super(
          title: title != null ? Text(title) : null,
          content: title != null ? Text(contentText!) : null,
        );
}
