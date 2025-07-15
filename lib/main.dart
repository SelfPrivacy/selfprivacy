import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/app_controller/inherited_app_controller.dart';
import 'package:selfprivacy/config/bloc_config.dart';
import 'package:selfprivacy/config/bloc_observer.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/config/localization.dart';
import 'package:selfprivacy/config/preferences_repository/datasources/preferences_hive_datasource.dart';
import 'package:selfprivacy/config/preferences_repository/inherited_preferences_repository.dart';
import 'package:selfprivacy/ui/pages/errors/failed_to_init_secure_storage.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // try {
  //   /// Wakelock support for Linux
  //   /// desktop is not yet implemented
  //   await Wakelock.enable();
  // } on PlatformException catch (e) {
  //   print(e);
  // }

  try {
    await Future.wait(<Future<void>>[
      HiveConfig.init(),
      EasyLocalization.ensureInitialized(),
    ]);
    await getItSetup();
  } on PlatformException catch (e) {
    runApp(FailedToInitSecureStorageScreen(e: e));
  }

  tz.initializeTimeZones();

  Bloc.observer = SimpleBlocObserver();

  runApp(
    Localization(
      child: InheritedPreferencesRepository(
        dataSource: PreferencesHiveDataSource(),
        child: const InheritedAppController(child: AppBuilder()),
      ),
    ),
  );
}

class AppBuilder extends StatelessWidget {
  const AppBuilder({super.key});

  @override
  Widget build(final BuildContext context) {
    final appController = InheritedAppController.of(context);

    if (appController.loaded) {
      return const SelfprivacyApp();
    }

    return const SplashScreen();
  }
}

/// Widget to be shown
/// until essential app initialization is completed
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(final BuildContext context) => const ColoredBox(
    color: Colors.white,
    child: Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation(BrandColors.primary),
      ),
    ),
  );
}

class SelfprivacyApp extends StatefulWidget {
  const SelfprivacyApp({super.key});

  @override
  State<SelfprivacyApp> createState() => _SelfprivacyAppState();
}

class _SelfprivacyAppState extends State<SelfprivacyApp> {
  final appKey = UniqueKey();
  final _appRouter = RootRouter(getIt.get<NavigationService>().navigatorKey);

  @override
  Widget build(final BuildContext context) {
    final appController = InheritedAppController.of(context);

    return BlocAndProviderConfig(
      child: MaterialApp.router(
        key: appKey,
        title: 'SelfPrivacy',
        // routing
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        scaffoldMessengerKey:
            getIt.get<NavigationService>().scaffoldMessengerKey,
        // localization settings
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        // theme settings
        themeMode: appController.themeMode,
        theme: appController.lightTheme,
        darkTheme: appController.darkTheme,
        // other preferences
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          scrollbars: false,
        ),
        builder: _builder,
      ),
    );
  }

  Widget _builder(final BuildContext context, final Widget? widget) {
    Widget error = const Center(child: Text('...rendering error...'));
    if (widget is Scaffold || widget is Navigator) {
      error = Scaffold(body: error);
    }
    ErrorWidget.builder = (final FlutterErrorDetails errorDetails) => error;

    return widget ?? error;
  }
}
