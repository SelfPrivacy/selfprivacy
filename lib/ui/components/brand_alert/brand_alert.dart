import 'package:flutter/material.dart';

class BrandAlert extends AlertDialog {
  BrandAlert({
    final super.key,
    final String? title,
    final String? contentText,
    final super.actions,
  }) : super(
          title: title != null ? Text(title) : null,
          content: title != null ? Text(contentText!) : null,
        );
}
