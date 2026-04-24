import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Localization extends StatelessWidget {
  const Localization({required this.child, super.key});

  /// value for resetting locale in settings to system default
  static const systemLocale = Locale('system');

  // when adding new locale, add corresponding native language name to mapper
  // below
  static const supportedLocales = [
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
    Locale('it'),
    Locale('ja'),
    // Disabled due to poor translation quality
    // Locale('kk'),
    Locale('lv'),
    Locale('mk'),
    Locale('pl'),
    Locale('ru'),
    Locale('sk'),
    Locale('sl'),
    Locale('th'),
    Locale('uk'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
  ];

  // https://en.wikipedia.org/wiki/IETF_language_tag#List_of_common_primary_language_subtags
  static final _languageNames = {
    systemLocale: 'System default',
    const Locale('ar'): 'العربية',
    const Locale('az'): 'Azərbaycan',
    const Locale('be'): 'беларуская',
    const Locale('cs'): 'čeština',
    const Locale('de'): 'Deutsch',
    const Locale('en'): 'English',
    const Locale('es'): 'español',
    const Locale('et'): 'eesti',
    const Locale('fr'): 'français',
    const Locale('he'): 'עברית',
    const Locale('it'): 'italiano',
    const Locale('ja'): '日本語',
    const Locale('kk'): 'Қазақша',
    const Locale('lv'): 'latviešu',
    const Locale('mk'): 'македонски јазик',
    const Locale('pl'): 'polski',
    const Locale('ru'): 'русский',
    const Locale('sk'): 'slovenčina',
    const Locale('sl'): 'slovenski',
    const Locale('th'): 'ไทย',
    const Locale('uk'): 'Українська',
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'): '中文',
  };

  static String getLanguageName(final Locale locale) =>
      _languageNames[locale] ?? locale.languageCode;

  final Widget child;

  @override
  Widget build(final BuildContext context) => EasyLocalization(
    supportedLocales: supportedLocales,
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    useFallbackTranslations: true,
    saveLocale: false,
    useOnlyLangCode: false,
    child: child,
  );
}
