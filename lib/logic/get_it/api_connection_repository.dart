import 'dart:async';

import 'package:hive/hive.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

/// Repository for all API calls
/// Stores the current state of all data from API and exposes it to Blocs.
class ApiConnectionRepository {
  Box box = Hive.box(BNames.serverInstallationBox);
  final ServerApi api = ServerApi();

  final ApiData _apiData = ApiData();

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
      connectionStatus = ConnectionStatus.connected;
      _connectionStatusStream.add(connectionStatus);
      _apiData.apiVersion.data = apiVersion;
      _dataStream.add(_apiData);
    }

    _apiData.serverJobs.data = await api.getServerJobs();
    _dataStream.add(_apiData);

    // Use timer to periodically check for new jobs
    _timer = Timer.periodic(
      const Duration(seconds: 10),
      reload,
    );
  }

  void reload(final Timer timer) async {
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

    if (VersionConstraint.parse(_apiData.apiVersion.requiredApiVersion)
        .allows(Version.parse(apiVersion))) {
      final jobs = await api.getServerJobs();
      if (Object.hashAll(_apiData.serverJobs.data ?? []) !=
          Object.hashAll(jobs)) {
        _apiData.serverJobs.data = [...jobs];
        _dataStream.add(_apiData);
      }
    }
  }
}

class ApiData {
  ApiData()
      : serverJobs = ApiDataElement<List<ServerJob>>(null),
        apiVersion = ApiDataElement<String>(null);

  ApiDataElement<List<ServerJob>> serverJobs;
  ApiDataElement<String> apiVersion;
}

enum ConnectionStatus {
  nonexistent,
  connected,
  reconnecting,
  offline,
  unauthorized,
}

class ApiDataElement<T> {
  ApiDataElement(
    final T? data, {
    this.requiredApiVersion = '>=2.3.0',
    this.ttl = 60,
  })  : _data = data,
        _lastUpdated = DateTime.now();

  T? _data;
  final String requiredApiVersion;

  /// TTL of the data in seconds
  final int ttl;

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
