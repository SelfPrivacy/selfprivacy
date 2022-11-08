import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selfprivacy/logic/cubit/server_volumes/server_volume_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/pages/backup_details/backup_details.dart';
import 'package:selfprivacy/ui/pages/devices/devices.dart';
import 'package:selfprivacy/ui/pages/devices/new_device.dart';
import 'package:selfprivacy/ui/pages/dns_details/dns_details.dart';
import 'package:selfprivacy/ui/pages/more/about_application.dart';
import 'package:selfprivacy/ui/pages/more/app_settings/app_setting.dart';
import 'package:selfprivacy/ui/pages/more/console.dart';
import 'package:selfprivacy/ui/pages/onboarding/onboarding.dart';
import 'package:selfprivacy/ui/pages/recovery_key/recovery_key.dart';
import 'package:selfprivacy/ui/pages/recovery_key/recovery_key_receiving.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/ui/pages/server_details/server_details_screen.dart';
import 'package:selfprivacy/ui/pages/server_storage/binds_migration/services_migration.dart';
import 'package:selfprivacy/ui/pages/server_storage/extending_volume.dart';
import 'package:selfprivacy/ui/pages/server_storage/server_storage.dart';
import 'package:selfprivacy/ui/pages/services/service_page.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/initializing.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_routing.dart';
import 'package:selfprivacy/ui/pages/users/users.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (final _, final __) => const RootPage(),
    ),
    GoRoute(
      path: '/server',
      builder: (final _, final __) => const ServerDetailsScreen(),
      routes: [
        GoRoute(
          path: 'storage',
          builder: (final _, final __) => const ServerStoragePage(),
          routes: [
            GoRoute(
              path: 'extend/:volumeName',
              builder: (final context, final state) => ExtendingVolumePage(
                diskVolumeToResize: context
                    .read<ApiServerVolumeCubit>()
                    .state
                    .diskStatus
                    .getVolumeByName(state.params['volumeName']!),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'settings/timezone',
          builder: (final _, final __) => const SelectTimezone(),
        ),
      ],
    ),
    GoRoute(
      path: '/dns',
      builder: (final _, final __) => const DnsDetailsPage(),
    ),
    GoRoute(
      path: '/backups',
      builder: (final _, final __) => const BackupDetails(),
    ),
    GoRoute(
      path: '/services/:serviceId',
      builder: (final context, final state) => ServicePage(
        serviceId: state.params['serviceId']!,
      ),
      routes: [
        GoRoute(
          path: 'move',
          builder: (final context, final state) => ServicesMigrationPage(
            services: state.extra! as List<Service>,
            isMigration: false,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/users/:userId',
      builder: (final context, final state) =>
          UserDetails(login: state.params['userId']!),
    ),
    GoRoute(
      path: '/migrations/binds',
      builder: (final context, final state) => ServicesMigrationPage(
        services: state.extra! as List<Service>,
        isMigration: true,
      ),
    ),
    GoRoute(
      path: '/initial-setup',
      builder: (final _, final __) => const InitializingPage(),
    ),
    GoRoute(
      path: '/recover-access',
      builder: (final _, final __) => const RecoveryRouting(),
    ),
    GoRoute(
      path: '/recovery-key',
      builder: (final _, final __) => const RecoveryKeyPage(),
      routes: [
        GoRoute(
          path: 'new',
          builder: (final context, final state) => RecoveryKeyReceiving(
            recoveryKey: state.extra! as String,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/devices',
      builder: (final _, final __) => const DevicesScreen(),
      routes: [
        GoRoute(
          path: 'new',
          builder: (final _, final __) => const NewDeviceScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (final _, final __) => const AppSettingsPage(),
    ),
    GoRoute(
      path: '/about',
      builder: (final _, final __) => const AboutPage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (final _, final __) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/console',
      builder: (final _, final __) => const ConsolePage(),
    )
  ],
);
