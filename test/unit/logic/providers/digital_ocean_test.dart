import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

class _DigitalOceanVolumeClientFactory {
  final List<RequestOptions> requests = [];

  Dio call(final BaseOptions options) => Dio(options)
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (
              final RequestOptions request,
              final RequestInterceptorHandler handler,
            ) {
              requests.add(request);

              switch ((request.method, request.path)) {
                case ('POST', '/volumes'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 201,
                      data: {'volume': _volume()},
                    ),
                  );
                case ('GET', '/volumes'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data: {
                        'volumes': [_volume()],
                      },
                    ),
                  );
                case ('GET', '/droplets'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data: {
                        'droplets': [_droplet()],
                      },
                    ),
                  );
                case ('GET', '/regions'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data: {
                        'regions': [
                          {'slug': 'nyc1', 'name': 'New York 1'},
                        ],
                      },
                    ),
                  );
                case ('POST', '/droplets/7/actions'):
                case ('POST', '/volumes/actions'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 201,
                      data: {
                        'action': {'status': 'completed'},
                      },
                    ),
                  );
                case ('GET', '/monitoring/metrics/droplet/bandwidth'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data: {
                        'data': {
                          'result': [
                            {
                              'values': [
                                [1, '2.0'],
                              ],
                            },
                          ],
                        },
                      },
                    ),
                  );
                case ('GET', '/monitoring/metrics/droplet/cpu'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data: {
                        'data': {
                          'result': [
                            {
                              'metric': {'mode': 'idle'},
                              'values': [
                                [1, '1.0'],
                              ],
                            },
                            {
                              'metric': {'mode': 'user'},
                              'values': [
                                [1, '3.0'],
                              ],
                            },
                          ],
                        },
                      },
                    ),
                  );
                case ('DELETE', '/volumes/volume-id'):
                case ('DELETE', '/droplets/7'):
                  handler.resolve(
                    _response(request, statusCode: 204, data: const {}),
                  );
                default:
                  handler.reject(
                    DioException(
                      requestOptions: request,
                      error: StateError('Unexpected request: ${request.uri}'),
                    ),
                  );
              }
            },
      ),
    );

  Response<dynamic> _response(
    final RequestOptions request, {
    required final int statusCode,
    required final Object data,
  }) => Response<dynamic>(
    requestOptions: request,
    statusCode: statusCode,
    data: data,
  );

  Map<String, dynamic> _volume() => {
    'id': 'volume-id',
    'name': 'selfprivacy-volume',
    'size_gigabytes': 10,
    'droplet_ids': <int>[7],
    'region': {'slug': 'nyc1', 'name': 'New York 1'},
  };

  Map<String, dynamic> _droplet() => {
    'id': 7,
    'name': 'selfprivacy-server',
    'networks': {
      'v4': [
        {'type': 'public', 'ip_address': '135.181.45.111'},
      ],
    },
    'region': {'slug': 'nyc1'},
    'volume_ids': ['volume-id'],
    'status': 'active',
    'vcpus': 1,
    'memory': 1024,
    'size': {
      'regions': ['nyc1'],
      'memory': 1024.0,
      'description': 'Basic',
      'disk': 25,
      'price_monthly': 6.0,
      'slug': 's-1vcpu-1gb',
      'vcpus': 1,
    },
  };
}

ServerProvider _provider(final _DigitalOceanVolumeClientFactory clients) =>
    ServerProviderFactory.createServerProviderInterface(
      ServerProviderSettings(
        provider: ServerProviderType.digitalOcean,
        credentials: const BearerTokenCredential(token: 'provider-token'),
      ),
      clientFactory: clients.call,
    );

void main() {
  setUp(() {
    getIt.registerSingleton<ConsoleModel>(ConsoleModel());
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('createVolume', () {
    testWidgets('converts DigitalOcean GiB to bytes', (final tester) async {
      final clients = _DigitalOceanVolumeClientFactory();
      final provider = _provider(clients);

      final resultFuture = provider.createVolume(10, 'nyc1');

      await tester.pump();
      await tester.pump(const Duration(seconds: 6));
      final result = await resultFuture;

      expect(result.success, isTrue);
      expect(result.data, isNotNull);
      expect(result.data!.sizeByte, 10 * 1024 * 1024 * 1024);

      final createRequest = clients.requests.singleWhere(
        (final request) => request.method == 'POST',
      );
      final requestData = createRequest.data as Map<String, dynamic>;
      expect(requestData['size_gigabytes'], 10);
    });
  });

  test('getServers exposes provider IDs as strings', () async {
    final clients = _DigitalOceanVolumeClientFactory();
    final provider = _provider(clients);

    final result = await provider.getServers();

    expect(result.success, isTrue);
    expect(result.data.single.providerId, '7');
  });

  test('getServerType matches the string provider ID', () async {
    final clients = _DigitalOceanVolumeClientFactory();

    final result = await _provider(clients).getServerType('7');

    expect(result.success, isTrue);
    expect(result.data?.identifier, 's-1vcpu-1gb');
  });

  test('power actions convert the string provider ID for the API', () async {
    final clients = _DigitalOceanVolumeClientFactory();
    final provider = _provider(clients);

    final powerOnResult = await provider.powerOn('7');
    final restartResult = await provider.restart('7');

    expect(powerOnResult.success, isTrue);
    expect(restartResult.success, isTrue);
    final actionRequests = clients.requests.where(
      (final request) => request.path == '/droplets/7/actions',
    );
    expect(
      actionRequests.map(
        (final request) => (request.data as Map<String, dynamic>)['type'],
      ),
      ['power_on', 'reboot'],
    );
  });

  test('volume operations convert server IDs at the API boundary', () async {
    final clients = _DigitalOceanVolumeClientFactory();
    final provider = _provider(clients);

    final volumesResult = await provider.getVolumes();
    final volume = volumesResult.data.single;
    final attachResult = await provider.attachVolume(volume, '7');
    final detachResult = await provider.detachVolume(volume);

    expect(volume.serverId, '7');
    expect(attachResult.success, isTrue);
    expect(detachResult.success, isTrue);
    final actionRequests = clients.requests.where(
      (final request) => request.path == '/volumes/actions',
    );
    expect(
      actionRequests.map(
        (final request) => (request.data as Map<String, dynamic>)['droplet_id'],
      ),
      [7, 7],
    );
  });

  test('metadata selects a droplet by its string provider ID', () async {
    final clients = _DigitalOceanVolumeClientFactory();

    final result = await _provider(clients).getMetadata('7', 'nyc1');

    expect(result.success, isTrue);
    expect(result.data, isNotEmpty);
  });

  test('metrics convert the string provider ID for every API call', () async {
    final clients = _DigitalOceanVolumeClientFactory();
    final start = DateTime.utc(2026, 1, 1);
    final end = start.add(const Duration(minutes: 5));

    final result = await _provider(clients).getMetrics('7', start, end);

    expect(result.success, isTrue);
    final metricRequests = clients.requests.where(
      (final request) => request.path.startsWith('/monitoring/metrics/'),
    );
    expect(
      metricRequests.map((final request) => request.queryParameters['host_id']),
      ['7', '7', '7'],
    );
  });

  testWidgets('deleteServer converts associated resource IDs', (
    final tester,
  ) async {
    final clients = _DigitalOceanVolumeClientFactory();
    final resultFuture = _provider(
      clients,
    ).deleteServer('selfprivacy-server.example.org');

    await tester.pump();
    await tester.pump(const Duration(seconds: 10));
    final result = await resultFuture;

    expect(result.success, isTrue);
    expect(
      clients.requests
          .where((final request) => request.method == 'DELETE')
          .map((final request) => request.path),
      ['/volumes/volume-id', '/droplets/7'],
    );
  });
}
