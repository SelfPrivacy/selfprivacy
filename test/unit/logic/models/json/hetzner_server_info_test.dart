import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';

Map<String, dynamic> _server() => {
  'id': 156798764,
  'name': 'selfprivacy-ci-test',
  'status': 'initializing',
  'created': '2026-07-29T17:25:25Z',
  'server_type': {
    'name': 'cpx12',
    'description': 'CPX 12',
    'architecture': 'x86',
    'cores': 1,
    'memory': 2,
    'disk': 40,
    'prices': [
      {
        'location': 'fsn1',
        'price_hourly': {'gross': '0.0218960000000000', 'net': '0.0184'},
        'price_monthly': {'gross': '13.6731000000000000', 'net': '11.49'},
      },
    ],
    'locations': [
      {'name': 'fsn1', 'available': true, 'deprecation': null},
    ],
  },
  'location': {
    'id': 1,
    'name': 'fsn1',
    'description': 'Falkenstein DC Park 1',
    'city': 'Falkenstein',
    'country': 'DE',
    'network_zone': 'eu-central',
  },
  'public_net': {
    'ipv4': {
      'id': 142657427,
      'ip': '2.28.20.215',
      'blocked': false,
      'dns_ptr': 'static.215.20.28.2.clients.your-server.de',
    },
  },
  'volumes': <int>[],
};

void main() {
  test('reads the location Hetzner now puts on the server', () {
    final info = HetznerServerInfo.fromJson(_server());

    expect(info.location.name, 'fsn1');
    expect(info.location.zone, 'eu-central');
    expect(info.id, 156798764);
    expect(info.status, ServerStatus.initializing);
  });

  test('a server status Hetzner adds later does not break the parse', () {
    final info = HetznerServerInfo.fromJson(
      _server()..['status'] = 'suspended',
    );

    expect(info.status, ServerStatus.unknown);
  });

  test('a server with no volumes key parses', () {
    final json = _server()..remove('volumes');

    expect(HetznerServerInfo.fromJson(json).volumes, isEmpty);
  });
}
