// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$RootRouter extends RootStackRouter {
  // ignore: unused_element
  _$RootRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AboutApplicationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutApplicationPage(),
      );
    },
    AddServerProviderTokenRoute.name: (routeData) {
      final args = routeData.argsAs<AddServerProviderTokenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddServerProviderTokenPage(
          server: args.server,
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
    BackupDetailsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BackupDetailsPage(),
      );
    },
    BackupsListRoute.name: (routeData) {
      final args = routeData.argsAs<BackupsListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BackupsListPage(
          service: args.service,
          key: args.key,
        ),
      );
    },
    ConsoleRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ConsolePage(),
      );
    },
    DeveloperSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DeveloperSettingsPage(),
      );
    },
    DevicesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DevicesScreen(),
      );
    },
    DnsDetailsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DnsDetailsPage(),
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
    InitializingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const InitializingPage(),
      );
    },
    MemoryUsageByServiceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MemoryUsageByServiceScreen(),
      );
    },
    MoreRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MorePage(),
      );
    },
    NewUserRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewUserPage(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingPage(),
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
    RecoveryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RecoveryRouting(),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const RootPage()),
      );
    },
    ServerDetailsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ServerDetailsScreen(),
      );
    },
    ServerLogsRoute.name: (routeData) {
      final args = routeData.argsAs<ServerLogsRouteArgs>(
          orElse: () => const ServerLogsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ServerLogsScreen(
          serviceId: args.serviceId,
          key: args.key,
        ),
      );
    },
    ServerSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ServerSettingsScreen(),
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
    ServiceSettingsRoute.name: (routeData) {
      final args = routeData.argsAs<ServiceSettingsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ServiceSettingsPage(
          serviceId: args.serviceId,
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
    ServicesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ServicesPage(),
      );
    },
    TokensRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TokensPage(),
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
    UsersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UsersPage(),
      );
    },
  };
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
/// [AddServerProviderTokenPage]
class AddServerProviderTokenRoute
    extends PageRouteInfo<AddServerProviderTokenRouteArgs> {
  AddServerProviderTokenRoute({
    required Server server,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AddServerProviderTokenRoute.name,
          args: AddServerProviderTokenRouteArgs(
            server: server,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddServerProviderTokenRoute';

  static const PageInfo<AddServerProviderTokenRouteArgs> page =
      PageInfo<AddServerProviderTokenRouteArgs>(name);
}

class AddServerProviderTokenRouteArgs {
  const AddServerProviderTokenRouteArgs({
    required this.server,
    this.key,
  });

  final Server server;

  final Key? key;

  @override
  String toString() {
    return 'AddServerProviderTokenRouteArgs{server: $server, key: $key}';
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
/// [BackupsListPage]
class BackupsListRoute extends PageRouteInfo<BackupsListRouteArgs> {
  BackupsListRoute({
    required Service? service,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BackupsListRoute.name,
          args: BackupsListRouteArgs(
            service: service,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BackupsListRoute';

  static const PageInfo<BackupsListRouteArgs> page =
      PageInfo<BackupsListRouteArgs>(name);
}

class BackupsListRouteArgs {
  const BackupsListRouteArgs({
    required this.service,
    this.key,
  });

  final Service? service;

  final Key? key;

  @override
  String toString() {
    return 'BackupsListRouteArgs{service: $service, key: $key}';
  }
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
/// [MemoryUsageByServiceScreen]
class MemoryUsageByServiceRoute extends PageRouteInfo<void> {
  const MemoryUsageByServiceRoute({List<PageRouteInfo>? children})
      : super(
          MemoryUsageByServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'MemoryUsageByServiceRoute';

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
/// [ServerLogsScreen]
class ServerLogsRoute extends PageRouteInfo<ServerLogsRouteArgs> {
  ServerLogsRoute({
    String? serviceId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ServerLogsRoute.name,
          args: ServerLogsRouteArgs(
            serviceId: serviceId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ServerLogsRoute';

  static const PageInfo<ServerLogsRouteArgs> page =
      PageInfo<ServerLogsRouteArgs>(name);
}

class ServerLogsRouteArgs {
  const ServerLogsRouteArgs({
    this.serviceId,
    this.key,
  });

  final String? serviceId;

  final Key? key;

  @override
  String toString() {
    return 'ServerLogsRouteArgs{serviceId: $serviceId, key: $key}';
  }
}

/// generated route for
/// [ServerSettingsScreen]
class ServerSettingsRoute extends PageRouteInfo<void> {
  const ServerSettingsRoute({List<PageRouteInfo>? children})
      : super(
          ServerSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ServerSettingsRoute';

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
/// [ServiceSettingsPage]
class ServiceSettingsRoute extends PageRouteInfo<ServiceSettingsRouteArgs> {
  ServiceSettingsRoute({
    required String serviceId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ServiceSettingsRoute.name,
          args: ServiceSettingsRouteArgs(
            serviceId: serviceId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ServiceSettingsRoute';

  static const PageInfo<ServiceSettingsRouteArgs> page =
      PageInfo<ServiceSettingsRouteArgs>(name);
}

class ServiceSettingsRouteArgs {
  const ServiceSettingsRouteArgs({
    required this.serviceId,
    this.key,
  });

  final String serviceId;

  final Key? key;

  @override
  String toString() {
    return 'ServiceSettingsRouteArgs{serviceId: $serviceId, key: $key}';
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
/// [TokensPage]
class TokensRoute extends PageRouteInfo<void> {
  const TokensRoute({List<PageRouteInfo>? children})
      : super(
          TokensRoute.name,
          initialChildren: children,
        );

  static const String name = 'TokensRoute';

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
