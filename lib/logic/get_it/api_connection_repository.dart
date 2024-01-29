import 'dart:async';

import 'package:hive/hive.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

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

    _apiData.serverJobs.data = await api.getServerJobs();
    _apiData.backupConfig.data = await api.getBackupsConfiguration();
    _apiData.backups.data = await api.getBackups();
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
        ),
        backups = ApiDataElement<List<Backup>>(
          fetchData: () async => api.getBackups(),
          requiredApiVersion: '>=2.4.2',
        );

  ApiDataElement<List<ServerJob>> serverJobs;
  ApiDataElement<String> apiVersion;
  ApiDataElement<BackupConfiguration> backupConfig;
  ApiDataElement<List<Backup>> backups;
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
      final Version version, final Function callback) async {
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
