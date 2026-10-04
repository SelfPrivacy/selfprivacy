import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/connection_observation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/bloc/recovery_key/recovery_key_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_logs/server_logs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/users/reset_password_bloc.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/operations_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_cubit.dart';
import 'package:selfprivacy/logic/cubit/dns_records/dns_records_repository.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/operations/backups/initialize_backups_operation.dart';
import 'package:selfprivacy/logic/operations/configuration/apply_changes_operation.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/logic/operations/remove_operation_history.dart';
import 'package:selfprivacy/logic/operations/volumes/move_services.dart';
import 'package:selfprivacy/logic/operations/volumes/resize_volume_operation.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider_factory.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';

UsersBloc createUsersBloc(final ServerConnection connection) => UsersBloc(
  users: observeConnection(
    connection: connection,
    read: (final owner) => owner.users.value,
    changes: (final owner) => owner.users.changes,
  ),
  refresh: () async {
    await connection.users.refresh(force: true);
  },
  save: (final user, {required final create}) => connection.run(
    OperationKind.manageUsers,
    (final owner) =>
        create ? owner.users.createUser(user) : owner.users.updateUser(user),
  ),
);

DevicesBloc createDevicesBloc(
  final ServerConnection connection, {
  required final void Function(String) showMessage,
}) => DevicesBloc(
  devices: observeConnection(
    connection: connection,
    read: (final connection) => connection.devices.value,
    changes: (final connection) => connection.devices.changes,
  ),
  refresh: () async {
    await connection.devices.refresh(force: true);
  },
  revoke: (final name) => connection.run<CommandCompletion<void>?>(
    OperationKind.manageDevices,
    (final owner) async {
      final completion = await owner.devices.revoke(name);
      if (completion?.result case final result?) {
        OperationExecution.current?.record(result);
      }
      return completion;
    },
  ),
  generateKey: (final recipient) => recipient.receive(
    connection.submit(
      OperationKind.generateDeviceKey,
      (final owner) =>
          recipient.protect(() => owner.devices.createAuthorizationKey()),
    ),
  ),
  showMessage: showMessage,
  rotationChanges: Stream<RotationStatus>.multi((final output) {
    output.addSync(connection.rotation.status);
    final subscription = connection.changes.listen(
      (_) => output.addSync(connection.rotation.status),
      onDone: output.close,
    );
    output.onCancel = subscription.cancel;
  }).distinct(),
  cancelRotation: connection.cancelRotation,
  rotateToken: connection.rotateToken,
);

RecoveryKeyBloc createRecoveryKeyBloc(final ServerConnection connection) =>
    RecoveryKeyBloc(
      status: observeConnection(
        connection: connection,
        read: (final connection) => connection.recoveryKey.value,
        changes: (final connection) => connection.recoveryKey.changes,
      ),
      refresh: () async {
        final owner = connection;
        if (owner.isAttached) {
          await owner.recoveryKey.refresh(force: true);
        }
      },
      generate: (final recipient, final expirationDate, final numberOfUses) =>
          recipient.receive(
            connection.submit(
              OperationKind.generateRecoveryKey,
              (final owner) => recipient.protect(
                () => owner.recoveryKey.generate(
                  expirationDate: expirationDate,
                  numberOfUses: numberOfUses,
                ),
              ),
            ),
          ),
    );

ResetPasswordBloc createResetPasswordBloc(
  final ServerConnection connection,
  final User user,
) => ResetPasswordBloc(
  versions: observeConnection(
    connection: connection,
    read: (final connection) => connection.cache.apiVersion.value,
    changes: (final connection) => connection.cache.apiVersion.stream,
  ),
  generate: (final recipient) => recipient.receive(
    connection.submit(
      OperationKind.generatePasswordResetLink,
      (final owner) =>
          recipient.protect(() => owner.users.generatePasswordResetLink(user)),
    ),
  ),
);

MetricsCubit createMetricsCubit(
  final ServerConnection connection, {
  required final ResourcesModel resources,
  required final ServerProvider? Function() serverProvider,
}) => MetricsCubit(
  access: observeReadAccess(connection),
  loadMetrics: (final period) => connection.read((final connection) async {
    final server = resources.servers
        .where((final server) => server.uuid == connection.origin.serverId)
        .firstOrNull;
    final provider = serverProvider();
    await connection.refresh(connection.cache.apiVersion);
    return MetricsRepository(
      api: connection.api,
      version: connection.cache.apiVersion.value.data,
      isAvailable: () => connection.isAttached && connection.canRead,
      provider: provider,
      providerId: server?.hostingDetails.providerId,
    ).getRelevantServerMetrics(period);
  }),
);

ServerLogsBloc createServerLogsBloc(final ServerConnection connection) =>
    ServerLogsBloc(
      access: observeReadAccess(connection),
      fetch:
          ({required final limit, final downCursor, final slice, final unit}) =>
              connection.read((final connection) async {
                await connection.refresh(connection.cache.apiVersion);
                final version = connection.cache.apiVersion.value.data;
                const supported = '>=3.3.0';
                if (version == null) {
                  throw Exception('basis.network_error'.tr());
                }
                if (!VersionConstraint.parse(supported).allows(version)) {
                  throw Exception(
                    'basis.feature_unsupported_on_api_version'.tr(
                      namedArgs: {
                        'versionConstraint': supported,
                        'currentVersion': version.toString(),
                      },
                    ),
                  );
                }
                return connection.api.getServerLogs(
                  limit: limit,
                  downCursor: downCursor,
                  slice: slice,
                  unit: unit,
                );
              }),
      entries: connection.logs,
    );

JobsCubit createJobsCubit(
  final ServerConnection connection, {
  required final ResourcesModel resources,
  required final DnsProvider? Function() dnsProvider,
  required final void Function(String) showMessage,
}) => JobsCubit(
  jobs: observeConnection(
    connection: connection,
    read: (final owner) => owner.jobs.snapshot,
    changes: (final owner) => owner.jobs.changes,
  ),
  settings: observeConnection(
    connection: connection,
    read: (final owner) => owner.settings.value,
    changes: (final owner) => owner.settings.changes,
  ),
  admitOperation: (final kind, final action) {
    final busy = connection.operations.pending.any(
      (final operation) => switch (operation.kind) {
        OperationKind.applyChanges ||
        OperationKind.rebootServer ||
        OperationKind.upgradeServer ||
        OperationKind.collectGarbage => true,
        _ => false,
      },
    );
    if (busy) {
      return Future.value(const OperationResult<void>(OperationStatus.notSent));
    }
    return connection.submit<void>(kind, (final owner) {
      final server = resources.servers
          .where((final server) => server.uuid == owner.origin.serverId)
          .firstOrNull;
      if (server == null) {
        throw const OperationNotSent();
      }
      return action(
        ApplyChangesOperation(
          users: owner.users,
          settings: owner.settings,
          services: owner.services,
          jobs: owner.jobs,
          volumes: owner.volumes,
          readDns: () => owner.api.getDnsRecords(),
          dnsProvider: dnsProvider(),
          domain: server.domain,
        ),
      );
    }).result;
  },
  showMessage: showMessage,
);

BackupsBloc createBackupsBloc(
  final ServerConnection connection, {
  required final ResourcesModel resources,
  required final void Function(String) showMessage,
  final BackupsProvider Function(BackupsCredential)? createProvider,
}) => BackupsBloc(
  backups: observeConnection(
    connection: connection,
    read: (final owner) => owner.backups.snapshot,
    changes: (final owner) => owner.backups.changes,
  ),
  admitOperation: (final kind, final action) {
    if ((kind == OperationKind.initializeBackups ||
            kind == OperationKind.removeBackups) &&
        connection.operations.pending.any(
          (final operation) =>
              operation.kind == OperationKind.initializeBackups ||
              operation.kind == OperationKind.removeBackups,
        )) {
      return Future.value(const OperationResult<void>(OperationStatus.notSent));
    }
    return connection
        .submit<void>(kind, (final owner) => action(owner.backups))
        .result;
  },
  currentBucket: () => connection.isAttached ? resources.backblazeBucket : null,
  saveBucket: (final bucket) async {
    if (connection.isAttached &&
        resources.backblazeBucket?.bucketId == bucket.bucketId) {
      await resources.setBackblazeBucket(bucket);
    }
  },
  removeBucket: (final bucket) async {
    if (connection.isAttached && identical(resources.backblazeBucket, bucket)) {
      await resources.removeBackblazeBucket();
    }
  },
  initialize: (final repository, final credential) {
    final owner = connection;
    if (!owner.isAttached || !identical(owner.backups, repository)) {
      throw const OperationNotSent();
    }
    final server = resources.servers
        .where((final server) => server.uuid == owner.origin.serverId)
        .firstOrNull;
    if (server == null) {
      throw const OperationNotSent();
    }
    final provider =
        createProvider?.call(credential) ??
        BackupsProviderFactory.createBackupsProviderInterface(
          BackupsProviderSettings(
            provider: BackupsProviderType.backblaze,
            tokenId: credential.keyId,
            token: credential.applicationKey,
            isAuthorized: true,
          ),
        );
    final domain = server.domain.domainName.replaceAll(
      RegExp('[^a-zA-Z0-9]'),
      '-',
    );
    final providerId = server.hostingDetails.providerId ?? 'manual';
    final name = '${DateTime.now().millisecondsSinceEpoch}-$providerId-$domain';
    final previous = resources.backblazeBucket;
    return InitializeBackupsOperation(
      repository: repository,
      provider: provider,
      bucketName: name.length > 49 ? name.substring(0, 49) : name,
      existingBucket: previous,
      saveBucket: (final bucket) async {
        if (!owner.isAttached ||
            !identical(resources.backblazeBucket, previous)) {
          throw const OperationNotSent();
        }
        await resources.setBackblazeBucket(bucket);
      },
    ).run();
  },
  showMessage: showMessage,
);

VolumesBloc createVolumesBloc(
  final ServerConnection connection, {
  required final Stream<void> providerChanges,
  required final ServerProvider? Function() serverProvider,
  required final void Function(String) showMessage,
}) => VolumesBloc(
  volumes: observeConnection(
    connection: connection,
    read: (final owner) => owner.volumes.value,
    changes: (final owner) => owner.volumes.changes,
  ),
  providerChanges: providerChanges,
  loadProviderVolumes: () async {
    if (!connection.isAttached) {
      throw const GraphQLDispatchDeferred();
    }
    final provider = serverProvider();
    if (provider == null || !provider.isAuthorized) {
      return [];
    }
    final result = await provider.getVolumes();
    if (!result.success) {
      throw Exception('Volume metadata unavailable');
    }
    return result.data;
  },
  loadPrice: (final location) async {
    if (!connection.isAttached) {
      throw const GraphQLDispatchDeferred();
    }
    final provider = serverProvider();
    if (provider == null || !provider.isAuthorized) {
      return null;
    }
    if (location == null) {
      throw Exception('Volume location unavailable');
    }
    final result = await provider.getAdditionalPricing(location);
    if (!result.success || result.data == null) {
      throw Exception('Volume pricing unavailable');
    }
    return result.data!.perVolumeGb;
  },
  resize: (final volume, final size, final onProgress) {
    if (connection.operations.pending.any(
      (final operation) => operation.kind == OperationKind.resizeVolume,
    )) {
      return Future.value(
        const OperationResult<ServerMutationResult<void>?>(
          OperationStatus.notSent,
        ),
      );
    }
    return connection.submit<ServerMutationResult<void>?>(
      OperationKind.resizeVolume,
      (final owner) {
        final provider = serverProvider();
        final providerVolume = volume.providerVolume;
        if (provider == null ||
            !provider.isAuthorized ||
            providerVolume == null) {
          throw const OperationNotSent();
        }
        return ResizeVolumeOperation(
          volumes: owner.volumes,
          provider: provider,
        ).resize(
          name: volume.name,
          providerVolume: providerVolume,
          size: size,
          onProgress: onProgress,
        );
      },
    ).result;
  },
  showMessage: showMessage,
);

DnsRecordsCubit createDnsRecordsCubit(
  final ServerConnection connection, {
  required final ResourcesModel resources,
  required final DnsProvider? Function() dnsProvider,
}) {
  DnsRecordsRepository? repository(
    final ServerConnection owner, {
    required final bool admitted,
  }) {
    final server = resources.servers
        .where((final server) => server.uuid == owner.origin.serverId)
        .firstOrNull;
    if (server == null) {
      return null;
    }
    return DnsRecordsRepository(
      api: owner.api,
      domain: server.domain,
      provider: dnsProvider(),
      canContinue: () => owner.isAttached && (admitted || connection.canRead),
    );
  }

  return DnsRecordsCubit(
    access: observeReadAccess(connection),
    read: () => connection.read(
      (final owner) async =>
          await repository(owner, admitted: false)?.read() ??
          GenericResult(success: false, data: []),
    ),
    repair: () => connection.run<GenericResult<List<DesiredDnsRecord>>?>(
      OperationKind.applyChanges,
      (final owner) {
        final bound = repository(owner, admitted: true);
        if (bound == null) {
          throw const OperationNotSent();
        }
        return bound.repair();
      },
    ),
  );
}

ServicesBloc createServicesBloc(
  final ServerConnection connection, {
  required final void Function(String) showMessage,
}) => ServicesBloc(
  services: observeConnection(
    connection: connection,
    read: (final connection) => connection.services.value,
    changes: (final connection) => connection.services.changes,
  ),
  refresh: () async {
    await connection.services.refresh(force: true);
  },
  restart: (final id) => connection.run(
    OperationKind.manageServices,
    (final owner) => owner.services.restart(id),
  ),
  move: (final destinations) => connection.run(
    OperationKind.moveServices,
    (final owner) => moveServices(owner.services, destinations),
  ),
  showMessage: showMessage,
);

ServerJobsBloc createServerJobsBloc(
  final ServerConnection connection, {
  required final void Function(String, {SnackBarBehavior? behavior})
  showMessage,
}) => ServerJobsBloc(
  jobs: observeConnection(
    connection: connection,
    read: (final connection) => connection.jobs.snapshot,
    changes: (final connection) => connection.jobs.changes,
  ),
  removeJob: (final uid) => connection.run(
    OperationKind.manageJobs,
    (final owner) => owner.jobs.removeJob(uid),
  ),
  removeFinished: () => connection.run(
    OperationKind.manageJobs,
    (final owner) => owner.jobs.removeAllFinished(),
  ),
  migrate: (final destinations) => connection.run(
    OperationKind.migrateVolumes,
    (final owner) => owner.jobs.migrateToBinds(destinations),
  ),
  showMessage: showMessage,
);

OperationsCubit createOperationsCubit(
  final ServerConnection connection, {
  required final void Function(String) showMessage,
}) => OperationsCubit(
  queue: connection.operations,
  remove: (final id) async =>
      await connection.run(
        OperationKind.manageJobs,
        (final owner) => removeOperationHistory(
          queue: owner.operations,
          jobs: owner.jobs,
          id: id,
          readJob: (final uid) => owner.api.getServerJob(uid),
        ),
      ) ??
      false,
  showMessage: showMessage,
);
