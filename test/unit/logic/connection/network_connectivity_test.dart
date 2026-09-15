import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/connection/network_connectivity.dart';

class _Connectivity extends Mock implements Connectivity {}

void main() {
  for (final entry in <List<ConnectivityResult>, NetworkConnectivity>{
    []: NetworkConnectivity.unknown,
    [ConnectivityResult.none]: NetworkConnectivity.offline,
    [ConnectivityResult.wifi]: NetworkConnectivity.available,
    [ConnectivityResult.mobile]: NetworkConnectivity.available,
    [ConnectivityResult.none, ConnectivityResult.ethernet]:
        NetworkConnectivity.available,
    [ConnectivityResult.vpn]: NetworkConnectivity.available,
  }.entries) {
    test('maps ${entry.key} in snapshots and events', () async {
      final plugin = _Connectivity();
      when(plugin.checkConnectivity).thenAnswer((_) async => entry.key);
      when(
        () => plugin.onConnectivityChanged,
      ).thenAnswer((_) => Stream.value(entry.key));
      final source = OsNetworkConnectivity(connectivity: plugin);
      expect(await source.check(), entry.value);
      expect(await source.changes.single, entry.value);
    });
  }
}
