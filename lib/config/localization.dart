import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Localization extends StatelessWidget {
  const Localization({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: [Locale('ru'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('ru'),
      saveLocale: false,
      useOnlyLangCode: true,
      child: child!,
    );
  }
}
