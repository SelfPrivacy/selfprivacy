import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_ce/hive.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/email_password_metadata.dart';
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
import 'package:selfprivacy/utils/app_logger.dart';

/// Repository for all API calls
/// Stores the current state of all data from API and exposes it to Blocs.
class ApiConnectionRepository {
  static final _log = const AppLogger(name: 'api_connection_repository').log;

  Box box = Hive.box(BNames.serverInstallationBox);
  final ServerApi api = ServerApi();

  final ApiData _apiData = ApiData(ServerApi());

  ApiData get apiData => _apiData;

  ConnectionStatus connectionStatus = ConnectionStatus.nonexistent;

  final _dataStream = StreamController<ApiData>.broadcast();
  final _connectionStatusStream =
      StreamController<ConnectionStatus>.broadcast();

  Stream<ApiData> get dataStream => _dataStream.stream;
  Stream<ConnectionStatus> get connectionStatusStream =>
      _connectionStatusStream.stream;

  ConnectionStatus get currentConnectionStatus => connectionStatus;

  Timer? _timer;

  StreamSubscription<List<ServerJob>?>? _serverJobsStreamSubscription;
  DateTime? _jobsStreamDisconnectTime;

  Future<void> removeServerJob(final String uid) async {
    await api.removeApiJob(uid);
    _apiData.serverJobs.data?.removeWhere(
      (final ServerJob element) => element.uid == uid,
    );
    _dataStream.add(_apiData);
  }

  Future<void> removeAllFinishedServerJobs() async {
    final List<ServerJob> finishedJobs =
        _apiData.serverJobs.data
            ?.where(
              (final ServerJob element) =>
                  element.status == JobStatusEnum.finished ||
                  element.status == JobStatusEnum.error,
            )
            .toList() ??
        [];
    // Optimistically remove the jobs from the list
    _apiData.serverJobs.data?.removeWhere(
      (final ServerJob element) =>
          element.status == JobStatusEnum.finished ||
          element.status == JobStatusEnum.error,
    );
    _dataStream.add(_apiData);

    await Future.forEach<ServerJob>(
      finishedJobs,
      (final ServerJob job) => removeServerJob(job.uid),
    );
  }

  Future<(bool, String)> createUser(final User user) async {
    final List<User>? loadedUsers = _apiData.users.data;
    if (loadedUsers == null) {
      return (false, 'basis.network_error'.tr());
    }
    // If user exists on server, do nothing
    if (loadedUsers.any(
      (final User u) => u.login == user.login && u.isFoundOnServer,
    )) {
      return (false, 'users.user_already_exists'.tr());
    }

    // If API returned error, do nothing
    final GenericResult<User?> result = await api.createUser(
      user.login,
      user.displayName,
      user.directmemberof,
    );

    if (result.data == null) {
      return (false, result.message ?? 'users.could_not_create_user'.tr());
    }

    _apiData.users.data?.add(result.data!);
    _apiData.users.invalidate();

    return (true, result.message ?? 'basis.done'.tr());
  }

  Future<(bool, String)> updateUser(final User user) async {
    final List<User>? loadedUsers = _apiData.users.data;
    if (loadedUsers == null) {
      return (false, 'basis.network_error'.tr());
    }

    final GenericResult<User?> result = await api.updateUser(
      user.login,
      user.displayName,
      user.directmemberof,
    );

    if (result.data == null) {
      return (false, result.message ?? 'users.could_not_update_user');
    }

    // Update the user instance in the cache
    final int index = loadedUsers.indexWhere(
      (final User u) => u.login == user.login,
    );
    loadedUsers[index] = result.data!;
    _apiData.users.invalidate();

    return (true, result.message ?? 'basis.done'.tr());
  }

  Future<(bool, String)> deleteUser(final User user) async {
    final List<User>? loadedUsers = _apiData.users.data;
    if (loadedUsers == null) {
      return (false, 'basis.network_error'.tr());
    }
    // If user is root, don't delete
    if (user.type == UserType.root) {
      return (false, 'users.user_delete_protected'.tr());
    }
    final GenericResult result = await api.deleteUser(user.login);
    if (result.success && result.data) {
      _apiData.users.data?.removeWhere((final User u) => u.login == user.login);
      _apiData.users.invalidate();
    }

    if (!result.success || result.data == false) {
      return (false, result.message ?? 'jobs.generic_error'.tr());
    }

    return (true, result.message ?? 'basis.done'.tr());
  }

  // url and error message
  Future<(Uri?, String)> generatePasswordResetLink(final User user) async {
    String errorMessage = 'users.user_modify_protected'.tr();
    if (user.type == UserType.root) {
      return (null, errorMessage);
    }
    final GenericResult<String?> result = await api.generatePasswordResetLink(
      user.login,
    );

    // check if got valid url
    final uri = Uri.tryParse(result.data ?? '');
    if (uri == null || uri.scheme.isEmpty) {
      errorMessage =
          result.message ?? 'users.could_not_generate_password_link'.tr();
      return (null, errorMessage);
    }

    return (uri, result.message ?? 'basis.done'.tr());
  }

  Future<(bool, String)> deleteEmailPassword(
    final User user,
    final String uuid,
  ) async {
    final GenericResult<bool> result = await api.deleteEmailPassword(
      user.login,
      uuid,
    );
    if (result.success && result.data) {
      // Find a user and delete the email password with a given uuid
      final List<User>? loadedUsers = _apiData.users.data;
      if (loadedUsers != null) {
        final int index = loadedUsers.indexWhere(
          (final User u) => u.login == user.login,
        );
        if (index != -1) {
          final User updatedUser = loadedUsers[index].copyWith(
            emailPasswordMetadata: loadedUsers[index].emailPasswordMetadata
                ?.where(
                  (final EmailPasswordMetadata metadata) =>
                      metadata.uuid != uuid,
                )
                .toList(),
          );
          loadedUsers[index] = updatedUser;
        }
      }
      _apiData.users.invalidate();
      return (true, result.message ?? 'basis.done'.tr());
    } else {
      return (false, result.message ?? 'jobs.generic_error'.tr());
    }
  }

  Future<(bool, String)> addSshKey(
    final User user,
    final String publicKey,
  ) async {
    final List<User>? loadedUsers = _apiData.users.data;
    if (loadedUsers == null) {
      return (false, 'basis.network_error'.tr());
    }
    final GenericResult<User?> result = await api.addSshKey(
      user.login,
      publicKey,
    );
    if (result.data != null) {
      final User updatedUser = result.data!;
      final int index = loadedUsers.indexWhere(
        (final User u) => u.login == user.login,
      );
      loadedUsers[index] = updatedUser;
      _apiData.users.invalidate();
    } else {
      return (false, result.message ?? 'users.could_not_add_ssh_key'.tr());
    }

    return (true, result.message ?? 'basis.done'.tr());
  }

  Future<(bool, String)> deleteSshKey(
    final User user,
    final String publicKey,
  ) async {
    final List<User>? loadedUsers = _apiData.users.data;
    if (loadedUsers == null) {
      return (false, 'basis.network_error'.tr());
    }
    final GenericResult<User?> result = await api.removeSshKey(
      user.login,
      publicKey,
    );
    if (result.data != null) {
      final User updatedUser = result.data!;
      final int index = loadedUsers.indexWhere(
        (final User u) => u.login == user.login,
      );
      loadedUsers[index] = updatedUser;
      _apiData.users.invalidate();
    } else {
      return (false, result.message ?? 'jobs.generic_error'.tr());
    }
    return (true, result.message ?? 'basis.done'.tr());
  }

  Future<(bool, String)> setAutoUpgradeSettings({
    required final bool enable,
    required final bool allowReboot,
  }) async {
    final GenericResult<AutoUpgradeSettings?> result = await api
        .setAutoUpgradeSettings(
          AutoUpgradeSettings(enable: enable, allowReboot: allowReboot),
        );
    _apiData.settings.invalidate();
    if (result.data != null) {
      return (true, result.message ?? 'basis.done'.tr());
    } else {
      return (false, result.message ?? 'jobs.generic_error'.tr());
    }
  }

  Future<(bool, String)> setServerTimezone(final String timezone) async {
    final GenericResult result = await api.setTimezone(timezone);
    _apiData.settings.invalidate();
    if (result.success) {
      return (true, result.message ?? 'basis.done'.tr());
    } else {
      return (false, result.message ?? 'jobs.generic_error'.tr());
    }
  }

  Future<(bool, String)> setSshSettings({required final bool enable}) async {
    final GenericResult<SshSettings?> result = await api.setSshSettings(
      SshSettings(enable: enable),
    );
    _apiData.settings.invalidate();
    if (result.data != null) {
      return (true, result.message ?? 'basis.done'.tr());
    } else {
      return (false, result.message ?? 'jobs.generic_error'.tr());
    }
  }

  Future<(bool, String)> setServiceConfiguration(
    final String serviceId,
    final Map<String, dynamic> settings,
  ) async {
    final GenericResult result = await api.setServiceConfiguration(
      serviceId,
      settings,
    );
    _apiData.services.invalidate();
    if (result.success) {
      return (true, result.message ?? 'basis.done'.tr());
    } else {
      return (false, result.message ?? 'jobs.generic_error'.tr());
    }
  }

  // Single-flight guard. Manual refreshes from TokensBloc and automatic
  // rotations from `_rotateTokenIfNeeded` can arrive concurrently; without
  // this, the second rotation would invalidate the token issued by the first.
  Future<(bool, String)>? _rotationInFlight;

  /// Rotates the device API token and persists the new one.
  ///
  /// The server invalidates the old token the moment it issues the new one,
  /// so the new token must be persisted before any further requests are made.
  Future<(bool, String)> refreshDeviceToken() =>
      _rotationInFlight ??= _refreshDeviceTokenImpl().whenComplete(() {
        _rotationInFlight = null;
      });

  Future<(bool, String)> _refreshDeviceTokenImpl() async {
    final List<Server> servers = getIt<ResourcesModel>().servers;
    if (servers.isEmpty) {
      return (false, 'jobs.generic_error'.tr());
    }
    final Server server = servers.first;

    final GenericResult<String> result = await api.refreshDeviceApiToken();
    if (!result.success || result.data.isEmpty) {
      return (false, result.message ?? 'jobs.generic_error'.tr());
    }

    await getIt<ResourcesModel>().updateServerByDomain(
      Server(
        domain: server.domain,
        hostingDetails: server.hostingDetails.copyWith(
          apiToken: result.data,
          apiTokenRotatedAt: DateTime.now(),
        ),
      ),
    );
    _apiData.devices.invalidate();

    // The jobs websocket was authenticated with the old token; its reconnects
    // would fail auth, so re-establish it with the new one.
    final String? apiVersion = _apiData.apiVersion.data;
    if (apiVersion != null) {
      await _connectJobsStream(apiVersion);
    }

    return (true, result.message ?? 'basis.done'.tr());
  }

  static const Duration tokenRotationInterval = Duration(days: 30);
  static const Duration _tokenRotationRetryInterval = Duration(hours: 1);
  DateTime? _lastTokenRotationAttempt;

  /// Rotates the token if it is older than [tokenRotationInterval].
  ///
  /// A missing timestamp counts as overdue: it covers tokens created before
  /// rotation tracking existed and the install-time token, which is embedded
  /// in cloud-init userdata and visible to the hosting provider account.
  Future<void> _rotateTokenIfNeeded() async {
    if (connectionStatus != ConnectionStatus.connected) {
      return;
    }
    final DateTime now = DateTime.now();
    if (_lastTokenRotationAttempt != null &&
        now.difference(_lastTokenRotationAttempt!) <
            _tokenRotationRetryInterval) {
      return;
    }
    final DateTime? rotatedAt =
        getIt<ResourcesModel>().serverDetails?.apiTokenRotatedAt;
    if (rotatedAt != null &&
        now.difference(rotatedAt) < tokenRotationInterval) {
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

  ServerHostingDetails? get serverDetails =>
      getIt<ResourcesModel>().serverDetails;
  ServerDomain? get serverDomain => getIt<ResourcesModel>().serverDomain;

  void _setStatus(final ConnectionStatus status) {
    connectionStatus = status;
    _connectionStatusStream.add(status);
  }

  Future<void> init() async {
    if (getIt<ResourcesModel>().serverDetails == null) {
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

    late final StreamSubscription<List<ServerJob>?> subscription;
    void detach() {
      if (identical(_serverJobsStreamSubscription, subscription)) {
        _serverJobsStreamSubscription = null;
      }
      unawaited(subscription.cancel());
    }

    subscription = api
        .getServerJobsStream(onConnectionLost: _handleWebsocketDisconnect)
        .listen(
          (final List<ServerJob>? jobs) {
            if (jobs == null) {
              return;
            }
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
    if (getIt<ResourcesModel>().serverDetails == null) {
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
    _setStatus(ConnectionStatus.connected);

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
        fetchData: () async => (await api.getRecoveryTokenStatus()).data,
        ttl: 300,
      ),
      devices = ApiDataElement<List<ApiToken>>(
        fetchData: () async => (await api.getApiTokens()).data,
      ),
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
