import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_ce/hive.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
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
import 'package:selfprivacy/logic/models/ssh_settings.dart';
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
    _apiData = ApiData(this.api);
  }

  static final _log = const AppLogger(name: 'api_connection_repository').log;

  final ResourcesModel _resourcesModel;
  final ServerSelector _serverSelector;

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

  void applyServerJobMutation(final ServerMutationResult<ServerJob> result) {
    if (result.outcome != ServerMutationOutcome.confirmed) {
      return;
    }
    final job = result.payload.value;
    final jobs = _apiData.serverJobs;
    if (job == null) {
      jobs.invalidate();
    } else if (jobs.data == null) {
      jobs
        ..data = [job]
        ..invalidate();
    } else {
      final index = jobs.data!.indexWhere(
        (final existing) => existing.uid == job.uid,
      );
      if (index < 0) {
        jobs.data!.add(job);
      } else {
        jobs.data![index] = job;
      }
    }
    emitData();
  }

  Future<ServerMutationResult<void>> removeServerJob(final String uid) async {
    final result = await api.removeApiJob(uid);
    if (result.outcome == ServerMutationOutcome.confirmed) {
      _apiData.serverJobs.data?.removeWhere((final job) => job.uid == uid);
      emitData();
    }
    return result;
  }

  Future<Map<String, ServerMutationResult<void>>>
  removeAllFinishedServerJobs() async {
    final finishedJobs =
        _apiData.serverJobs.data
            ?.where(
              (final job) =>
                  job.status == JobStatusEnum.finished ||
                  job.status == JobStatusEnum.error,
            )
            .toList() ??
        [];
    return {
      for (final job in finishedJobs) job.uid: await removeServerJob(job.uid),
    };
  }

  Future<(bool, String)> createUser(final User user) async {
    final loadedUsers = _apiData.users.data;
    if (loadedUsers == null) {
      return (false, 'basis.network_error'.tr());
    }
    if (loadedUsers.any(
      (final u) => u.login == user.login && u.isFoundOnServer,
    )) {
      return (false, 'users.user_already_exists'.tr());
    }
    return _applyUserMutation(
      await api.createUser(user.login, user.displayName, user.directmemberof),
    );
  }

  Future<(bool, String)> updateUser(final User user) async {
    if (_apiData.users.data == null) {
      return (false, 'basis.network_error'.tr());
    }
    return _applyUserMutation(
      await api.updateUser(user.login, user.displayName, user.directmemberof),
    );
  }

  Future<(bool, String)> deleteUser(final User user) async {
    if (_apiData.users.data == null) {
      return (false, 'basis.network_error'.tr());
    }
    if (user.type == UserType.root) {
      return (false, 'users.user_delete_protected'.tr());
    }
    final result = await api.deleteUser(user.login);
    if (result.outcome == ServerMutationOutcome.confirmed) {
      _apiData.users.data?.removeWhere((final u) => u.login == user.login);
      emitData();
    }
    return (
      result.outcome == ServerMutationOutcome.confirmed,
      serverMutationMessage(result),
    );
  }

  // url and error message
  Future<(Uri?, String)> generatePasswordResetLink(final User user) async {
    String errorMessage = 'users.user_modify_protected'.tr();
    if (user.type == UserType.root) {
      return (null, errorMessage);
    }
    final result = await api.generatePasswordResetLink(user.login);

    final secret = result.confirmedSecret;
    if (secret == null) {
      return (null, serverMutationMessage(result, sensitive: true));
    }
    final uri = Uri.tryParse(secret);
    if (uri == null || uri.scheme.isEmpty) {
      errorMessage = 'users.could_not_generate_password_link'.tr();
      return (null, errorMessage);
    }

    return (uri, 'basis.done'.tr());
  }

  Future<(bool, String)> deleteEmailPassword(
    final User user,
    final String uuid,
  ) async {
    final result = await api.deleteEmailPassword(user.login, uuid);
    if (result.outcome == ServerMutationOutcome.confirmed) {
      final users = _apiData.users.data;
      final index = users?.indexWhere((final u) => u.login == user.login) ?? -1;
      if (users != null && index >= 0) {
        final current = users[index];
        users[index] = current.copyWith(
          emailPasswordMetadata: current.emailPasswordMetadata
              ?.where((final metadata) => metadata.uuid != uuid)
              .toList(),
        );
      } else {
        _apiData.users.invalidate();
      }
      emitData();
    }
    return (
      result.outcome == ServerMutationOutcome.confirmed,
      serverMutationMessage(result),
    );
  }

  Future<(bool, String)> addSshKey(
    final User user,
    final String publicKey,
  ) async {
    if (_apiData.users.data == null) {
      return (false, 'basis.network_error'.tr());
    }
    return _applyUserMutation(await api.addSshKey(user.login, publicKey));
  }

  Future<(bool, String)> deleteSshKey(
    final User user,
    final String publicKey,
  ) async {
    if (_apiData.users.data == null) {
      return (false, 'basis.network_error'.tr());
    }
    return _applyUserMutation(await api.removeSshKey(user.login, publicKey));
  }

  (bool, String) _applyUserMutation(final ServerMutationResult<User> result) {
    if (result.outcome != ServerMutationOutcome.confirmed) {
      return (false, serverMutationMessage(result));
    }
    final user = result.payload.value;
    if (user == null) {
      _apiData.users.invalidate();
      emitData();
      return (false, serverMutationMessage(result));
    }
    final users = _apiData.users.data;
    if (users == null) {
      _apiData.users.data = [user];
      _apiData.users.invalidate();
    } else {
      final index = users.indexWhere((final u) => u.login == user.login);
      if (index < 0) {
        users.add(user);
      } else {
        users[index] = user;
      }
    }
    emitData();
    return (true, serverMutationMessage(result));
  }

  (bool, String) _applySettingsMutation<T>(
    final ServerMutationResult<T> result,
    final SystemSettings Function(SystemSettings, T) apply,
  ) {
    if (result.outcome != ServerMutationOutcome.confirmed) {
      return (false, serverMutationMessage(result));
    }
    final value = result.payload.value;
    final current = _apiData.settings.data;
    if (value == null || current == null) {
      _apiData.settings.invalidate();
    } else {
      // A partial response does not renew the whole settings snapshot.
      _apiData.settings._data = apply(current, value);
    }
    emitData();
    return (true, serverMutationMessage(result));
  }

  Future<(bool, String)> setAutoUpgradeSettings({
    required final bool enable,
    required final bool allowReboot,
  }) async => _applySettingsMutation(
    await api.setAutoUpgradeSettings(
      AutoUpgradeSettings(enable: enable, allowReboot: allowReboot),
    ),
    (final current, final value) =>
        current.copyWith(autoUpgradeSettings: value),
  );

  Future<(bool, String)> setServerTimezone(final String timezone) async =>
      _applySettingsMutation(
        await api.setTimezone(timezone),
        (final current, final value) => current.copyWith(timezone: value),
      );

  Future<(bool, String)> setSshSettings({required final bool enable}) async =>
      _applySettingsMutation(
        await api.setSshSettings(SshSettings(enable: enable)),
        (final current, final value) => current.copyWith(sshSettings: value),
      );

  Future<(bool, String)> setServiceConfiguration(
    final String serviceId,
    final Map<String, dynamic> settings,
  ) async {
    final result = await api.setServiceConfiguration(serviceId, settings);
    if (result.outcome == ServerMutationOutcome.confirmed) {
      _apiData.services.invalidate();
      emitData();
    }
    return (
      result.outcome == ServerMutationOutcome.confirmed,
      serverMutationMessage(result, sensitive: true),
    );
  }

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
    _apiData.devices.invalidate();

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

    subscription = api
        .getServerJobsStream(onConnectionLost: _handleWebsocketDisconnect)
        .listen(
          (final List<ServerJob> jobs) {
            _apiData.serverJobs.data = jobs;
            _dataStream.add(_apiData);
            _jobsStreamDisconnectTime = null;
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

  Future<void> _refetchEverything(final Version version) async {
    await Future.wait([
      if (_isForceServerJobsRefetchRequired())
        _apiData.serverJobs.refetchData(
          version,
          () => _dataStream.add(_apiData),
        ),
      _apiData.services.refetchData(version, () => _dataStream.add(_apiData)),
      _apiData.users.refetchData(version, () => _dataStream.add(_apiData)),
      _apiData.groups.refetchData(version, () => _dataStream.add(_apiData)),
      _apiData.volumes.refetchData(version, () => _dataStream.add(_apiData)),
      _apiData.settings.refetchData(version, () => _dataStream.add(_apiData)),
      _apiData.recoveryKeyStatus.refetchData(
        version,
        () => _dataStream.add(_apiData),
      ),
      _apiData.devices.refetchData(version, () => _dataStream.add(_apiData)),
      _apiData.backupConfig.refetchData(
        version,
        () => _dataStream.add(_apiData),
      ),
      _apiData.backups.refetchData(version, () => _dataStream.add(_apiData)),
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

    final String? apiVersion = await api.getApiVersion();
    if (apiVersion == null) {
      _setStatus(ConnectionStatus.offline);
      return;
    }

    _apiData.apiVersion.data = apiVersion;
    final Version version = Version.parse(apiVersion);
    // Reconnecting an already-live stream would open a new websocket every
    // reload; socket-level drops are handled by the client's autoReconnect.
    if (_serverJobsStreamSubscription == null) {
      await _connectJobsStream(apiVersion);
    }
    await _refetchEverything(version);
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
  ApiData(final ServerApi api)
    : apiVersion = ApiDataElement<String>(fetchData: api.getApiVersion),
      serverJobs = ApiDataElement<List<ServerJob>>(
        fetchData: api.getServerJobs,
        ttl: 10,
      ),
      backupConfig = ApiDataElement<BackupConfiguration>(
        fetchData: api.getBackupsConfiguration,
        requiredApiVersion: '>=2.4.2',
        ttl: 120,
      ),
      backups = ApiDataElement<List<Backup>>(
        fetchData: api.getBackups,
        requiredApiVersion: '>=2.4.2',
        ttl: 120,
      ),
      services = ApiDataElement<List<Service>>(
        fetchData: api.getAllServices,
        requiredApiVersion: '>=2.4.3',
      ),
      volumes = ApiDataElement<List<ServerDiskVolume>>(
        fetchData: api.getServerDiskVolumes,
      ),
      recoveryKeyStatus = ApiDataElement<RecoveryKeyStatus>(
        fetchData: api.getRecoveryTokenStatus,
        ttl: 300,
      ),
      devices = ApiDataElement<List<ApiToken>>(fetchData: api.getApiTokens),
      users = ApiDataElement<List<User>>(fetchData: api.getAllUsers),
      groups = ApiDataElement<List<String>>(
        fetchData: api.getAllGroups,
        requiredApiVersion: '>=3.6.0',
      ),
      settings = ApiDataElement<SystemSettings>(
        fetchData: api.getSystemSettings,
        ttl: 600,
      );

  ApiDataElement<List<ServerJob>> serverJobs;
  ApiDataElement<String> apiVersion;
  ApiDataElement<BackupConfiguration> backupConfig;
  ApiDataElement<List<Backup>> backups;
  ApiDataElement<List<Service>> services;
  ApiDataElement<List<ServerDiskVolume>> volumes;
  ApiDataElement<RecoveryKeyStatus> recoveryKeyStatus;
  ApiDataElement<List<ApiToken>> devices;
  ApiDataElement<List<User>> users;
  ApiDataElement<List<String>> groups;
  ApiDataElement<SystemSettings> settings;
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
