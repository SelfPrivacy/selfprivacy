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
        durationInMilliseconds: 400,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ServicesRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const ServicesPage(),
        transitionsBuilder: fadeThroughTransition,
        durationInMilliseconds: 400,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UsersRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const UsersPage(),
        transitionsBuilder: fadeThroughTransition,
        durationInMilliseconds: 400,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MoreRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const MorePage(),
        transitionsBuilder: fadeThroughTransition,
        durationInMilliseconds: 400,
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
    NewUserRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const NewUserPage(),
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
    ServiceRoute.name: (routeData) {
      final args = routeData.argsAs<ServiceRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ServicePage(
          serviceId: args.serviceId,
          key: args.key,
        ),
      );
    },
    ServerDetailsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ServerDetailsScreen(),
      );
    },
    DnsDetailsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DnsDetailsPage(),
      );
    },
    BackupDetailsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const BackupDetailsPage(),
      );
    },
    ServerStorageRoute.name: (routeData) {
      final args = routeData.argsAs<ServerStorageRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ServerStoragePage(
          diskStatus: args.diskStatus,
          key: args.key,
        ),
      );
    },
    ExtendingVolumeRoute.name: (routeData) {
      final args = routeData.argsAs<ExtendingVolumeRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ExtendingVolumePage(
          diskVolumeToResize: args.diskVolumeToResize,
          diskStatus: args.diskStatus,
          key: args.key,
        ),
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
              NewUserRoute.name,
              path: 'new-user-page',
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
            RouteConfig(
              ServiceRoute.name,
              path: 'service-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              ServerDetailsRoute.name,
              path: 'server-details-screen',
              parent: RootRoute.name,
            ),
            RouteConfig(
              DnsDetailsRoute.name,
              path: 'dns-details-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              BackupDetailsRoute.name,
              path: 'backup-details-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              ServerStorageRoute.name,
              path: 'server-storage-page',
              parent: RootRoute.name,
            ),
            RouteConfig(
              ExtendingVolumeRoute.name,
              path: 'extending-volume-page',
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
/// [NewUserPage]
class NewUserRoute extends PageRouteInfo<void> {
  const NewUserRoute()
      : super(
          NewUserRoute.name,
          path: 'new-user-page',
        );

  static const String name = 'NewUserRoute';
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

/// generated route for
/// [ServicePage]
class ServiceRoute extends PageRouteInfo<ServiceRouteArgs> {
  ServiceRoute({
    required String serviceId,
    Key? key,
  }) : super(
          ServiceRoute.name,
          path: 'service-page',
          args: ServiceRouteArgs(
            serviceId: serviceId,
            key: key,
          ),
        );

  static const String name = 'ServiceRoute';
}

class ServiceRouteArgs {
  const ServiceRouteArgs({
    required this.serviceId,
    this.key,
  });

  final String serviceId;

  final Key? key;

  @override
  String toString() {
    return 'ServiceRouteArgs{serviceId: $serviceId, key: $key}';
  }
}

/// generated route for
/// [ServerDetailsScreen]
class ServerDetailsRoute extends PageRouteInfo<void> {
  const ServerDetailsRoute()
      : super(
          ServerDetailsRoute.name,
          path: 'server-details-screen',
        );

  static const String name = 'ServerDetailsRoute';
}

/// generated route for
/// [DnsDetailsPage]
class DnsDetailsRoute extends PageRouteInfo<void> {
  const DnsDetailsRoute()
      : super(
          DnsDetailsRoute.name,
          path: 'dns-details-page',
        );

  static const String name = 'DnsDetailsRoute';
}

/// generated route for
/// [BackupDetailsPage]
class BackupDetailsRoute extends PageRouteInfo<void> {
  const BackupDetailsRoute()
      : super(
          BackupDetailsRoute.name,
          path: 'backup-details-page',
        );

  static const String name = 'BackupDetailsRoute';
}

/// generated route for
/// [ServerStoragePage]
class ServerStorageRoute extends PageRouteInfo<ServerStorageRouteArgs> {
  ServerStorageRoute({
    required DiskStatus diskStatus,
    Key? key,
  }) : super(
          ServerStorageRoute.name,
          path: 'server-storage-page',
          args: ServerStorageRouteArgs(
            diskStatus: diskStatus,
            key: key,
          ),
        );

  static const String name = 'ServerStorageRoute';
}

class ServerStorageRouteArgs {
  const ServerStorageRouteArgs({
    required this.diskStatus,
    this.key,
  });

  final DiskStatus diskStatus;

  final Key? key;

  @override
  String toString() {
    return 'ServerStorageRouteArgs{diskStatus: $diskStatus, key: $key}';
  }
}

/// generated route for
/// [ExtendingVolumePage]
class ExtendingVolumeRoute extends PageRouteInfo<ExtendingVolumeRouteArgs> {
  ExtendingVolumeRoute({
    required DiskVolume diskVolumeToResize,
    required DiskStatus diskStatus,
    Key? key,
  }) : super(
          ExtendingVolumeRoute.name,
          path: 'extending-volume-page',
          args: ExtendingVolumeRouteArgs(
            diskVolumeToResize: diskVolumeToResize,
            diskStatus: diskStatus,
            key: key,
          ),
        );

  static const String name = 'ExtendingVolumeRoute';
}

class ExtendingVolumeRouteArgs {
  const ExtendingVolumeRouteArgs({
    required this.diskVolumeToResize,
    required this.diskStatus,
    this.key,
  });

  final DiskVolume diskVolumeToResize;

  final DiskStatus diskStatus;

  final Key? key;

  @override
  String toString() {
    return 'ExtendingVolumeRouteArgs{diskVolumeToResize: $diskVolumeToResize, diskStatus: $diskStatus, key: $key}';
  }
}
