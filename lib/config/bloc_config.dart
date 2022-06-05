import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/devices/devices_cubit.dart';
import 'package:selfprivacy/logic/cubit/recovery_key/recovery_key_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/cubit/services/services_cubit.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';

class BlocAndProviderConfig extends StatelessWidget {
  const BlocAndProviderConfig({final super.key, this.child});

  final Widget? child;

  @override
  Widget build(final BuildContext context) {
    const isDark = false;
    final serverInstallationCubit = ServerInstallationCubit()..load();
    final usersCubit = UsersCubit(serverInstallationCubit);
    final servicesCubit = ServicesCubit(serverInstallationCubit);
    final backupsCubit = BackupsCubit(serverInstallationCubit);
    final dnsRecordsCubit = DnsRecordsCubit(serverInstallationCubit);
    final recoveryKeyCubit = RecoveryKeyCubit(serverInstallationCubit);
    final apiDevicesCubit = ApiDevicesCubit(serverInstallationCubit);
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (final _) => AppSettingsCubit(
            isDarkModeOn: isDark,
            isOnboardingShowing: true,
          )..load(),
        ),
        BlocProvider(
          create: (final _) => serverInstallationCubit,
          lazy: false,
        ),
        BlocProvider(create: (final _) => ProvidersCubit()),
        BlocProvider(
          create: (final _) => usersCubit..load(),
          lazy: false,
        ),
        BlocProvider(
          create: (final _) => servicesCubit..load(),
          lazy: false,
        ),
        BlocProvider(
          create: (final _) => backupsCubit..load(),
          lazy: false,
        ),
        BlocProvider(
          create: (final _) => dnsRecordsCubit..load(),
        ),
        BlocProvider(
          create: (final _) => recoveryKeyCubit..load(),
        ),
        BlocProvider(
          create: (final _) => apiDevicesCubit..load(),
        ),
        BlocProvider(
          create: (final _) =>
              JobsCubit(usersCubit: usersCubit, servicesCubit: servicesCubit),
        ),
      ],
      child: child,
    );
  }
}
