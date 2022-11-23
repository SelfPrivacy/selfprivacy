import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/theming/factory/app_theme_factory.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/initializing.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:wakelock/wakelock.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:selfprivacy/config/bloc_config.dart';
import 'package:selfprivacy/config/bloc_observer.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/localization.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  try {
    /// Wakelock support for Linux
    /// desktop is not yet implemented
    await Wakelock.enable();
  } on PlatformException catch (e) {
    print(e);
  }

  await getItSetup();
  await EasyLocalization.ensureInitialized();
  tz.initializeTimeZones();

  final ThemeData lightThemeData = await AppThemeFactory.create(
    isDark: false,
    fallbackColor: BrandColors.primary,
  );
  final ThemeData darkThemeData = await AppThemeFactory.create(
    isDark: true,
    fallbackColor: BrandColors.primary,
  );

  BlocOverrides.runZoned(
    () => runApp(
      Localization(
        child: MyApp(
          lightThemeData: lightThemeData,
          darkThemeData: darkThemeData,
        ),
      ),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.lightThemeData,
    required this.darkThemeData,
    super.key,
  });

  final ThemeData lightThemeData;
  final ThemeData darkThemeData;

  @override
  Widget build(final BuildContext context) => Localization(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light, // Manually changing appbar color
          child: BlocAndProviderConfig(
            child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
              builder: (
                final BuildContext context,
                final AppSettingsState appSettings,
              ) =>
                  MaterialApp(
                scaffoldMessengerKey:
                    getIt.get<NavigationService>().scaffoldMessengerKey,
                navigatorKey: getIt.get<NavigationService>().navigatorKey,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: 'SelfPrivacy',
                theme: lightThemeData,
                darkTheme: darkThemeData,
                themeMode:
                    appSettings.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
                home: appSettings.isOnboardingShowing
                    ? const OnboardingPage(nextPage: InitializingPage())
                    : const RootPage(),
                builder: (final BuildContext context, final Widget? widget) {
                  Widget error = const Text('...rendering error...');
                  if (widget is Scaffold || widget is Navigator) {
                    error = Scaffold(body: Center(child: error));
                  }
                  ErrorWidget.builder =
                      (final FlutterErrorDetails errorDetails) => error;
                  return widget!;
                },
              ),
            ),
          ),
        ),
      );
}
