// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$RootRouter extends RootStackRouter {
  _$RootRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    OnboardingRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const OnboardingPage(),
      );
    },
    InitializingRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const InitializingPage(),
      );
    },
    RecoveryRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RecoveryRouting(),
      );
    },
    RootRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const RootPage()),
      );
    },
    ServicesMigrationRoute.name: (routeData) {
      final args = routeData.argsAs<ServicesMigrationRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ServicesMigrationPage(
          services: args.services,
          diskStatus: args.diskStatus,
          isMigration: args.isMigration,
          key: args.key,
        ),
      );
    },
    ConsoleRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ConsolePage(),
      );
    },
    ProvidersRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const ProvidersPage(),
        transitionsBuilder: fadeThroughTransition,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ServicesRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const ServicesPage(),
        transitionsBuilder: fadeThroughTransition,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UsersRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const UsersPage(),
        transitionsBuilder: fadeThroughTransition,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MoreRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const MorePage(),
        transitionsBuilder: fadeThroughTransition,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AppSettingsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AppSettingsPage(),
      );
    },
    UserDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: UserDetailsPage(
          login: args.login,
          key: args.key,
        ),
      );
    },
    RecoveryKeyRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RecoveryKeyPage(),
      );
    },
    DevicesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DevicesScreen(),
      );
    },
    AboutApplicationRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AboutApplicationPage(),
      );
    },
    DeveloperSettingsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DeveloperSettingsPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          OnboardingRoute.name,
          path: '/onboarding-page',
        ),
        RouteConfig(
          InitializingRoute.name,
          path: '/initializing-page',
        ),
        RouteConfig(
          RecoveryRoute.name,
          path: '/recovery-routing',
        ),
        RouteConfig(
          RootRoute.name,
          path: '/',
          children: [
            RouteConfig(
              ProvidersRoute.name,
              path: '',
              parent: RootRoute.name,
              usesPathAsKey: true,
            ),
            RouteConfig(
              ServicesRoute.name,
              path: 'services-page',
              parent: RootRoute.name,
              usesPathAsKey: true,
            ),
            RouteConfig(
              UsersRoute.name,
              path: 'users-page',
              parent: RootRoute.name,
              usesPathAsKey: true,
            ),
            RouteConfig(
              MoreRoute.name,
              path: 'more-page',
              parent: RootRoute.name,
              usesPathAsKey: true,
            ),
            RouteConfig(
              AppSettingsRoute.name,
              path: 'app-settings-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              UserDetailsRoute.name,
              path: 'user-details-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              RecoveryKeyRoute.name,
              path: 'recovery-key-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              DevicesRoute.name,
              path: 'devices-screen',
              parent: RootRoute.name,
            ),
            RouteConfig(
              AboutApplicationRoute.name,
              path: 'about-application-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              DeveloperSettingsRoute.name,
              path: 'developer-settings-page',
              parent: RootRoute.name,
            ),
          ],
        ),
        RouteConfig(
          ServicesMigrationRoute.name,
          path: '/services-migration-page',
        ),
        RouteConfig(
          ConsoleRoute.name,
          path: '/console-page',
        ),
      ];
}

/// generated route for
/// [OnboardingPage]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute()
      : super(
          OnboardingRoute.name,
          path: '/onboarding-page',
        );

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [InitializingPage]
class InitializingRoute extends PageRouteInfo<void> {
  const InitializingRoute()
      : super(
          InitializingRoute.name,
          path: '/initializing-page',
        );

  static const String name = 'InitializingRoute';
}

/// generated route for
/// [RecoveryRouting]
class RecoveryRoute extends PageRouteInfo<void> {
  const RecoveryRoute()
      : super(
          RecoveryRoute.name,
          path: '/recovery-routing',
        );

  static const String name = 'RecoveryRoute';
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'RootRoute';
}

/// generated route for
/// [ServicesMigrationPage]
class ServicesMigrationRoute extends PageRouteInfo<ServicesMigrationRouteArgs> {
  ServicesMigrationRoute({
    required List<Service> services,
    required DiskStatus diskStatus,
    required bool isMigration,
    Key? key,
  }) : super(
          ServicesMigrationRoute.name,
          path: '/services-migration-page',
          args: ServicesMigrationRouteArgs(
            services: services,
            diskStatus: diskStatus,
            isMigration: isMigration,
            key: key,
          ),
        );

  static const String name = 'ServicesMigrationRoute';
}

class ServicesMigrationRouteArgs {
  const ServicesMigrationRouteArgs({
    required this.services,
    required this.diskStatus,
    required this.isMigration,
    this.key,
  });

  final List<Service> services;

  final DiskStatus diskStatus;

  final bool isMigration;

  final Key? key;

  @override
  String toString() {
    return 'ServicesMigrationRouteArgs{services: $services, diskStatus: $diskStatus, isMigration: $isMigration, key: $key}';
  }
}

/// generated route for
/// [ConsolePage]
class ConsoleRoute extends PageRouteInfo<void> {
  const ConsoleRoute()
      : super(
          ConsoleRoute.name,
          path: '/console-page',
        );

  static const String name = 'ConsoleRoute';
}

/// generated route for
/// [ProvidersPage]
class ProvidersRoute extends PageRouteInfo<void> {
  const ProvidersRoute()
      : super(
          ProvidersRoute.name,
          path: '',
        );

  static const String name = 'ProvidersRoute';
}

/// generated route for
/// [ServicesPage]
class ServicesRoute extends PageRouteInfo<void> {
  const ServicesRoute()
      : super(
          ServicesRoute.name,
          path: 'services-page',
        );

  static const String name = 'ServicesRoute';
}

/// generated route for
/// [UsersPage]
class UsersRoute extends PageRouteInfo<void> {
  const UsersRoute()
      : super(
          UsersRoute.name,
          path: 'users-page',
        );

  static const String name = 'UsersRoute';
}

/// generated route for
/// [MorePage]
class MoreRoute extends PageRouteInfo<void> {
  const MoreRoute()
      : super(
          MoreRoute.name,
          path: 'more-page',
        );

  static const String name = 'MoreRoute';
}

/// generated route for
/// [AppSettingsPage]
class AppSettingsRoute extends PageRouteInfo<void> {
  const AppSettingsRoute()
      : super(
          AppSettingsRoute.name,
          path: 'app-settings-page',
        );

  static const String name = 'AppSettingsRoute';
}

/// generated route for
/// [UserDetailsPage]
class UserDetailsRoute extends PageRouteInfo<UserDetailsRouteArgs> {
  UserDetailsRoute({
    required String login,
    Key? key,
  }) : super(
          UserDetailsRoute.name,
          path: 'user-details-page',
          args: UserDetailsRouteArgs(
            login: login,
            key: key,
          ),
        );

  static const String name = 'UserDetailsRoute';
}

class UserDetailsRouteArgs {
  const UserDetailsRouteArgs({
    required this.login,
    this.key,
  });

  final String login;

  final Key? key;

  @override
  String toString() {
    return 'UserDetailsRouteArgs{login: $login, key: $key}';
  }
}

/// generated route for
/// [RecoveryKeyPage]
class RecoveryKeyRoute extends PageRouteInfo<void> {
  const RecoveryKeyRoute()
      : super(
          RecoveryKeyRoute.name,
          path: 'recovery-key-page',
        );

  static const String name = 'RecoveryKeyRoute';
}

/// generated route for
/// [DevicesScreen]
class DevicesRoute extends PageRouteInfo<void> {
  const DevicesRoute()
      : super(
          DevicesRoute.name,
          path: 'devices-screen',
        );

  static const String name = 'DevicesRoute';
}

/// generated route for
/// [AboutApplicationPage]
class AboutApplicationRoute extends PageRouteInfo<void> {
  const AboutApplicationRoute()
      : super(
          AboutApplicationRoute.name,
          path: 'about-application-page',
        );

  static const String name = 'AboutApplicationRoute';
}

/// generated route for
/// [DeveloperSettingsPage]
class DeveloperSettingsRoute extends PageRouteInfo<void> {
  const DeveloperSettingsRoute()
      : super(
          DeveloperSettingsRoute.name,
          path: 'developer-settings-page',
        );

  static const String name = 'DeveloperSettingsRoute';
}
