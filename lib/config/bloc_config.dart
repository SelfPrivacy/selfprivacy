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
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/logic/providers/server_metadata.dart';

class BlocAndProviderConfig extends StatelessWidget {
  const BlocAndProviderConfig({super.key, this.child});

  final Widget? child;

  @override
  Widget build(final BuildContext context) => MultiProvider(
    providers: [
      BlocProvider(create: (_) => SupportSystemCubit()),
      BlocProvider(
        create: (_) {
          final cubit = ServerInstallationCubit();
          unawaited(cubit.load());
          return cubit;
        },
        lazy: false,
      ),
      BlocProvider(create: (_) => AppReadinessCubit()),
    ],
    child: StreamBuilder<void>(
      stream: getIt<ServerConnectionHub>().changes,
      builder: (final context, final snapshot) {
        final connection = getIt<ServerConnectionHub>().active;
        if (connection == null) {
          return BlocProvider(
            create: (_) =>
                TokensBloc(rotateToken: () async => RotationOutcome.detached),
            child: child,
          );
        }
        return _ServerBlocConfig(
          key: ObjectKey(connection),
          connection: connection,
          child: child,
        );
      },
    ),
  );
}

class _ServerBlocConfig extends StatefulWidget {
  const _ServerBlocConfig({required this.connection, this.child, super.key});
  final ServerConnection connection;
  final Widget? child;
  @override
  State<_ServerBlocConfig> createState() => _ServerBlocConfigState();
}

class _ServerBlocConfigState extends State<_ServerBlocConfig> {
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

  @override
  void initState() {
    super.initState();
    final connection = widget.connection;
    usersBloc = createUsersBloc(connection);
    groupsBloc = GroupsBloc(
      groups: observeConnection(
        connection: connection,
        read: (final connection) => connection.groups.value,
        changes: (final connection) => connection.groups.changes,
      ),
      refresh: () async {
        await connection.groups.refresh(force: true);
      },
    );
    servicesBloc = createServicesBloc(
      connection,
      showMessage: getIt<NavigationService>().showSnackBar,
    );
    backupsBloc = createBackupsBloc(
      connection,
      resources: getIt<ResourcesModel>(),
      showMessage: getIt<NavigationService>().showSnackBar,
    );
    dnsRecordsCubit = createDnsRecordsCubit(
      connection,
      resources: getIt<ResourcesModel>(),
      dnsProvider: () => ProvidersController.currentDnsProvider,
    );
    recoveryKeyBloc = createRecoveryKeyBloc(connection);
    devicesBloc = createDevicesBloc(
      connection,
      showMessage: getIt<NavigationService>().showSnackBar,
    );
    serverJobsBloc = createServerJobsBloc(
      connection,
      showMessage: getIt<NavigationService>().showSnackBar,
    );
    serverDetailsCubit = ServerDetailsCubit(
      onMetadataFailure: () =>
          getIt<NavigationService>().showSnackBar('basis.network_error'.tr()),
      settings: observeConnection(
        connection: connection,
        read: (final connection) => connection.settings.value,
        changes: (final connection) => connection.settings.changes,
      ),
      loadMetadata: (final origin) async {
        if (!connection.isAttached || !identical(connection.origin, origin)) {
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
      connection,
      providerChanges: getIt<ResourcesModel>().statusStream.where(
        (final event) => event is ChangedServerProviderCredentials,
      ),
      serverProvider: () => ProvidersController.currentServerProvider,
      showMessage: getIt<NavigationService>().showSnackBar,
    );
    serverLogsBloc = createServerLogsBloc(connection);
    outdatedServerCheckerBloc = OutdatedServerCheckerBloc(
      versions: observeConnection(
        connection: connection,
        read: (final connection) => connection.cache.apiVersion.value,
        changes: (final connection) => connection.cache.apiVersion.stream,
      ),
    );
    tokensBloc = TokensBloc(rotateToken: connection.rotateToken);
  }

  @override
  Widget build(final BuildContext context) => MultiProvider(
    providers: [
      Provider<ServerConnection>.value(value: widget.connection),
      BlocProvider(create: (final _) => usersBloc, lazy: false),
      BlocProvider(create: (final _) => groupsBloc, lazy: false),
      BlocProvider(create: (final _) => servicesBloc, lazy: false),
      BlocProvider(create: (final _) => backupsBloc, lazy: false),
      BlocProvider(create: (final _) => dnsRecordsCubit, lazy: false),
      BlocProvider(create: (final _) => recoveryKeyBloc, lazy: false),
      BlocProvider(create: (final _) => devicesBloc, lazy: false),
      BlocProvider(create: (final _) => serverJobsBloc, lazy: false),
      BlocProvider(create: (final _) => serverDetailsCubit, lazy: false),
      BlocProvider(create: (final _) => volumesBloc, lazy: false),
      BlocProvider(
        create: (final _) => createJobsCubit(
          widget.connection,
          resources: getIt<ResourcesModel>(),
          dnsProvider: () => ProvidersController.currentDnsProvider,
          showMessage: getIt<NavigationService>().showSnackBar,
        ),
      ),
      BlocProvider(create: (final _) => serverLogsBloc, lazy: false),
      BlocProvider(create: (final _) => outdatedServerCheckerBloc, lazy: false),
      BlocProvider(create: (final _) => tokensBloc, lazy: false),
    ],
    child: widget.child,
  );
}
