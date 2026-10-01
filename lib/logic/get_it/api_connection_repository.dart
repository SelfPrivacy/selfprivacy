import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/lifecycle/reachability.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/connection/sync/operation_execution.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/connection/sync/secret_recipient.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

typedef ServerSelector = Server? Function();

/// Repository for all API calls
/// Stores the current state of all data from API and exposes it to Blocs.
class ApiConnectionRepository {
  ApiConnectionRepository({
    required final ResourcesModel resourcesModel,
    final ServerSelector? serverSelector,
    final ServerApi? api,
    final ServerConnectionHub? hub,
  }) : _serverSelector =
           serverSelector ?? (() => resourcesModel.servers.firstOrNull),
       _ownsHub = hub == null {
    this.hub =
        hub ??
        ServerConnectionHub(
          resourcesModel: resourcesModel,
          selectServer: _serverSelector,
          createApi: api == null ? null : (_, _, _) => api,
        );
    _apiData = ApiData(connection: () => connection);
    _domainSubscription = this.hub.changes.listen((_) {
      _syncStatus();
      emitData();
    });
  }

  final ServerSelector _serverSelector;
  final bool _ownsHub;
  late final ServerConnectionHub hub;
  late final StreamSubscription<void> _domainSubscription;
  ServerConnection? get connection => hub.admittedConnection;

  Future<T?> run<T>(
    final OperationKind kind,
    final Future<T> Function(ServerConnection) action,
  ) => hub.run(
    kind,
    action,
    onNotSent: () {
      if (getIt.isRegistered<NavigationService>()) {
        getIt<NavigationService>().showSnackBar(
          'server_mutation.not_sent'.tr(),
        );
      }
    },
  );

  CachedValue<List<ApiToken>> get devicesSnapshot =>
      hub.active?.devices.value ?? const CachedValue();
  Stream<CachedValue<List<ApiToken>>> get devicesStream =>
      hub.changes.map((_) => devicesSnapshot);

  Future<RefreshResult> refreshDevices() async =>
      await connection?.devices.refresh(force: true) ?? RefreshResult.disposed;

  Future<CommandCompletion<void>?> revokeDevice(final String name) =>
      run<CommandCompletion<void>?>(OperationKind.manageDevices, (
        final owner,
      ) async {
        final completion = await owner.devices.revoke(name);
        if (completion?.result case final result?) {
          OperationExecution.current?.record(result);
        }
        return completion;
      });

  ServerApi get api => connection!.api;
  late final ApiData _apiData;

  ApiData get apiData => _apiData;
  Server? get _server => _serverSelector();

  ConnectionStatus connectionStatus = ConnectionStatus.nonexistent;

  final _dataStream = StreamController<ApiData>.broadcast();
  final _connectionStatusStream =
      StreamController<ConnectionStatus>.broadcast();

  Stream<ApiData> get dataStream => _dataStream.stream;
  Stream<ConnectionStatus> get connectionStatusStream =>
      _connectionStatusStream.stream;

  ConnectionStatus get currentConnectionStatus => connectionStatus;

  Future<ServerMutationResult<void>> removeServerJob(final String uid) async =>
      await run(
        OperationKind.manageJobs,
        (final owner) => owner.jobs.removeJob(uid),
      ) ??
      _unavailable<void>();

  Future<Map<String, ServerMutationResult<void>>>
  removeAllFinishedServerJobs() async =>
      await run(
        OperationKind.manageJobs,
        (final owner) => owner.jobs.removeAllFinished(),
      ) ??
      const {};

  Future<(bool, String)> createUser(final User user) async => _userFeedback(
    await run(
      OperationKind.manageUsers,
      (final owner) => owner.users.createUser(user),
    ),
  );
  Future<(bool, String)> updateUser(final User user) async => _userFeedback(
    await run(
      OperationKind.manageUsers,
      (final owner) => owner.users.updateUser(user),
    ),
  );
  Future<(bool, String)> deleteUser(final User user) async => _feedback(
    await run(
      OperationKind.manageUsers,
      (final owner) => owner.users.deleteUser(user),
    ),
  );
  Future<(bool, String)> addSshKey(
    final User user,
    final String publicKey,
  ) async => _userFeedback(
    await run(
      OperationKind.manageUsers,
      (final owner) => owner.users.addSshKey(user, publicKey),
    ),
  );
  Future<(bool, String)> deleteSshKey(
    final User user,
    final String publicKey,
  ) async => _userFeedback(
    await run(
      OperationKind.manageUsers,
      (final owner) => owner.users.deleteSshKey(user, publicKey),
    ),
  );
  Future<(bool, String)> deleteEmailPassword(
    final User user,
    final String uuid,
  ) async => _feedback(
    await run(
      OperationKind.manageUsers,
      (final owner) => owner.users.deleteEmailPassword(user, uuid),
    ),
  );

  Future<(Uri?, String)> generatePasswordResetLink(
    final User user, {
    final SecretRecipient? recipient,
  }) async {
    final target = recipient ?? SecretRecipient();
    final result = await target.receive(
      hub.submit(
        OperationKind.generatePasswordResetLink,
        (final owner) =>
            target.protect(() => owner.users.generatePasswordResetLink(user)),
      ),
    );
    if (result == null) {
      return (null, 'server_mutation.not_sent'.tr());
    }
    final secret = result.confirmedSecret;
    if (secret == null) {
      return (null, serverMutationMessage(result, sensitive: true));
    }
    final uri = Uri.tryParse(secret);
    if (uri == null || uri.scheme.isEmpty) {
      return (null, 'users.could_not_generate_password_link'.tr());
    }
    return (uri, 'basis.done'.tr());
  }

  (bool, String) _userFeedback(final ServerMutationResult<User>? result) => (
    result?.outcome == ServerMutationOutcome.confirmed &&
        result?.payload.value != null,
    result == null
        ? 'server_mutation.not_sent'.tr()
        : serverMutationMessage(result).tr(),
  );

  (bool, String) _feedback<T>(
    final ServerMutationResult<T>? result, {
    final bool sensitive = false,
  }) => (
    result?.outcome == ServerMutationOutcome.confirmed,
    result == null
        ? 'server_mutation.not_sent'.tr()
        : serverMutationMessage(result, sensitive: sensitive).tr(),
  );

  ServerMutationResult<T> _unavailable<T>() => ServerMutationResult<T>(
    outcome: ServerMutationOutcome.indeterminate,
    payload: const ServerMutationPayload.notExpected(),
  );

  Future<(bool, String)> setAutoUpgradeSettings({
    required final bool enable,
    required final bool allowReboot,
  }) async => _feedback(
    await run(
      OperationKind.manageSettings,
      (final owner) => owner.settings.setAutoUpgradeSettings(
        enable: enable,
        allowReboot: allowReboot,
      ),
    ),
  );

  Future<(bool, String)> setServerTimezone(final String timezone) async =>
      _feedback(
        await run(
          OperationKind.manageSettings,
          (final owner) => owner.settings.setServerTimezone(timezone),
        ),
      );

  Future<(bool, String)> setSshSettings({required final bool enable}) async =>
      _feedback(
        await run(
          OperationKind.manageSettings,
          (final owner) => owner.settings.setSshSettings(enable: enable),
        ),
      );

  Future<(bool, String)> setServiceConfiguration(
    final String serviceId,
    final Map<String, dynamic> settings,
  ) async => _feedback(
    await run(
      OperationKind.manageServices,
      (final owner) => owner.services.setConfiguration(serviceId, settings),
    ),
    sensitive: true,
  );

  Future<(bool, String)> refreshDeviceToken() async {
    final outcome = await hub.rotateToken();
    return (
      outcome == RotationOutcome.succeeded,
      switch (outcome) {
        RotationOutcome.succeeded => 'basis.done'.tr(),
        RotationOutcome.rejected => 'server_mutation.rejected'.tr(),
        RotationOutcome.cancelled ||
        RotationOutcome.detached => 'server_mutation.not_sent'.tr(),
        _ => 'server_mutation.outcome_unknown'.tr(),
      },
    );
  }

  void dispose() {
    if (_ownsHub) {
      hub.dispose();
    }
    unawaited(_domainSubscription.cancel());
    unawaited(_dataStream.close());
    unawaited(_connectionStatusStream.close());
  }

  ServerHostingDetails? get serverDetails => _server?.hostingDetails;
  ServerDomain? get serverDomain => _server?.domain;

  void _setStatus(final ConnectionStatus status) {
    if (connectionStatus == status) {
      return;
    }
    connectionStatus = status;
    _connectionStatusStream.add(status);
  }

  void _syncStatus() {
    _setStatus(
      connection == null
          ? ConnectionStatus.nonexistent
          : switch (hub.reachability) {
              ReachabilityStatus.reachable => ConnectionStatus.connected,
              ReachabilityStatus.unauthorized => ConnectionStatus.unauthorized,
              ReachabilityStatus.serverUnreachable ||
              ReachabilityStatus.noLocalNetwork => ConnectionStatus.offline,
              _ => ConnectionStatus.reconnecting,
            },
    );
  }

  Future<void> init() async {
    hub
      ..resume()
      ..start();
    _syncStatus();
  }

  Future<void> clear() async {
    hub.clear();
    _syncStatus();
  }

  Future<void> reload(final Timer? timer) async {
    final owner = connection;
    if (owner == null) {
      return;
    }
    await Future.wait([for (final store in owner.stores) owner.refresh(store)]);
    _syncStatus();
  }

  Future<void> refreshGroups() async {
    final owner = connection;
    if (owner != null) {
      await owner.refresh(owner.cache.groups, force: true);
    }
  }

  Future<void> refreshRecoveryKeyStatus() async {
    final owner = connection;
    if (owner != null) {
      await owner.refresh(owner.cache.recoveryKeyStatus, force: true);
    }
  }

  void emitData() => _dataStream.add(_apiData);
}

class ApiData {
  ApiData({required final ServerConnection? Function() connection})
    : apiVersion = ApiDataView(() {
        final value = connection()?.cache.apiVersion.value;
        return CachedValue<String>(
          data: value?.data?.toString(),
          updatedAt: value?.updatedAt,
          freshness: value?.freshness ?? Freshness.stale,
          lastError: value?.lastError,
          needsReconciliation: value?.needsReconciliation ?? false,
        );
      }),
      serverJobs = ApiDataView(
        () => connection()?.jobs.value ?? const CachedValue(),
      ),
      backupConfig = ApiDataView(
        () => connection()?.backups.configValue ?? const CachedValue(),
      ),
      backups = ApiDataView(
        () => connection()?.backups.value ?? const CachedValue(),
      ),
      services = ApiDataView(
        () => connection()?.services.value ?? const CachedValue(),
      ),
      volumes = ApiDataView(() {
        final owner = connection();
        return owner?.snapshot(owner.volumesStore) ?? const CachedValue();
      }),
      recoveryKeyStatus = ApiDataView(
        () =>
            connection()?.cache.recoveryKeyStatus.value ?? const CachedValue(),
      ),
      users = ApiDataView(
        () => connection()?.users.value ?? const CachedValue(),
      ),
      groups = ApiDataView(
        () => connection()?.cache.groups.value ?? const CachedValue(),
      ),
      settings = ApiDataView(
        () => connection()?.settings.value ?? const CachedValue(),
      );

  final ApiDataView<List<ServerJob>> serverJobs;
  final ApiDataView<String> apiVersion;
  final ApiDataView<BackupConfiguration> backupConfig;
  final ApiDataView<List<Backup>> backups;
  final ApiDataView<List<Service>> services;
  final ApiDataView<List<ServerDiskVolume>> volumes;
  final ApiDataView<RecoveryKeyStatus> recoveryKeyStatus;
  final ApiDataView<List<User>> users;
  final ApiDataView<List<String>> groups;
  final ApiDataView<SystemSettings> settings;
}

class ApiDataView<T extends Object> {
  ApiDataView(this._snapshot);

  final CachedValue<T> Function() _snapshot;
  T? get data => _snapshot().data;
  Object? get lastError => _snapshot().lastError;
  DateTime? get lastUpdated => _snapshot().updatedAt;
  bool get isExpired =>
      _snapshot().freshness == Freshness.stale ||
      _snapshot().needsReconciliation;
}

enum ConnectionStatus {
  nonexistent,
  connected,
  reconnecting,
  offline,
  unauthorized,
}
