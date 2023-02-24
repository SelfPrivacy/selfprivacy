import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/pages/devices/devices.dart';
import 'package:selfprivacy/ui/pages/more/about_application.dart';
import 'package:selfprivacy/ui/pages/more/app_settings/app_settings.dart';
import 'package:selfprivacy/ui/pages/more/app_settings/developer_settings.dart';
import 'package:selfprivacy/ui/pages/more/console.dart';
import 'package:selfprivacy/ui/pages/more/more.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:selfprivacy/ui/pages/providers/providers.dart';
import 'package:selfprivacy/ui/pages/recovery_key/recovery_key.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/ui/pages/server_storage/binds_migration/services_migration.dart';
import 'package:selfprivacy/ui/pages/services/services.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/initializing.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_routing.dart';
import 'package:selfprivacy/ui/pages/users/users.dart';

part 'router.gr.dart';

Widget fadeThroughTransition(
  final BuildContext context,
  final Animation<double> animation,
  final Animation<double> secondaryAnimation,
  final Widget child,
) =>
    SharedAxisTransition(
      key: UniqueKey(),
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.vertical,
      child: child,
    );

@MaterialAutoRouter(
  // transitionsBuilder: fadeThroughTransition,
  replaceInRouteName: 'Page|Screen|Routing,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: OnboardingPage,
    ),
    AutoRoute(page: InitializingPage),
    AutoRoute(page: RecoveryRouting),
    AutoRoute(
      page: RootPage,
      initial: true,
      children: [
        CustomRoute(
          page: ProvidersPage,
          usesPathAsKey: true,
          initial: true,
          transitionsBuilder: fadeThroughTransition,
          durationInMilliseconds: 400,
        ),
        CustomRoute(
          page: ServicesPage,
          usesPathAsKey: true,
          transitionsBuilder: fadeThroughTransition,
          durationInMilliseconds: 400,
        ),
        CustomRoute(
          page: UsersPage,
          usesPathAsKey: true,
          transitionsBuilder: fadeThroughTransition,
          durationInMilliseconds: 400,
        ),
        CustomRoute(
          page: MorePage,
          usesPathAsKey: true,
          transitionsBuilder: fadeThroughTransition,
          durationInMilliseconds: 400,
        ),
        AutoRoute(page: AppSettingsPage),
        AutoRoute(page: UserDetailsPage),
        AutoRoute(page: RecoveryKeyPage),
        AutoRoute(page: DevicesScreen),
        AutoRoute(page: AboutApplicationPage),
        AutoRoute(page: DeveloperSettingsPage),
      ],
    ),
    AutoRoute(page: ServicesMigrationPage),
    AutoRoute(page: ConsolePage),
  ],
)
class RootRouter extends _$RootRouter {
  RootRouter();
}

// Function to map route names to route titles
String getRouteTitle(final String routeName) {
  switch (routeName) {
    case 'RootRoute':
      return 'basis.app_name';
    case 'ProvidersRoute':
      return 'basis.providers_title';
    case 'ServicesRoute':
      return 'basis.services';
    case 'UsersRoute':
      return 'basis.users';
    case 'MoreRoute':
      return 'basis.more';
    case 'AppSettingsRoute':
      return 'application_settings.title';
    case 'UserDetailsRoute':
      return '[User Details]';
    case 'RecoveryKeyRoute':
      return 'recovery_key.key_main_header';
    case 'DevicesRoute':
      return 'devices.main_screen.header';
    case 'AboutApplicationRoute':
      return 'about_us_page.title';
    case 'ConsoleRoute':
      return '[Console]';
    case 'DeveloperSettingsRoute':
      return 'developer_settings.title';
    default:
      return routeName;
  }
}
