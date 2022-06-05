// ignore_for_file: always_specify_types

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Localization extends StatelessWidget {
  const Localization({
    final super.key,
    this.child,
  });

  final Widget? child;
  @override
  Widget build(final BuildContext context) => EasyLocalization(
      supportedLocales: const [Locale('ru'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: false,
      useOnlyLangCode: true,
      child: child!,
    );
}
