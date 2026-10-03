import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/config/connection_observation.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
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
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/logic/providers/server_metadata.dart';

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
  late final ServerDetailsCubit serverDetailsCubit;
  late final VolumesBloc volumesBloc;
  late final ServerLogsBloc serverLogsBloc;
  late final OutdatedServerCheckerBloc outdatedServerCheckerBloc;
  late final TokensBloc tokensBloc;
  late final AppReadinessCubit appReadinessCubit;

  @override
  void initState() {
    super.initState();
    serverInstallationCubit = ServerInstallationCubit();
    unawaited(serverInstallationCubit.load());
    supportSystemCubit = SupportSystemCubit();
    final hub = getIt<ServerConnectionHub>();
    usersBloc = createUsersBloc(hub);
    groupsBloc = GroupsBloc(
      groups: observeConnection(
        hub: hub,
        read: (final connection) => connection.groups.value,
        changes: (final connection) => connection.groups.changes,
      ),
      refresh: () async {
        await hub.active?.groups.refresh(force: true);
      },
    );
    servicesBloc = createServicesBloc(
      hub,
      showMessage: getIt<NavigationService>().showSnackBar,
    );
    backupsBloc = createBackupsBloc(
      hub,
      resources: getIt<ResourcesModel>(),
      showMessage: getIt<NavigationService>().showSnackBar,
    );
    dnsRecordsCubit = createDnsRecordsCubit(
      hub,
      resources: getIt<ResourcesModel>(),
      dnsProvider: () => ProvidersController.currentDnsProvider,
    );
    recoveryKeyBloc = createRecoveryKeyBloc(hub);
    devicesBloc = createDevicesBloc(
      hub,
      showMessage: getIt<NavigationService>().showSnackBar,
    );
    serverJobsBloc = createServerJobsBloc(
      hub,
      showMessage: getIt<NavigationService>().showSnackBar,
    );
    serverDetailsCubit = ServerDetailsCubit(
      onMetadataFailure: () =>
          getIt<NavigationService>().showSnackBar('basis.network_error'.tr()),
      settings: observeConnection(
        hub: hub,
        read: (final connection) => connection.settings.value,
        changes: (final connection) => connection.settings.changes,
      ),
      loadMetadata: (final origin) async {
        if (!identical(hub.active?.origin, origin)) {
          return [];
        }
        final server = getIt<ResourcesModel>().servers
            .where((final server) => server.uuid == origin.serverId)
            .firstOrNull;
        if (server == null) {
          return [];
        }
        return fetchServerMetadata(
          server: server,
          serverProvider: ProvidersController.currentServerProvider,
          dnsProvider: ProvidersController.currentDnsProvider,
        );
      },
    );
    volumesBloc = createVolumesBloc(
      hub,
      providerChanges: getIt<ResourcesModel>().statusStream.where(
        (final event) => event is ChangedServerProviderCredentials,
      ),
      serverProvider: () => ProvidersController.currentServerProvider,
      showMessage: getIt<NavigationService>().showSnackBar,
    );
    serverLogsBloc = createServerLogsBloc(hub);
    outdatedServerCheckerBloc = OutdatedServerCheckerBloc(
      versions: observeConnection(
        hub: hub,
        read: (final connection) => connection.cache.apiVersion.value,
        changes: (final connection) => connection.cache.apiVersion.stream,
      ),
    );
    tokensBloc = TokensBloc(rotateToken: hub.rotateToken);
    appReadinessCubit = AppReadinessCubit();
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
      BlocProvider(create: (final _) => serverDetailsCubit),
      BlocProvider(create: (final _) => volumesBloc),
      BlocProvider(
        create: (final _) => createJobsCubit(
          getIt<ServerConnectionHub>(),
          resources: getIt<ResourcesModel>(),
          dnsProvider: () => ProvidersController.currentDnsProvider,
          showMessage: getIt<NavigationService>().showSnackBar,
        ),
      ),
      BlocProvider(create: (final _) => serverLogsBloc),
      BlocProvider(create: (final _) => outdatedServerCheckerBloc),
      BlocProvider(create: (final _) => tokensBloc),
      BlocProvider(create: (final _) => appReadinessCubit),
    ],
    child: widget.child,
  );
}
