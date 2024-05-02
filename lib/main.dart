import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/bloc_config.dart';
import 'package:selfprivacy/config/bloc_observer.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/config/localization.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/theming/factory/app_theme_factory.dart';
import 'package:selfprivacy/ui/pages/errors/failed_to_init_secure_storage.dart';
import 'package:selfprivacy/ui/router/router.dart';
// import 'package:wakelock/wakelock.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await HiveConfig.init();
  } on PlatformException catch (e) {
    runApp(
      FailedToInitSecureStorageScreen(e: e),
    );
  }
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // try {
  //   /// Wakelock support for Linux
  //   /// desktop is not yet implemented
  //   await Wakelock.enable();
  // } on PlatformException catch (e) {
  //   print(e);
  // }

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

  Bloc.observer = SimpleBlocObserver();

  runApp(
    Localization(
      child: SelfprivacyApp(
        lightThemeData: lightThemeData,
        darkThemeData: darkThemeData,
      ),
    ),
  );
}

class SelfprivacyApp extends StatelessWidget {
  SelfprivacyApp({
    required this.lightThemeData,
    required this.darkThemeData,
    super.key,
  });

  final ThemeData lightThemeData;
  final ThemeData darkThemeData;

  final _appRouter = RootRouter(getIt.get<NavigationService>().navigatorKey);

  @override
  Widget build(final BuildContext context) => Localization(
        child: BlocAndProviderConfig(
          child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
            builder: (
              final BuildContext context,
              final AppSettingsState appSettings,
            ) {
              getIt.get<ApiConfigModel>().setLocaleCode(
                    context.locale.languageCode,
                  );
              return MaterialApp.router(
                routeInformationParser: _appRouter.defaultRouteParser(),
                routerDelegate: _appRouter.delegate(),
                scaffoldMessengerKey:
                    getIt.get<NavigationService>().scaffoldMessengerKey,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: 'SelfPrivacy',
                theme: lightThemeData,
                darkTheme: darkThemeData,
                themeMode: appSettings.isAutoDarkModeOn
                    ? ThemeMode.system
                    : appSettings.isDarkModeOn
                        ? ThemeMode.dark
                        : ThemeMode.light,
                builder: (final BuildContext context, final Widget? widget) {
                  Widget error =
                      const Center(child: Text('...rendering error...'));
                  if (widget is Scaffold || widget is Navigator) {
                    error = Scaffold(body: error);
                  }
                  ErrorWidget.builder =
                      (final FlutterErrorDetails errorDetails) => error;

                  return widget ?? error;
                },
              );
            },
          ),
        ),
      );
}
