import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';

import '../../../helpers/fixtures/json_fixture.dart';

Map<String, dynamic> _volume(final Object? assignee) =>
    loadJsonFixtureItem('server_providers/hetzner/volumes.json', 'volumes')
      ..remove('server')
      ..['assignee'] = assignee;

void main() {
  group('Hetzner volume assignee', () {
    test('reads the server ID without the deprecated server field', () {
      expect(
        HetznerVolume.fromJson(_volume({'id': 7, 'type': 'server'})).serverId,
        7,
      );
    });

    test('accepts an explicitly unassigned volume', () {
      expect(HetznerVolume.fromJson(_volume(null)).serverId, isNull);
    });

    test('prefers assignee over the deprecated server field', () {
      final json = _volume({'id': 7, 'type': 'server'})..['server'] = 99;
      expect(HetznerVolume.fromJson(json).serverId, 7);
    });

    test('does not resurrect a stale server for an explicit null assignee', () {
      final json = _volume(null)..['server'] = 99;
      expect(HetznerVolume.fromJson(json).serverId, isNull);
    });

    test('still reads older responses with only the server field', () {
      final json = _volume(null)
        ..remove('assignee')
        ..['server'] = 7;
      expect(HetznerVolume.fromJson(json).serverId, 7);
      json['server'] = null;
      expect(HetznerVolume.fromJson(json).serverId, isNull);
    });

    test('rejects a response with neither attachment field', () {
      final json = _volume(null)..remove('assignee');
      expect(() => HetznerVolume.fromJson(json), throwsFormatException);
    });

    test('does not use legacy server when assignee is unsupported', () {
      final json = _volume({'id': 7, 'type': 'future-resource'})
        ..['server'] = 99;
      expect(() => HetznerVolume.fromJson(json), throwsFormatException);
    });

    for (final assignee in <Object>[
      {'id': 7, 'type': 'future-resource'},
      {'id': 7},
      {'type': 'server'},
      {'id': '7', 'type': 'server'},
      {'id': 7.5, 'type': 'server'},
      {'id': 0, 'type': 'server'},
      {'id': -1, 'type': 'server'},
      {'id': 9007199254740992, 'type': 'server'},
      7,
    ]) {
      test('rejects unsupported or malformed assignee $assignee', () {
        expect(
          () => HetznerVolume.fromJson(_volume(assignee)),
          throwsFormatException,
        );
      });
    }
  });

  group('Hetzner volume endpoints', () {
    setUp(() => getIt.registerSingleton<ConsoleModel>(ConsoleModel()));
    tearDown(getIt.reset);

    late List<RequestOptions> requests;
    late HetznerApi api;
    late Object? responseAssignee;

    setUp(() {
      requests = [];
      responseAssignee = {'id': 7, 'type': 'server'};
      api = HetznerApi(
        token: 'test-token',
        clientFactory: (final options) => Dio(options)
          ..interceptors.add(
            InterceptorsWrapper(
              onRequest: (final request, final handler) {
                requests.add(request);
                final Object data;
                switch ((request.method, request.path)) {
                  case ('GET', '/volumes'):
                    data = {
                      'volumes': [_volume(responseAssignee)],
                    };
                  case ('GET', '/volumes/41'):
                  case ('POST', '/volumes'):
                    data = {'volume': _volume(responseAssignee)};
                  case ('POST', '/volumes/41/actions/attach'):
                    data = {
                      'action': {'status': 'running'},
                    };
                  default:
                    throw StateError('Unexpected request: ${request.uri}');
                }
                handler.resolve(
                  Response<dynamic>(
                    requestOptions: request,
                    statusCode: request.method == 'POST' ? 201 : 200,
                    data: data,
                  ),
                );
              },
            ),
          ),
      );
    });

    test(
      'lists and retrieves server assignments from the new response',
      () async {
        final list = await api.getVolumes();
        final detail = await api.getVolume('41');
        expect(list.success, isTrue);
        expect(list.data.single.serverId, 7);
        expect(detail.success, isTrue);
        expect(detail.data?.serverId, 7);
      },
    );

    test(
      'creates an unattached volume without deprecated request fields',
      () async {
        responseAssignee = null;
        final result = await api.createVolume(gb: 10, region: 'fsn1');
        expect(result.success, isTrue);
        expect(result.data?.serverId, isNull);
        expect(result.resourceId, '41');
        final body = requests.single.data as Map<String, dynamic>;
        expect(body.containsKey('server'), isFalse);
        expect(body.containsKey('assignee'), isFalse);
        expect(body['location'], 'fsn1');
      },
    );

    test(
      'preserves created resource identity if its assignee is invalid',
      () async {
        responseAssignee = {'id': 7, 'type': 'future-resource'};
        final result = await api.createVolume(gb: 10, region: 'fsn1');
        expect(result.success, isFalse);
        expect(result.wasCreated, isTrue);
        expect(result.resourceId, '41');
        expect(result.data, isNull);
      },
    );

    test('attaches using a typed assignee instead of server', () async {
      final volume = HetznerVolume.fromJson(_volume(null));
      final result = await api.attachVolume(volume, 7);
      expect(result.success, isTrue);
      expect(requests.single.data, {
        'automount': true,
        'assignee': {'id': 7, 'type': 'server'},
      });
    });

    test(
      'does not expose an unknown resource assignment as detached',
      () async {
        responseAssignee = {'id': 7, 'type': 'future-resource'};
        final list = await api.getVolumes();
        final detail = await api.getVolume('41');
        expect(list.success, isFalse);
        expect(list.data, isEmpty);
        expect(detail.success, isFalse);
        expect(detail.data, isNull);
      },
    );
  });
}
