import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/connection_status_bloc.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/bloc/groups/groups_bloc.dart';
import 'package:selfprivacy/logic/bloc/outdated_server_checker/outdated_server_checker_bloc.dart';
import 'package:selfprivacy/logic/bloc/recovery_key/recovery_key_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_logs/server_logs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';

class BlocAndProviderConfig extends StatefulWidget {
  const BlocAndProviderConfig({super.key, this.child});

  final Widget? child;

  @override
  BlocAndProviderConfigState createState() => BlocAndProviderConfigState();
}

class BlocAndProviderConfigState extends State<BlocAndProviderConfig> {
  late final ServerInstallationCubit serverInstallationCubit;
  late final SupportSystemCubit supportSystemCubit;
  late final UsersBloc usersBloc;
  late final GroupsBloc groupsBloc;
  late final ServicesBloc servicesBloc;
  late final BackupsBloc backupsBloc;
  late final DnsRecordsCubit dnsRecordsCubit;
  late final RecoveryKeyBloc recoveryKeyBloc;
  late final DevicesBloc devicesBloc;
  late final ServerJobsBloc serverJobsBloc;
  late final ConnectionStatusBloc connectionStatusBloc;
  late final ServerDetailsCubit serverDetailsCubit;
  late final VolumesBloc volumesBloc;
  late final ServerLogsBloc serverLogsBloc;
  late final OutdatedServerCheckerBloc outdatedServerCheckerBloc;
  late final TokensBloc tokensBloc;

  @override
  void initState() {
    super.initState();
    serverInstallationCubit = ServerInstallationCubit();
    unawaited(serverInstallationCubit.load());
    supportSystemCubit = SupportSystemCubit();
    usersBloc = UsersBloc();
    groupsBloc = GroupsBloc();
    servicesBloc = ServicesBloc();
    backupsBloc = BackupsBloc();
    dnsRecordsCubit = DnsRecordsCubit();
    recoveryKeyBloc = RecoveryKeyBloc();
    devicesBloc = DevicesBloc();
    serverJobsBloc = ServerJobsBloc();
    connectionStatusBloc = ConnectionStatusBloc();
    serverDetailsCubit = ServerDetailsCubit();
    volumesBloc = VolumesBloc();
    serverLogsBloc = ServerLogsBloc();
    outdatedServerCheckerBloc = OutdatedServerCheckerBloc();
    tokensBloc = TokensBloc();
  }

  @override
  Widget build(final BuildContext context) => MultiProvider(
    providers: [
      BlocProvider(create: (final _) => supportSystemCubit),
      BlocProvider(create: (final _) => serverInstallationCubit, lazy: false),
      BlocProvider(create: (final _) => usersBloc, lazy: false),
      BlocProvider(create: (final _) => groupsBloc),
      BlocProvider(create: (final _) => servicesBloc),
      BlocProvider(create: (final _) => backupsBloc),
      BlocProvider(create: (final _) => dnsRecordsCubit),
      BlocProvider(create: (final _) => recoveryKeyBloc),
      BlocProvider(create: (final _) => devicesBloc),
      BlocProvider(create: (final _) => serverJobsBloc),
      BlocProvider(create: (final _) => connectionStatusBloc),
      BlocProvider(create: (final _) => serverDetailsCubit),
      BlocProvider(create: (final _) => volumesBloc),
      BlocProvider(create: (final _) => JobsCubit()),
      BlocProvider(create: (final _) => serverLogsBloc),
      BlocProvider(create: (final _) => outdatedServerCheckerBloc),
      BlocProvider(create: (final _) => tokensBloc),
    ],
    child: widget.child,
  );
}
