import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';

/// Repository for all API calls
/// Stores the current state of all data from API and exposes it to Blocs.
class ApiConnectionRepository {
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

  Future<void> removeServerJob(final String uid) async {
    await api.removeApiJob(uid);
    _apiData.serverJobs.data
        ?.removeWhere((final ServerJob element) => element.uid == uid);
    _dataStream.add(_apiData);
  }

  Future<void> removeAllFinishedServerJobs() async {
    final List<ServerJob> finishedJobs = _apiData.serverJobs.data
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
      (final ServerJob job) async => removeServerJob(job.uid),
    );
  }

  Future<void> createUser(final User user) async {
    final List<User>? loadedUsers = _apiData.users.data;
    if (loadedUsers == null) {
      return;
    }
    // If user exists on server, do nothing
    if (loadedUsers
        .any((final User u) => u.login == user.login && u.isFoundOnServer)) {
      return;
    }
    final String? password = user.password;
    if (password == null) {
      getIt<NavigationService>()
          .showSnackBar('users.could_not_create_user'.tr());
      return;
    }
    // If API returned error, do nothing
    final GenericResult<User?> result =
        await api.createUser(user.login, password);
    if (result.data == null) {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'users.could_not_create_user'.tr());
      return;
    }

    _apiData.users.data?.add(result.data!);
    _apiData.users.invalidate();
  }

  Future<void> deleteUser(final User user) async {
    final List<User>? loadedUsers = _apiData.users.data;
    if (loadedUsers == null) {
      return;
    }
    // If user is primary or root, don't delete
    if (user.type != UserType.normal) {
      getIt<NavigationService>()
          .showSnackBar('users.could_not_delete_user'.tr());
      return;
    }
    final GenericResult result = await api.deleteUser(user.login);
    if (result.success && result.data) {
      _apiData.users.data?.removeWhere((final User u) => u.login == user.login);
      _apiData.users.invalidate();
    }

    if (!result.success || !result.data) {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'jobs.generic_error'.tr());
    }
  }

  Future<void> changeUserPassword(
    final User user,
    final String newPassword,
  ) async {
    if (user.type == UserType.root) {
      getIt<NavigationService>()
          .showSnackBar('users.could_not_change_password'.tr());
      return;
    }
    final GenericResult<User?> result = await api.updateUser(
      user.login,
      newPassword,
    );
    if (result.data == null) {
      getIt<NavigationService>().showSnackBar(
        result.message ?? 'users.could_not_change_password'.tr(),
      );
    }
  }

  Future<void> addSshKey(final User user, final String publicKey) async {
    final List<User>? loadedUsers = _apiData.users.data;
    if (loadedUsers == null) {
      return;
    }
    final GenericResult<User?> result =
        await api.addSshKey(user.login, publicKey);
    if (result.data != null) {
      final User updatedUser = result.data!;
      final int index =
          loadedUsers.indexWhere((final User u) => u.login == user.login);
      loadedUsers[index] = updatedUser;
      _apiData.users.invalidate();
    } else {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'users.could_not_add_ssh_key'.tr());
    }
  }

  Future<void> deleteSshKey(final User user, final String publicKey) async {
    final List<User>? loadedUsers = _apiData.users.data;
    if (loadedUsers == null) {
      return;
    }
    final GenericResult<User?> result =
        await api.removeSshKey(user.login, publicKey);
    if (result.data != null) {
      final User updatedUser = result.data!;
      final int index =
          loadedUsers.indexWhere((final User u) => u.login == user.login);
      loadedUsers[index] = updatedUser;
      _apiData.users.invalidate();
    } else {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'jobs.generic_error'.tr());
    }
  }

  void dispose() {
    _dataStream.close();
    _connectionStatusStream.close();
    _timer?.cancel();
  }

  ServerHostingDetails? get serverDetails =>
      getIt<ApiConfigModel>().serverDetails;
  ServerDomain? get serverDomain => getIt<ApiConfigModel>().serverDomain;

  void init() async {
    final serverDetails = getIt<ApiConfigModel>().serverDetails;
    final hasFinalChecked =
        box.get(BNames.hasFinalChecked, defaultValue: false);
    if (serverDetails == null || !hasFinalChecked) {
      return;
    }
    connectionStatus = ConnectionStatus.reconnecting;
    _connectionStatusStream.add(connectionStatus);

    final String? apiVersion = await api.getApiVersion();
    if (apiVersion == null) {
      connectionStatus = ConnectionStatus.offline;
      _connectionStatusStream.add(connectionStatus);
      return;
    } else {
      _apiData.apiVersion.data = apiVersion;
      _dataStream.add(_apiData);
    }

    _apiData.serverJobs.data = await _apiData.serverJobs.fetchData();
    _apiData.backupConfig.data = await _apiData.backupConfig.fetchData();
    _apiData.backups.data = await _apiData.backups.fetchData();
    _apiData.services.data = await _apiData.services.fetchData();
    _apiData.volumes.data = await _apiData.volumes.fetchData();
    _apiData.recoveryKeyStatus.data =
        await _apiData.recoveryKeyStatus.fetchData();
    _apiData.devices.data = await _apiData.devices.fetchData();
    _apiData.users.data = await _apiData.users.fetchData();
    _dataStream.add(_apiData);

    connectionStatus = ConnectionStatus.connected;
    _connectionStatusStream.add(connectionStatus);

    // Use timer to periodically check for new jobs
    _timer = Timer.periodic(
      const Duration(seconds: 10),
      reload,
    );
  }

  Future<void> reload(final Timer? timer) async {
    final serverDetails = getIt<ApiConfigModel>().serverDetails;
    if (serverDetails == null) {
      return;
    }

    final String? apiVersion = await api.getApiVersion();
    if (apiVersion == null) {
      connectionStatus = ConnectionStatus.offline;
      _connectionStatusStream.add(connectionStatus);
      return;
    } else {
      connectionStatus = ConnectionStatus.connected;
      _connectionStatusStream.add(connectionStatus);
      _apiData.apiVersion.data = apiVersion;
    }
    final Version version = Version.parse(apiVersion);
    await _apiData.serverJobs
        .refetchData(version, () => _dataStream.add(_apiData));
    await _apiData.backups
        .refetchData(version, () => _dataStream.add(_apiData));
    await _apiData.backupConfig
        .refetchData(version, () => _dataStream.add(_apiData));
    await _apiData.services
        .refetchData(version, () => _dataStream.add(_apiData));
    await _apiData.volumes
        .refetchData(version, () => _dataStream.add(_apiData));
    await _apiData.recoveryKeyStatus
        .refetchData(version, () => _dataStream.add(_apiData));
    await _apiData.devices
        .refetchData(version, () => _dataStream.add(_apiData));
    await _apiData.users.refetchData(version, () => _dataStream.add(_apiData));
  }

  void emitData() {
    _dataStream.add(_apiData);
  }
}

class ApiData {
  ApiData(final ServerApi api)
      : apiVersion = ApiDataElement<String>(
          fetchData: () async => api.getApiVersion(),
        ),
        serverJobs = ApiDataElement<List<ServerJob>>(
          fetchData: () async => api.getServerJobs(),
          ttl: 10,
        ),
        backupConfig = ApiDataElement<BackupConfiguration>(
          fetchData: () async => api.getBackupsConfiguration(),
          requiredApiVersion: '>=2.4.2',
          ttl: 120,
        ),
        backups = ApiDataElement<List<Backup>>(
          fetchData: () async => api.getBackups(),
          requiredApiVersion: '>=2.4.2',
          ttl: 120,
        ),
        services = ApiDataElement<List<Service>>(
          fetchData: () async => api.getAllServices(),
          requiredApiVersion: '>=2.4.3',
        ),
        volumes = ApiDataElement<List<ServerDiskVolume>>(
          fetchData: () async => api.getServerDiskVolumes(),
        ),
        recoveryKeyStatus = ApiDataElement<RecoveryKeyStatus>(
          fetchData: () async => (await api.getRecoveryTokenStatus()).data,
          ttl: 300,
        ),
        devices = ApiDataElement<List<ApiToken>>(
          fetchData: () async => (await api.getApiTokens()).data,
        ),
        users = ApiDataElement<List<User>>(
          fetchData: () async => api.getAllUsers(),
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
  })  : _data = data,
        _lastUpdated = DateTime.now();

  T? _data;
  final String requiredApiVersion;

  final Future<T?> Function() fetchData;

  Future<void> refetchData(
    final Version version,
    final Function callback,
  ) async {
    if (VersionConstraint.parse(requiredApiVersion).allows(version)) {
      print('Fetching data for $runtimeType');
      if (isExpired) {
        print('Data is expired');
        final newData = await fetchData();
        print(newData);
        if (T is List) {
          if (Object.hashAll(newData as Iterable<Object?>) !=
              Object.hashAll(_data as Iterable<Object?>)) {
            _data = [...newData] as T?;
          }
        } else {
          if (newData.hashCode != _data.hashCode) {
            _data = newData;
          }
        }
        callback();
      }
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
