import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';

import 'config/brand_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // Manually changnig appbar color
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SelfPrivacy',
        theme: theme,
        home: OnboardingPage(),
      ),
    );
  }
}
