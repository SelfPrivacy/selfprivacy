import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/connection_status/connection_status_bloc.dart';
import 'package:selfprivacy/logic/cubit/devices/devices_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/provider_volumes/provider_volume_cubit.dart';
import 'package:selfprivacy/logic/cubit/recovery_key/recovery_key_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_volumes/server_volume_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';

class BlocAndProviderConfig extends StatefulWidget {
  const BlocAndProviderConfig({super.key, this.child});

  final Widget? child;

  @override
  BlocAndProviderConfigState createState() => BlocAndProviderConfigState();
}

class BlocAndProviderConfigState extends State<BlocAndProviderConfig> {
  late final ServerInstallationCubit serverInstallationCubit;
  late final SupportSystemCubit supportSystemCubit;
  late final UsersCubit usersCubit;
  late final ServicesBloc servicesBloc;
  late final BackupsBloc backupsBloc;
  late final DnsRecordsCubit dnsRecordsCubit;
  late final RecoveryKeyCubit recoveryKeyCubit;
  late final ApiDevicesCubit apiDevicesCubit;
  late final ApiProviderVolumeCubit apiVolumesCubit;
  late final ApiServerVolumeCubit apiServerVolumesCubit;
  late final ServerJobsBloc serverJobsBloc;
  late final ConnectionStatusBloc connectionStatusBloc;
  late final ServerDetailsCubit serverDetailsCubit;

  @override
  void initState() {
    super.initState();
    serverInstallationCubit = ServerInstallationCubit()..load();
    supportSystemCubit = SupportSystemCubit();
    usersCubit = UsersCubit();
    servicesBloc = ServicesBloc();
    backupsBloc = BackupsBloc();
    dnsRecordsCubit = DnsRecordsCubit();
    recoveryKeyCubit = RecoveryKeyCubit();
    apiDevicesCubit = ApiDevicesCubit();
    apiVolumesCubit = ApiProviderVolumeCubit();
    apiServerVolumesCubit = ApiServerVolumeCubit(apiVolumesCubit);
    serverJobsBloc = ServerJobsBloc();
    connectionStatusBloc = ConnectionStatusBloc();
    serverDetailsCubit = ServerDetailsCubit();
  }

  @override
  Widget build(final BuildContext context) {
    const isDark = false;
    const isAutoDark = true;

    return MultiProvider(
      providers: [
        BlocProvider(
          create: (final _) => AppSettingsCubit(
            isDarkModeOn: isDark,
            isAutoDarkModeOn: isAutoDark,
            isOnboardingShowing: true,
          )..load(),
        ),
        BlocProvider(
          create: (final _) => supportSystemCubit,
        ),
        BlocProvider(
          create: (final _) => serverInstallationCubit,
          lazy: false,
        ),
        BlocProvider(
          create: (final _) => usersCubit,
          lazy: false,
        ),
        BlocProvider(
          create: (final _) => servicesBloc,
        ),
        BlocProvider(
          create: (final _) => backupsBloc,
        ),
        BlocProvider(
          create: (final _) => dnsRecordsCubit,
        ),
        BlocProvider(
          create: (final _) => recoveryKeyCubit,
        ),
        BlocProvider(
          create: (final _) => apiDevicesCubit,
        ),
        BlocProvider(
          create: (final _) => apiVolumesCubit,
        ),
        BlocProvider(
          create: (final _) => apiServerVolumesCubit,
        ),
        BlocProvider(
          create: (final _) => serverJobsBloc,
        ),
        BlocProvider(create: (final _) => connectionStatusBloc),
        BlocProvider(
          create: (final _) => serverDetailsCubit,
        ),
        BlocProvider(
          create: (final _) => JobsCubit(
            usersCubit: usersCubit,
            servicesBloc: servicesBloc,
          ),
        ),
      ],
      child: widget.child,
    );
  }
}
