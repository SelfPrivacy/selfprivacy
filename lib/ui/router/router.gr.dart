// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AboutApplicationPage]
class AboutApplicationRoute extends PageRouteInfo<void> {
  const AboutApplicationRoute({List<PageRouteInfo>? children})
    : super(AboutApplicationRoute.name, initialChildren: children);

  static const String name = 'AboutApplicationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AboutApplicationPage();
    },
  );
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
         args: AddServerProviderTokenRouteArgs(server: server, key: key),
         initialChildren: children,
       );

  static const String name = 'AddServerProviderTokenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddServerProviderTokenRouteArgs>();
      return AddServerProviderTokenPage(server: args.server, key: args.key);
    },
  );
}

class AddServerProviderTokenRouteArgs {
  const AddServerProviderTokenRouteArgs({required this.server, this.key});

  final Server server;

  final Key? key;

  @override
  String toString() {
    return 'AddServerProviderTokenRouteArgs{server: $server, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddServerProviderTokenRouteArgs) return false;
    return server == other.server && key == other.key;
  }

  @override
  int get hashCode => server.hashCode ^ key.hashCode;
}

/// generated route for
/// [AppSettingsPage]
class AppSettingsRoute extends PageRouteInfo<void> {
  const AppSettingsRoute({List<PageRouteInfo>? children})
    : super(AppSettingsRoute.name, initialChildren: children);

  static const String name = 'AppSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppSettingsPage();
    },
  );
}

/// generated route for
/// [BackupDetailsPage]
class BackupDetailsRoute extends PageRouteInfo<void> {
  const BackupDetailsRoute({List<PageRouteInfo>? children})
    : super(BackupDetailsRoute.name, initialChildren: children);

  static const String name = 'BackupDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BackupDetailsPage();
    },
  );
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
         args: BackupsListRouteArgs(service: service, key: key),
         initialChildren: children,
       );

  static const String name = 'BackupsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BackupsListRouteArgs>();
      return BackupsListPage(service: args.service, key: args.key);
    },
  );
}

class BackupsListRouteArgs {
  const BackupsListRouteArgs({required this.service, this.key});

  final Service? service;

  final Key? key;

  @override
  String toString() {
    return 'BackupsListRouteArgs{service: $service, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BackupsListRouteArgs) return false;
    return service == other.service && key == other.key;
  }

  @override
  int get hashCode => service.hashCode ^ key.hashCode;
}

/// generated route for
/// [ConsolePage]
class ConsoleRoute extends PageRouteInfo<void> {
  const ConsoleRoute({List<PageRouteInfo>? children})
    : super(ConsoleRoute.name, initialChildren: children);

  static const String name = 'ConsoleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ConsolePage();
    },
  );
}

/// generated route for
/// [DeveloperSettingsPage]
class DeveloperSettingsRoute extends PageRouteInfo<void> {
  const DeveloperSettingsRoute({List<PageRouteInfo>? children})
    : super(DeveloperSettingsRoute.name, initialChildren: children);

  static const String name = 'DeveloperSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DeveloperSettingsPage();
    },
  );
}

/// generated route for
/// [DevicesPage]
class DevicesRoute extends PageRouteInfo<void> {
  const DevicesRoute({List<PageRouteInfo>? children})
    : super(DevicesRoute.name, initialChildren: children);

  static const String name = 'DevicesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DevicesPage();
    },
  );
}

/// generated route for
/// [DnsDetailsPage]
class DnsDetailsRoute extends PageRouteInfo<void> {
  const DnsDetailsRoute({List<PageRouteInfo>? children})
    : super(DnsDetailsRoute.name, initialChildren: children);

  static const String name = 'DnsDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DnsDetailsPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExtendingVolumeRouteArgs>();
      return ExtendingVolumePage(
        diskVolumeToResize: args.diskVolumeToResize,
        diskStatus: args.diskStatus,
        key: args.key,
      );
    },
  );
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExtendingVolumeRouteArgs) return false;
    return diskVolumeToResize == other.diskVolumeToResize &&
        diskStatus == other.diskStatus &&
        key == other.key;
  }

  @override
  int get hashCode =>
      diskVolumeToResize.hashCode ^ diskStatus.hashCode ^ key.hashCode;
}

/// generated route for
/// [InitializingPage]
class InitializingRoute extends PageRouteInfo<void> {
  const InitializingRoute({List<PageRouteInfo>? children})
    : super(InitializingRoute.name, initialChildren: children);

  static const String name = 'InitializingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InitializingPage();
    },
  );
}

/// generated route for
/// [MemoryUsageByServicePage]
class MemoryUsageByServiceRoute extends PageRouteInfo<void> {
  const MemoryUsageByServiceRoute({List<PageRouteInfo>? children})
    : super(MemoryUsageByServiceRoute.name, initialChildren: children);

  static const String name = 'MemoryUsageByServiceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MemoryUsageByServicePage();
    },
  );
}

/// generated route for
/// [MorePage]
class MoreRoute extends PageRouteInfo<void> {
  const MoreRoute({List<PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MorePage();
    },
  );
}

/// generated route for
/// [NewDevicePage]
class NewDeviceRoute extends PageRouteInfo<void> {
  const NewDeviceRoute({List<PageRouteInfo>? children})
    : super(NewDeviceRoute.name, initialChildren: children);

  static const String name = 'NewDeviceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewDevicePage();
    },
  );
}

/// generated route for
/// [NewUserPage]
class NewUserRoute extends PageRouteInfo<NewUserRouteArgs> {
  NewUserRoute({User? user, Key? key, List<PageRouteInfo>? children})
    : super(
        NewUserRoute.name,
        args: NewUserRouteArgs(user: user, key: key),
        initialChildren: children,
      );

  static const String name = 'NewUserRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewUserRouteArgs>(
        orElse: () => const NewUserRouteArgs(),
      );
      return NewUserPage(user: args.user, key: args.key);
    },
  );
}

class NewUserRouteArgs {
  const NewUserRouteArgs({this.user, this.key});

  final User? user;

  final Key? key;

  @override
  String toString() {
    return 'NewUserRouteArgs{user: $user, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewUserRouteArgs) return false;
    return user == other.user && key == other.key;
  }

  @override
  int get hashCode => user.hashCode ^ key.hashCode;
}

/// generated route for
/// [OnboardingPage]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingPage();
    },
  );
}

/// generated route for
/// [ProvidersPage]
class ProvidersRoute extends PageRouteInfo<void> {
  const ProvidersRoute({List<PageRouteInfo>? children})
    : super(ProvidersRoute.name, initialChildren: children);

  static const String name = 'ProvidersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProvidersPage();
    },
  );
}

/// generated route for
/// [RecoveryKeyPage]
class RecoveryKeyRoute extends PageRouteInfo<void> {
  const RecoveryKeyRoute({List<PageRouteInfo>? children})
    : super(RecoveryKeyRoute.name, initialChildren: children);

  static const String name = 'RecoveryKeyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RecoveryKeyPage();
    },
  );
}

/// generated route for
/// [RecoveryRoutingPage]
class RecoveryRoutingRoute extends PageRouteInfo<void> {
  const RecoveryRoutingRoute({List<PageRouteInfo>? children})
    : super(RecoveryRoutingRoute.name, initialChildren: children);

  static const String name = 'RecoveryRoutingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RecoveryRoutingPage();
    },
  );
}

/// generated route for
/// [ResetPasswordPage]
class ResetPasswordRoute extends PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    required User user,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(user: user, key: key),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return ResetPasswordPage(user: args.user, key: args.key);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({required this.user, this.key});

  final User user;

  final Key? key;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{user: $user, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResetPasswordRouteArgs) return false;
    return user == other.user && key == other.key;
  }

  @override
  int get hashCode => user.hashCode ^ key.hashCode;
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const RootPage());
    },
  );
}

/// generated route for
/// [SelectTimezonePage]
class SelectTimezoneRoute extends PageRouteInfo<void> {
  const SelectTimezoneRoute({List<PageRouteInfo>? children})
    : super(SelectTimezoneRoute.name, initialChildren: children);

  static const String name = 'SelectTimezoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SelectTimezonePage();
    },
  );
}

/// generated route for
/// [ServerDetailsPage]
class ServerDetailsRoute extends PageRouteInfo<void> {
  const ServerDetailsRoute({List<PageRouteInfo>? children})
    : super(ServerDetailsRoute.name, initialChildren: children);

  static const String name = 'ServerDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServerDetailsPage();
    },
  );
}

/// generated route for
/// [ServerLogsPage]
class ServerLogsRoute extends PageRouteInfo<ServerLogsRouteArgs> {
  ServerLogsRoute({
    String? serviceId,
    String? unitId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ServerLogsRoute.name,
         args: ServerLogsRouteArgs(
           serviceId: serviceId,
           unitId: unitId,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'ServerLogsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServerLogsRouteArgs>(
        orElse: () => const ServerLogsRouteArgs(),
      );
      return ServerLogsPage(
        serviceId: args.serviceId,
        unitId: args.unitId,
        key: args.key,
      );
    },
  );
}

class ServerLogsRouteArgs {
  const ServerLogsRouteArgs({this.serviceId, this.unitId, this.key});

  final String? serviceId;

  final String? unitId;

  final Key? key;

  @override
  String toString() {
    return 'ServerLogsRouteArgs{serviceId: $serviceId, unitId: $unitId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ServerLogsRouteArgs) return false;
    return serviceId == other.serviceId &&
        unitId == other.unitId &&
        key == other.key;
  }

  @override
  int get hashCode => serviceId.hashCode ^ unitId.hashCode ^ key.hashCode;
}

/// generated route for
/// [ServerSettingsPage]
class ServerSettingsRoute extends PageRouteInfo<void> {
  const ServerSettingsRoute({List<PageRouteInfo>? children})
    : super(ServerSettingsRoute.name, initialChildren: children);

  static const String name = 'ServerSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServerSettingsPage();
    },
  );
}

/// generated route for
/// [ServerStoragePage]
class ServerStorageRoute extends PageRouteInfo<void> {
  const ServerStorageRoute({List<PageRouteInfo>? children})
    : super(ServerStorageRoute.name, initialChildren: children);

  static const String name = 'ServerStorageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServerStoragePage();
    },
  );
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
         args: ServiceRouteArgs(serviceId: serviceId, key: key),
         initialChildren: children,
       );

  static const String name = 'ServiceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServiceRouteArgs>();
      return ServicePage(serviceId: args.serviceId, key: args.key);
    },
  );
}

class ServiceRouteArgs {
  const ServiceRouteArgs({required this.serviceId, this.key});

  final String serviceId;

  final Key? key;

  @override
  String toString() {
    return 'ServiceRouteArgs{serviceId: $serviceId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ServiceRouteArgs) return false;
    return serviceId == other.serviceId && key == other.key;
  }

  @override
  int get hashCode => serviceId.hashCode ^ key.hashCode;
}

/// generated route for
/// [ServiceSettingsPage]
class ServiceSettingsRoute extends PageRouteInfo<ServiceSettingsRouteArgs> {
  ServiceSettingsRoute({
    required String serviceId,
    bool isInstalling = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ServiceSettingsRoute.name,
         args: ServiceSettingsRouteArgs(
           serviceId: serviceId,
           isInstalling: isInstalling,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'ServiceSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServiceSettingsRouteArgs>();
      return ServiceSettingsPage(
        serviceId: args.serviceId,
        isInstalling: args.isInstalling,
        key: args.key,
      );
    },
  );
}

class ServiceSettingsRouteArgs {
  const ServiceSettingsRouteArgs({
    required this.serviceId,
    this.isInstalling = false,
    this.key,
  });

  final String serviceId;

  final bool isInstalling;

  final Key? key;

  @override
  String toString() {
    return 'ServiceSettingsRouteArgs{serviceId: $serviceId, isInstalling: $isInstalling, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ServiceSettingsRouteArgs) return false;
    return serviceId == other.serviceId &&
        isInstalling == other.isInstalling &&
        key == other.key;
  }

  @override
  int get hashCode => serviceId.hashCode ^ isInstalling.hashCode ^ key.hashCode;
}

/// generated route for
/// [ServicesCatalogPage]
class ServicesCatalogRoute extends PageRouteInfo<void> {
  const ServicesCatalogRoute({List<PageRouteInfo>? children})
    : super(ServicesCatalogRoute.name, initialChildren: children);

  static const String name = 'ServicesCatalogRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServicesCatalogPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServicesMigrationRouteArgs>();
      return ServicesMigrationPage(
        services: args.services,
        diskStatus: args.diskStatus,
        isMigration: args.isMigration,
        key: args.key,
      );
    },
  );
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ServicesMigrationRouteArgs) return false;
    return const ListEquality().equals(services, other.services) &&
        diskStatus == other.diskStatus &&
        isMigration == other.isMigration &&
        key == other.key;
  }

  @override
  int get hashCode =>
      const ListEquality().hash(services) ^
      diskStatus.hashCode ^
      isMigration.hashCode ^
      key.hashCode;
}

/// generated route for
/// [ServicesPage]
class ServicesRoute extends PageRouteInfo<void> {
  const ServicesRoute({List<PageRouteInfo>? children})
    : super(ServicesRoute.name, initialChildren: children);

  static const String name = 'ServicesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServicesPage();
    },
  );
}

/// generated route for
/// [TokensPage]
class TokensRoute extends PageRouteInfo<void> {
  const TokensRoute({List<PageRouteInfo>? children})
    : super(TokensRoute.name, initialChildren: children);

  static const String name = 'TokensRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TokensPage();
    },
  );
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
         args: UserDetailsRouteArgs(login: login, key: key),
         initialChildren: children,
       );

  static const String name = 'UserDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserDetailsRouteArgs>();
      return UserDetailsPage(login: args.login, key: args.key);
    },
  );
}

class UserDetailsRouteArgs {
  const UserDetailsRouteArgs({required this.login, this.key});

  final String login;

  final Key? key;

  @override
  String toString() {
    return 'UserDetailsRouteArgs{login: $login, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserDetailsRouteArgs) return false;
    return login == other.login && key == other.key;
  }

  @override
  int get hashCode => login.hashCode ^ key.hashCode;
}

/// generated route for
/// [UsersPage]
class UsersRoute extends PageRouteInfo<void> {
  const UsersRoute({List<PageRouteInfo>? children})
    : super(UsersRoute.name, initialChildren: children);

  static const String name = 'UsersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UsersPage();
    },
  );
}
