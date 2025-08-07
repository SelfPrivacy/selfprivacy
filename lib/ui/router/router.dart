import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/pages/backups/backup_details.dart';
import 'package:selfprivacy/ui/pages/backups/backups_list.dart';
import 'package:selfprivacy/ui/pages/devices/devices.dart';
import 'package:selfprivacy/ui/pages/devices/new_device.dart';
import 'package:selfprivacy/ui/pages/dns_details/dns_details.dart';
import 'package:selfprivacy/ui/pages/more/about_application.dart';
import 'package:selfprivacy/ui/pages/more/app_settings/app_settings.dart';
import 'package:selfprivacy/ui/pages/more/app_settings/developer_settings.dart';
import 'package:selfprivacy/ui/pages/more/console/console_page.dart';
import 'package:selfprivacy/ui/pages/more/more.dart';
import 'package:selfprivacy/ui/pages/more/tokens/add_server_provider_token.dart';
import 'package:selfprivacy/ui/pages/more/tokens/tokens_page.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:selfprivacy/ui/pages/providers/providers.dart';
import 'package:selfprivacy/ui/pages/recovery_key/recovery_key.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/ui/pages/server/logs.dart';
import 'package:selfprivacy/ui/pages/server/memory_usage_by_service.dart';
import 'package:selfprivacy/ui/pages/server/server_details.dart';
import 'package:selfprivacy/ui/pages/server/server_settings.dart';
import 'package:selfprivacy/ui/pages/server_storage/binds_migration/services_migration.dart';
import 'package:selfprivacy/ui/pages/server_storage/extending_volume.dart';
import 'package:selfprivacy/ui/pages/server_storage/server_storage.dart';
import 'package:selfprivacy/ui/pages/services/service.dart';
import 'package:selfprivacy/ui/pages/services/service_settings.dart';
import 'package:selfprivacy/ui/pages/services/services.dart';
import 'package:selfprivacy/ui/pages/services/services_catalog.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/initializing.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_routing.dart';
import 'package:selfprivacy/ui/pages/users/new_user.dart';
import 'package:selfprivacy/ui/pages/users/reset_password/reset_password_page.dart';
import 'package:selfprivacy/ui/pages/users/user_details_page/user_details.dart';
import 'package:selfprivacy/ui/pages/users/users.dart';

part 'router.gr.dart';

Widget fadeThroughTransition(
  final BuildContext context,
  final Animation<double> animation,
  final Animation<double> secondaryAnimation,
  final Widget child,
) => SharedAxisTransition(
  key: UniqueKey(),
  animation: animation,
  secondaryAnimation: secondaryAnimation,
  transitionType: SharedAxisTransitionType.vertical,
  child: child,
);

@AutoRouterConfig(
  // transitionsBuilder: fadeThroughTransition,
  replaceInRouteName: 'Page|Screen,Route',
)
class RootRouter extends RootStackRouter {
  RootRouter(final GlobalKey<NavigatorState> navigatorKey)
    : super(navigatorKey: navigatorKey);

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: InitializingRoute.page),
    AutoRoute(page: RecoveryRoutingRoute.page),
    AutoRoute(
      page: RootRoute.page,
      path: '/',
      children: [
        CustomRoute(
          page: ProvidersRoute.page,
          usesPathAsKey: true,
          path: '',
          transitionsBuilder: fadeThroughTransition,
          duration: const Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: ServicesRoute.page,
          usesPathAsKey: true,
          transitionsBuilder: fadeThroughTransition,
          duration: const Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: UsersRoute.page,
          usesPathAsKey: true,
          transitionsBuilder: fadeThroughTransition,
          duration: const Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: MoreRoute.page,
          usesPathAsKey: true,
          transitionsBuilder: fadeThroughTransition,
          duration: const Duration(milliseconds: 400),
        ),
        AutoRoute(page: AppSettingsRoute.page),
        AutoRoute(page: UserDetailsRoute.page),
        AutoRoute(page: NewUserRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: RecoveryKeyRoute.page),
        AutoRoute(page: DevicesRoute.page),
        AutoRoute(page: NewDeviceRoute.page),
        AutoRoute(page: AboutApplicationRoute.page),
        AutoRoute(page: DeveloperSettingsRoute.page),
        AutoRoute(page: ServiceRoute.page),
        AutoRoute(page: ServiceSettingsRoute.page),
        AutoRoute(page: ServicesCatalogRoute.page),
        AutoRoute(page: ServerDetailsRoute.page),
        AutoRoute(page: SelectTimezoneRoute.page),
        AutoRoute(page: DnsDetailsRoute.page),
        AutoRoute(page: BackupDetailsRoute.page),
        AutoRoute(page: BackupsListRoute.page),
        AutoRoute(page: ServerStorageRoute.page),
        AutoRoute(page: ExtendingVolumeRoute.page),
        AutoRoute(page: ServerSettingsRoute.page),
        AutoRoute(page: ServerLogsRoute.page),
        AutoRoute(page: TokensRoute.page),
        AutoRoute(page: MemoryUsageByServiceRoute.page),
        AutoRoute(page: AddServerProviderTokenRoute.page),
      ],
    ),
    AutoRoute(page: ServicesMigrationRoute.page),
    AutoRoute(page: ConsoleRoute.page),
  ];
}

// Function to map route names to route titles
String getRouteTitle(final String routeName) {
  switch (routeName) {
    case 'RootRoute':
      return 'basis.app_name';
    case 'ProvidersRoute':
      return 'basis.providers_title';
    case 'ServicesRoute':
    case 'ServiceRoute':
      return 'basis.services';
    case 'ServiceSettingsRoute':
      return 'service_page.settings';
    case 'ServicesCatalogRoute':
      return 'services_catalog.title';
    case 'UsersRoute':
      return 'basis.users';
    case 'MoreRoute':
      return 'basis.more';
    case 'AppSettingsRoute':
      return 'application_settings.title';
    case 'UserDetailsRoute':
      return 'users.details_title';
    case 'NewUserRoute':
      return 'users.new_user';
    case 'ResetPasswordRoute':
      return 'users.reset_password';
    case 'RecoveryKeyRoute':
      return 'recovery_key.key_main_header';
    case 'DevicesRoute':
      return 'devices.main_screen.header';
    case 'AboutApplicationRoute':
      return 'about_application_page.title';
    case 'ConsoleRoute':
      return 'console_page.title';
    case 'DeveloperSettingsRoute':
      return 'developer_settings.title';
    case 'DnsDetailsRoute':
      return 'domain.screen_title';
    case 'ServerDetailsRoute':
      return 'server.card_title';
    case 'ServerSettingsRoute':
      return 'server.settings';
    case 'ServerLogsRoute':
      return 'server.logs';
    case 'BackupDetailsRoute':
      return 'backup.card_title';
    case 'BackupsListRoute':
      return 'backup.snapshots_title';
    case 'ServerStorageRoute':
      return 'storage.card_title';
    case 'ExtendingVolumeRoute':
      return 'storage.extending_volume_title';
    case 'TokensRoute':
      return 'tokens.title';
    case 'MemoryUsageByServiceRoute':
      return 'resource_chart.memory';
    case 'AddServerProviderTokenPage':
      return 'tokens.add_server_provider_token';
    default:
      return routeName;
  }
}
