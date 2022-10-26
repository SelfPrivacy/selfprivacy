import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Localization extends StatelessWidget {
  const Localization({
    super.key,
    this.child,
  });

  final Widget? child;
  @override
  Widget build(final BuildContext context) => EasyLocalization(
        supportedLocales: const [Locale('ru'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        saveLocale: false,
        useOnlyLangCode: true,
        child: child!,
      );
}
