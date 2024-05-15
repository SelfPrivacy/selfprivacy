import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Localization extends StatelessWidget {
  const Localization({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(final BuildContext context) => EasyLocalization(
        supportedLocales: const [
          Locale('ar'),
          Locale('az'),
          Locale('be'),
          Locale('cs'),
          Locale('de'),
          Locale('en'),
          Locale('es'),
          Locale('et'),
          Locale('fr'),
          Locale('he'),
          Locale('kk'),
          Locale('lv'),
          Locale('mk'),
          Locale('pl'),
          Locale('ru'),
          Locale('sk'),
          Locale('sl'),
          Locale('th'),
          Locale('uk'),
          Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        saveLocale: false,
        useOnlyLangCode: false,
        child: child,
      );
}
