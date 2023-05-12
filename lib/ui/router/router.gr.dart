// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$RootRouter extends RootStackRouter {
  _$RootRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    BackupDetailsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BackupDetailsPage(),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const RootPage()),
      );
    },
    ServiceRoute.name: (routeData) {
      final args = routeData.argsAs<ServiceRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ServicePage(
          serviceId: args.serviceId,
          key: args.key,
        ),
      );
    },
    ServicesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ServicesPage(),
      );
    },
    ServerDetailsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ServerDetailsScreen(),
      );
    },
    UsersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UsersPage(),
      );
    },
    NewUserRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewUserPage(),
      );
    },
    UserDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserDetailsPage(
          login: args.login,
          key: args.key,
        ),
      );
    },
    AppSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppSettingsPage(),
      );
    },
    DeveloperSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DeveloperSettingsPage(),
      );
    },
    MoreRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MorePage(),
      );
    },
    AboutApplicationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutApplicationPage(),
      );
    },
    ConsoleRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ConsolePage(),
      );
    },
    ProvidersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProvidersPage(),
      );
    },
    RecoveryKeyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RecoveryKeyPage(),
      );
    },
    DnsDetailsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DnsDetailsPage(),
      );
    },
    RecoveryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RecoveryRouting(),
      );
    },
    InitializingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const InitializingPage(),
      );
    },
    ServerStorageRoute.name: (routeData) {
      final args = routeData.argsAs<ServerStorageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ServerStoragePage(
          diskStatus: args.diskStatus,
          key: args.key,
        ),
      );
    },
    ExtendingVolumeRoute.name: (routeData) {
      final args = routeData.argsAs<ExtendingVolumeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExtendingVolumePage(
          diskVolumeToResize: args.diskVolumeToResize,
          diskStatus: args.diskStatus,
          key: args.key,
        ),
      );
    },
    ServicesMigrationRoute.name: (routeData) {
      final args = routeData.argsAs<ServicesMigrationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ServicesMigrationPage(
          services: args.services,
          diskStatus: args.diskStatus,
          isMigration: args.isMigration,
          key: args.key,
        ),
      );
    },
    DevicesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DevicesScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingPage(),
      );
    },
  };
}

/// generated route for
/// [BackupDetailsPage]
class BackupDetailsRoute extends PageRouteInfo<void> {
  const BackupDetailsRoute({List<PageRouteInfo>? children})
      : super(
          BackupDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BackupDetailsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ServicePage]
class ServiceRoute extends PageRouteInfo<ServiceRouteArgs> {
  ServiceRoute({
    required String serviceId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ServiceRoute.name,
          args: ServiceRouteArgs(
            serviceId: serviceId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ServiceRoute';

  static const PageInfo<ServiceRouteArgs> page =
      PageInfo<ServiceRouteArgs>(name);
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
/// [ServicesPage]
class ServicesRoute extends PageRouteInfo<void> {
  const ServicesRoute({List<PageRouteInfo>? children})
      : super(
          ServicesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ServicesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ServerDetailsScreen]
class ServerDetailsRoute extends PageRouteInfo<void> {
  const ServerDetailsRoute({List<PageRouteInfo>? children})
      : super(
          ServerDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ServerDetailsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UsersPage]
class UsersRoute extends PageRouteInfo<void> {
  const UsersRoute({List<PageRouteInfo>? children})
      : super(
          UsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewUserPage]
class NewUserRoute extends PageRouteInfo<void> {
  const NewUserRoute({List<PageRouteInfo>? children})
      : super(
          NewUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewUserRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserDetailsPage]
class UserDetailsRoute extends PageRouteInfo<UserDetailsRouteArgs> {
  UserDetailsRoute({
    required String login,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          UserDetailsRoute.name,
          args: UserDetailsRouteArgs(
            login: login,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailsRoute';

  static const PageInfo<UserDetailsRouteArgs> page =
      PageInfo<UserDetailsRouteArgs>(name);
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
/// [AppSettingsPage]
class AppSettingsRoute extends PageRouteInfo<void> {
  const AppSettingsRoute({List<PageRouteInfo>? children})
      : super(
          AppSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DeveloperSettingsPage]
class DeveloperSettingsRoute extends PageRouteInfo<void> {
  const DeveloperSettingsRoute({List<PageRouteInfo>? children})
      : super(
          DeveloperSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeveloperSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MorePage]
class MoreRoute extends PageRouteInfo<void> {
  const MoreRoute({List<PageRouteInfo>? children})
      : super(
          MoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoreRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AboutApplicationPage]
class AboutApplicationRoute extends PageRouteInfo<void> {
  const AboutApplicationRoute({List<PageRouteInfo>? children})
      : super(
          AboutApplicationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutApplicationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ConsolePage]
class ConsoleRoute extends PageRouteInfo<void> {
  const ConsoleRoute({List<PageRouteInfo>? children})
      : super(
          ConsoleRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConsoleRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProvidersPage]
class ProvidersRoute extends PageRouteInfo<void> {
  const ProvidersRoute({List<PageRouteInfo>? children})
      : super(
          ProvidersRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProvidersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecoveryKeyPage]
class RecoveryKeyRoute extends PageRouteInfo<void> {
  const RecoveryKeyRoute({List<PageRouteInfo>? children})
      : super(
          RecoveryKeyRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecoveryKeyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DnsDetailsPage]
class DnsDetailsRoute extends PageRouteInfo<void> {
  const DnsDetailsRoute({List<PageRouteInfo>? children})
      : super(
          DnsDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DnsDetailsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecoveryRouting]
class RecoveryRoute extends PageRouteInfo<void> {
  const RecoveryRoute({List<PageRouteInfo>? children})
      : super(
          RecoveryRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecoveryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InitializingPage]
class InitializingRoute extends PageRouteInfo<void> {
  const InitializingRoute({List<PageRouteInfo>? children})
      : super(
          InitializingRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitializingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ServerStoragePage]
class ServerStorageRoute extends PageRouteInfo<ServerStorageRouteArgs> {
  ServerStorageRoute({
    required DiskStatus diskStatus,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ServerStorageRoute.name,
          args: ServerStorageRouteArgs(
            diskStatus: diskStatus,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ServerStorageRoute';

  static const PageInfo<ServerStorageRouteArgs> page =
      PageInfo<ServerStorageRouteArgs>(name);
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
    List<PageRouteInfo>? children,
  }) : super(
          ExtendingVolumeRoute.name,
          args: ExtendingVolumeRouteArgs(
            diskVolumeToResize: diskVolumeToResize,
            diskStatus: diskStatus,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ExtendingVolumeRoute';

  static const PageInfo<ExtendingVolumeRouteArgs> page =
      PageInfo<ExtendingVolumeRouteArgs>(name);
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

/// generated route for
/// [ServicesMigrationPage]
class ServicesMigrationRoute extends PageRouteInfo<ServicesMigrationRouteArgs> {
  ServicesMigrationRoute({
    required List<Service> services,
    required DiskStatus diskStatus,
    required bool isMigration,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ServicesMigrationRoute.name,
          args: ServicesMigrationRouteArgs(
            services: services,
            diskStatus: diskStatus,
            isMigration: isMigration,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ServicesMigrationRoute';

  static const PageInfo<ServicesMigrationRouteArgs> page =
      PageInfo<ServicesMigrationRouteArgs>(name);
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
/// [DevicesScreen]
class DevicesRoute extends PageRouteInfo<void> {
  const DevicesRoute({List<PageRouteInfo>? children})
      : super(
          DevicesRoute.name,
          initialChildren: children,
        );

  static const String name = 'DevicesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingPage]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
