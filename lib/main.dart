import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';

import 'config/bloc_config.dart';
import 'config/brand_theme.dart';
import 'config/localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    Localization(
      child: BlocAndProviderConfig(
        child: MyApp(),
      ),
    ),
  );
}

var _showOnbording = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // Manually changnig appbar color

      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'SelfPrivacy',
        theme: theme,
        home: _showOnbording ? OnboardingPage() : RootPage(),
      ),
    );
  }
}
