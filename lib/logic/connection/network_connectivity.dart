import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkConnectivity { unknown, available, offline }

abstract interface class NetworkConnectivitySource {
  Future<NetworkConnectivity> check();
  Stream<NetworkConnectivity> get changes;
}

class OsNetworkConnectivity implements NetworkConnectivitySource {
  OsNetworkConnectivity({final Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  static NetworkConnectivity _map(final List<ConnectivityResult> results) {
    if (results.isEmpty) {
      return NetworkConnectivity.unknown;
    }
    return results.any((final result) => result != ConnectivityResult.none)
        ? NetworkConnectivity.available
        : NetworkConnectivity.offline;
  }

  @override
  Future<NetworkConnectivity> check() async =>
      _map(await _connectivity.checkConnectivity());

  @override
  Stream<NetworkConnectivity> get changes =>
      _connectivity.onConnectivityChanged.map(_map);
}
