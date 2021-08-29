import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/ui/pages/initializing/initializing.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';
import 'package:wakelock/wakelock.dart';

import 'config/bloc_config.dart';
import 'config/bloc_observer.dart';
import 'config/brand_theme.dart';
import 'config/get_it_config.dart';
import 'config/localization.dart';
import 'logic/cubit/app_settings/app_settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.init();
  Bloc.observer = SimpleBlocObserver();
  Wakelock.enable();
  await getItSetup();
  await EasyLocalization.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Localization(
      child: BlocAndProviderConfig(
        child: Builder(builder: (context) {
          var appSettings = context.watch<AppSettingsCubit>().state;

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light, // Manually changnig appbar color
            child: MaterialApp(
              scaffoldMessengerKey:
                  getIt.get<NavigationService>().scaffoldMessengerKey,
              navigatorKey: getIt.get<NavigationService>().navigatorKey,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              title: 'SelfPrivacy',
              theme: appSettings.isDarkModeOn ? darkTheme : ligtTheme,
              home: appSettings.isOnbordingShowing
                  ? OnboardingPage(nextPage: InitializingPage())
                  : RootPage(),
              builder: (BuildContext context, Widget? widget) {
                Widget error = Text('...rendering error...');
                if (widget is Scaffold || widget is Navigator)
                  error = Scaffold(body: Center(child: error));
                ErrorWidget.builder =
                    (FlutterErrorDetails errorDetails) => error;
                return widget!;
              },
            ),
          );
        }),
      ),
    );
  }
}
