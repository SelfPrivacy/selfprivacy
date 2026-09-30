import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_ce/hive.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/server_connection_scope.dart';
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
import 'package:selfprivacy/logic/models/token_renewal_schedule.dart';
import 'package:selfprivacy/utils/app_logger.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

typedef ServerSelector = Server? Function();

/// Repository for all API calls
/// Stores the current state of all data from API and exposes it to Blocs.
class ApiConnectionRepository {
  ApiConnectionRepository({
    required final ResourcesModel resourcesModel,
    final ServerSelector? serverSelector,
    final ServerApi? api,
  }) : _resourcesModel = resourcesModel,
       _serverSelector =
           serverSelector ?? (() => resourcesModel.servers.firstOrNull) {
    this.api =
        api ??
        ServerApi(
          transport: createGraphQLTransport(
            domainProvider: () => _server?.domain.domainName,
            tokenProvider: () => _server?.hostingDetails.apiToken,
            onAuthFailure: _handleAuthFailure,
          ),
        );
    _connections = ServerConnectionScope(
      selectServer: _serverSelector,
      serverChanges: resourcesModel.statusStream,
      createApi: (final binding, final onAuthFailure) =>
          api ??
          ServerApi(
            transport: createGraphQLTransport(
              domainProvider: () => binding.domain,
              tokenProvider: () => binding.token,
              onAuthFailure: onAuthFailure,
            ),
          ),
      onAuthFailure: _handleAuthFailure,
    );
    _apiData = ApiData(this.api, connection: () => connection);
    _domainSubscription = _connections.changes.listen((_) => emitData());
  }

  static final _log = const AppLogger(name: 'api_connection_repository').log;

  final ResourcesModel _resourcesModel;
  final ServerSelector _serverSelector;
  late final ServerConnectionScope _connections;
  late final StreamSubscription<void> _domainSubscription;
  ServerConnection? get connection => _connections.current;

  CachedValue<List<ApiToken>> get devicesSnapshot =>
      _connections.current?.devices.value ?? const CachedValue();
  Stream<CachedValue<List<ApiToken>>> get devicesStream =>
      _connections.changes.map((_) => devicesSnapshot);

  Future<RefreshResult> refreshDevices() async {
    final rotation = _rotationInFlight;
    if (rotation != null) {
      await rotation;
    }
    return _connections.current?.devices.refresh(force: true) ??
        RefreshResult.disposed;
  }

  Future<CommandCompletion<void>?> revokeDevice(final String name) =>
      _connections.current?.devices.revoke(name) ?? Future.value();

  Box box = Hive.box(BNames.serverInstallationBox);
  late final ServerApi api;
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

  Timer? _timer;

  StreamSubscription<List<ServerJob>>? _serverJobsStreamSubscription;
  DateTime? _jobsStreamDisconnectTime;

  Future<ServerMutationResult<void>> removeServerJob(final String uid) async =>
      await connection?.jobs.removeJob(uid) ?? _unavailable<void>();

  Future<Map<String, ServerMutationResult<void>>>
  removeAllFinishedServerJobs() async =>
      await connection?.jobs.removeAllFinished() ?? const {};

  Future<(bool, String)> createUser(final User user) async =>
      _userFeedback(await connection?.users.createUser(user));
  Future<(bool, String)> updateUser(final User user) async =>
      _userFeedback(await connection?.users.updateUser(user));
  Future<(bool, String)> deleteUser(final User user) async =>
      _feedback(await connection?.users.deleteUser(user));
  Future<(bool, String)> addSshKey(
    final User user,
    final String publicKey,
  ) async => _userFeedback(await connection?.users.addSshKey(user, publicKey));
  Future<(bool, String)> deleteSshKey(
    final User user,
    final String publicKey,
  ) async =>
      _userFeedback(await connection?.users.deleteSshKey(user, publicKey));
  Future<(bool, String)> deleteEmailPassword(
    final User user,
    final String uuid,
  ) async => _feedback(await connection?.users.deleteEmailPassword(user, uuid));

  Future<(Uri?, String)> generatePasswordResetLink(final User user) async {
    final result =
        await connection?.users.generatePasswordResetLink(user) ??
        _unavailable<String>();
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
    serverMutationMessage(result ?? _unavailable<User>()).tr(),
  );

  (bool, String) _feedback<T>(
    final ServerMutationResult<T>? result, {
    final bool sensitive = false,
  }) => (
    result?.outcome == ServerMutationOutcome.confirmed,
    serverMutationMessage(
      result ?? _unavailable<T>(),
      sensitive: sensitive,
    ).tr(),
  );

  ServerMutationResult<T> _unavailable<T>() => ServerMutationResult<T>(
    outcome: ServerMutationOutcome.indeterminate,
    payload: const ServerMutationPayload.notExpected(),
  );

  Future<(bool, String)> setAutoUpgradeSettings({
    required final bool enable,
    required final bool allowReboot,
  }) async => _feedback(
    await connection?.settings.setAutoUpgradeSettings(
      enable: enable,
      allowReboot: allowReboot,
    ),
  );

  Future<(bool, String)> setServerTimezone(final String timezone) async =>
      _feedback(await connection?.settings.setServerTimezone(timezone));

  Future<(bool, String)> setSshSettings({required final bool enable}) async =>
      _feedback(await connection?.settings.setSshSettings(enable: enable));

  Future<(bool, String)> setServiceConfiguration(
    final String serviceId,
    final Map<String, dynamic> settings,
  ) async => _feedback(
    await connection?.services.setConfiguration(serviceId, settings),
    sensitive: true,
  );

  // Single-flight guard. Manual refreshes from TokensBloc and automatic
  // rotations from `_rotateTokenIfNeeded` can arrive concurrently; without
  // this, the second rotation would invalidate the token issued by the first.
  Future<(bool, String)>? _rotationInFlight;
  final Map<String, Set<String?>> _rotationSuppressedFor = {};
  (String, String?)? _lastRotationCredential;

  /// Rotates the device API token and persists the new one.
  ///
  /// The server invalidates the old token the moment it issues the new one,
  /// so the new token must be persisted before any further requests are made.
  Future<(bool, String)> refreshDeviceToken() =>
      _rotationInFlight ??= _refreshDeviceTokenImpl().whenComplete(() {
        _rotationInFlight = null;
      });

  Future<(bool, String)> _refreshDeviceTokenImpl() async {
    final server = _server;
    if (server == null) {
      return (false, 'jobs.generic_error'.tr());
    }

    final credential = server.hostingDetails.apiToken;
    final result = await api.refreshDeviceApiToken();
    final replacement = result.confirmedSecret;
    if (replacement == null) {
      if (result.outcome != ServerMutationOutcome.rejected) {
        _rotationSuppressedFor[server.uuid] = {credential};
      }
      return (false, serverMutationMessage(result, sensitive: true));
    }

    final current = _resourcesModel.servers.firstWhereOrNull(
      (final candidate) => candidate.uuid == server.uuid,
    );
    if (current == null || current.hostingDetails.apiToken != credential) {
      return (false, 'server_mutation.outcome_unknown'.tr());
    }
    try {
      await _resourcesModel.updateServerByUuid(
        Server(
          uuid: current.uuid,
          domain: current.domain,
          hostingDetails: current.hostingDetails.copyWith(
            apiToken: replacement,
            apiTokenRotatedAt: DateTime.now(),
          ),
        ),
      );
    } catch (_) {
      _rotationSuppressedFor[server.uuid] = {credential, replacement};
      return (false, 'server_mutation.outcome_unknown'.tr());
    }
    _rotationSuppressedFor.remove(server.uuid);
    if (_server?.uuid != server.uuid) {
      return (true, 'basis.done'.tr());
    }
    _connections.current?.devices.invalidate();

    // The jobs websocket was authenticated with the old token; its reconnects
    // would fail auth, so re-establish it with the new one.
    final String? apiVersion = _apiData.apiVersion.data;
    if (apiVersion != null) {
      await _connectJobsStream(apiVersion);
    }

    return (true, 'basis.done'.tr());
  }

  static const Duration _tokenRotationRetryInterval = Duration(hours: 1);
  DateTime? _lastTokenRotationAttempt;

  /// Rotates the token if it is older than [TokenRenewalSchedule.interval].
  ///
  /// A missing timestamp counts as overdue: it covers tokens created before
  /// rotation tracking existed and the install-time token, which is embedded
  /// in cloud-init userdata and visible to the hosting provider account.
  Future<void> _rotateTokenIfNeeded() async {
    if (connectionStatus != ConnectionStatus.connected) {
      return;
    }
    final DateTime now = DateTime.now();
    final server = _server;
    if (server == null) {
      return;
    }
    final details = server.hostingDetails;
    final credential = (server.uuid, details.apiToken);
    if (_lastRotationCredential != credential) {
      _lastRotationCredential = credential;
      _lastTokenRotationAttempt = null;
    }
    if (_rotationSuppressedFor.containsKey(server.uuid)) {
      if (_rotationSuppressedFor[server.uuid]!.contains(details.apiToken)) {
        return;
      }
      _rotationSuppressedFor.remove(server.uuid);
    }
    final schedule = TokenRenewalSchedule.fromToken(
      token: details.apiToken,
      rotatedAt: details.apiTokenRotatedAt,
    );
    if (!schedule.shouldRefreshAutomatically(
      enabled: getIt<DeveloperSettingsModel>().automaticGraphqlTokenRefresh,
      now: now,
    )) {
      return;
    }
    if (_lastTokenRotationAttempt != null &&
        now.difference(_lastTokenRotationAttempt!) <
            _tokenRotationRetryInterval) {
      return;
    }
    _lastTokenRotationAttempt = now;
    final (bool success, String message) = await refreshDeviceToken();
    if (!success) {
      _log('Automatic token rotation failed: $message');
    }
  }

  void dispose() {
    _connections.dispose();
    unawaited(_domainSubscription.cancel());
    unawaited(_serverJobsStreamSubscription?.cancel());
    unawaited(_dataStream.close());
    unawaited(_connectionStatusStream.close());
    _timer?.cancel();
  }

  ServerHostingDetails? get serverDetails => _server?.hostingDetails;
  ServerDomain? get serverDomain => _server?.domain;

  void _setStatus(final ConnectionStatus status) {
    connectionStatus = status;
    _connectionStatusStream.add(status);
  }

  void _handleAuthFailure() {
    if (connectionStatus != ConnectionStatus.unauthorized) {
      _setStatus(ConnectionStatus.unauthorized);
    }
  }

  Future<void> init() async {
    _connections.resume();
    if (_server == null) {
      return;
    }
    _setStatus(ConnectionStatus.reconnecting);

    await reload(null);

    // The timer is armed even if the first reload found the server
    // unreachable, so a cold start while offline recovers once connectivity
    // returns.
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), reload);
  }

  Future<void> _connectJobsStream(final String apiVersion) async {
    final previous = _serverJobsStreamSubscription;
    _serverJobsStreamSubscription = null;
    await previous?.cancel();

    if (!VersionConstraint.parse(
      wsJobsUpdatesSupportedVersion,
    ).allows(Version.parse(apiVersion))) {
      return;
    }

    late final StreamSubscription<List<ServerJob>> subscription;
    void detach() {
      if (identical(_serverJobsStreamSubscription, subscription)) {
        _serverJobsStreamSubscription = null;
      }
      unawaited(subscription.cancel());
    }

    final owner = connection;
    if (owner == null || !owner.isAttached) {
      return;
    }
    subscription = owner.api
        .getServerJobsStream(onConnectionLost: _handleWebsocketDisconnect)
        .listen(
          (final List<ServerJob> jobs) {
            if (owner.isAttached) {
              owner.jobs.receiveSnapshot(jobs);
              _jobsStreamDisconnectTime = null;
            } else {
              detach();
            }
          },
          onError: (final Object error, final StackTrace stack) {
            _log(
              'Server jobs stream error: $error',
              error: error,
              stackTrace: stack,
            );
            detach();
          },
          onDone: detach,
        );
    _serverJobsStreamSubscription = subscription;
  }

  Future<void> clear() async {
    _connections.clear();
    _setStatus(ConnectionStatus.nonexistent);
    _timer?.cancel();
    final previous = _serverJobsStreamSubscription;
    _serverJobsStreamSubscription = null;
    await previous?.cancel();
  }

  static const String wsJobsUpdatesSupportedVersion = '>=3.3.0';

  bool _isForceServerJobsRefetchRequired() {
    if (_serverJobsStreamSubscription == null) {
      return true;
    }
    return _apiData.serverJobs.data == null ||
        (_jobsStreamDisconnectTime != null &&
            DateTime.now().difference(_jobsStreamDisconnectTime!) <
                const Duration(seconds: 120));
  }

  Future<Duration?>? _handleWebsocketDisconnect(
    final int? code,
    final String? reason,
  ) {
    _jobsStreamDisconnectTime = DateTime.now();
    return null;
  }

  Future<void> _refetchEverything(
    final Version version,
    final ServerConnection? connection,
  ) async {
    await Future.wait([
      if (connection != null && connection.isAttached)
        for (final store in connection.stores)
          if (store != connection.jobs.store ||
              _isForceServerJobsRefetchRequired())
            connection.refresh(store),
      _apiData.groups.refetchData(version, emitData),
      _apiData.recoveryKeyStatus.refetchData(version, emitData),
    ]);
  }

  Future<void> reload(final Timer? timer) async {
    if (_server == null) {
      return;
    }

    // If a rotation is in flight, the old token is about to be invalidated;
    // wait for the new one to land before sending requests.
    final inflight = _rotationInFlight;
    if (inflight != null) {
      try {
        await inflight;
      } catch (_) {
        // Surfaced to the rotation's caller; reload continues with whatever
        // token is now persisted.
      }
    }

    final connection = _connections.current;
    final String? apiVersion = await api.getApiVersion();
    if (apiVersion == null) {
      connection?.versionUnavailable();
      _setStatus(ConnectionStatus.offline);
      return;
    }

    _apiData.apiVersion.data = apiVersion;
    final Version version = Version.parse(apiVersion);
    connection?.setVersion(version);
    // Reconnecting an already-live stream would open a new websocket every
    // reload; socket-level drops are handled by the client's autoReconnect.
    if (_serverJobsStreamSubscription == null) {
      await _connectJobsStream(apiVersion);
    }
    await _refetchEverything(version, connection);
    if (connectionStatus != ConnectionStatus.unauthorized) {
      _setStatus(ConnectionStatus.connected);
    }

    // After the refetch so the rotation doesn't invalidate the token under
    // requests already in flight.
    unawaited(_rotateTokenIfNeeded());
  }

  void emitData() {
    _dataStream.add(_apiData);
  }
}

class ApiData {
  ApiData(
    final ServerApi api, {
    required final ServerConnection? Function() connection,
  }) : apiVersion = ApiDataElement<String>(fetchData: api.getApiVersion),
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
       recoveryKeyStatus = ApiDataElement<RecoveryKeyStatus>(
         fetchData: api.getRecoveryTokenStatus,
         ttl: 300,
       ),
       users = ApiDataView(
         () => connection()?.users.value ?? const CachedValue(),
       ),
       groups = ApiDataElement<List<String>>(
         fetchData: api.getAllGroups,
         requiredApiVersion: '>=3.6.0',
       ),
       settings = ApiDataView(
         () => connection()?.settings.value ?? const CachedValue(),
       );

  final ApiDataView<List<ServerJob>> serverJobs;
  final ApiDataElement<String> apiVersion;
  final ApiDataView<BackupConfiguration> backupConfig;
  final ApiDataView<List<Backup>> backups;
  final ApiDataView<List<Service>> services;
  final ApiDataView<List<ServerDiskVolume>> volumes;
  final ApiDataElement<RecoveryKeyStatus> recoveryKeyStatus;
  final ApiDataView<List<User>> users;
  final ApiDataElement<List<String>> groups;
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

class ApiDataElement<T> {
  ApiDataElement({
    required this.fetchData,
    final T? data,
    this.requiredApiVersion = '>=2.3.0',
    this.ttl = 60,
  }) : _data = data,
       _lastUpdated = DateTime.now();

  T? _data;
  final String requiredApiVersion;
  Object? lastError;
  DateTime? lastErrorAt;

  final Future<T?> Function() fetchData;

  Future<void> refetchData(
    final Version version,
    final Function() callback,
  ) async {
    if (!VersionConstraint.parse(requiredApiVersion).allows(version)) {
      return;
    }
    if (!isExpired && _data != null) {
      return;
    }

    final T? newData;
    try {
      newData = await fetchData();
    } catch (error) {
      lastError = error;
      lastErrorAt = DateTime.now();
      callback();
      return;
    }

    if (newData == null) {
      lastError ??= const StaleDataError();
      lastErrorAt ??= DateTime.now();
      callback();
      return;
    }

    lastError = null;
    lastErrorAt = null;

    if (!const DeepCollectionEquality().equals(newData, _data)) {
      data = newData;
      callback();
    } else {
      _lastUpdated = DateTime.now();
    }
  }

  /// TTL of the data in seconds
  final int ttl;

  Type get type => T;

  void invalidate() {
    _lastUpdated = DateTime.fromMillisecondsSinceEpoch(0);
  }

  /// Timestamp of when the data was last updated
  DateTime _lastUpdated;

  bool get isExpired {
    final now = DateTime.now();
    final difference = now.difference(_lastUpdated);
    return difference.inSeconds > ttl;
  }

  T? get data => _data;

  /// Sets the data and updates the lastUpdated timestamp
  set data(final T? data) {
    _data = data;
    _lastUpdated = DateTime.now();
  }

  /// Returns the last time the data was updated
  DateTime get lastUpdated => _lastUpdated;
}

class StaleDataError implements Exception {
  const StaleDataError();
}
