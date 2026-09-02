import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

import '../../../helpers/fixtures/json_fixture.dart';

class _DigitalOceanClientFactory {
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
                      data: {
                        'volume': loadJsonFixtureItem(
                          'server_providers/digital_ocean/volumes.json',
                          'volumes',
                        ),
                      },
                    ),
                  );
                case ('GET', '/volumes'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data: loadJsonFixture(
                        'server_providers/digital_ocean/volumes.json',
                      ),
                    ),
                  );
                case ('GET', '/sizes'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data: loadJsonFixture(
                        'server_providers/digital_ocean/sizes.json',
                      ),
                    ),
                  );
                case ('GET', '/droplets'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data: loadJsonFixture(
                        'server_providers/digital_ocean/droplets.json',
                      ),
                    ),
                  );
                case ('GET', '/regions'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data: loadJsonFixture(
                        'server_providers/digital_ocean/regions.json',
                      ),
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
                      data: loadJsonFixture(
                        'server_providers/digital_ocean/metrics_bandwidth_${request.queryParameters['direction']}.json',
                      ),
                    ),
                  );
                case ('GET', '/monitoring/metrics/droplet/cpu'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data: loadJsonFixture(
                        'server_providers/digital_ocean/metrics_cpu.json',
                      ),
                    ),
                  );
                case (
                  'DELETE',
                  '/volumes/7724db7c-e098-11e5-b522-000f53304e51',
                ):
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
}

ServerProvider _provider(final _DigitalOceanClientFactory clients) =>
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
      final clients = _DigitalOceanClientFactory();
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
    final clients = _DigitalOceanClientFactory();
    final provider = _provider(clients);

    final result = await provider.getServers();

    expect(result.success, isTrue);
    expect(result.data.single.providerId, '7');
  });

  test('getServerType matches the string provider ID', () async {
    final clients = _DigitalOceanClientFactory();

    final result = await _provider(clients).getServerType('7');

    expect(result.success, isTrue);
    expect(result.data?.identifier, 's-1vcpu-1gb');
  });

  test('power actions convert the string provider ID for the API', () async {
    final clients = _DigitalOceanClientFactory();
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
    final clients = _DigitalOceanClientFactory();
    final provider = _provider(clients);

    final volumesResult = await provider.getVolumes();
    final volume = volumesResult.data.single;
    final attachResult = await provider.attachVolume(volume, '7');
    final detachResult = await provider.detachVolume(volume);

    expect(volume.serverId, '7');
    expect(volume.uuid, '7724db7c-e098-11e5-b522-000f53304e51');
    expect(volume.name, 'selfprivacy-volume');
    expect(volume.sizeByte, 10 * 1024 * 1024 * 1024);
    expect(volume.linuxDevice, 'scsi-0DO_Volume_selfprivacy-volume');
    expect(volume.location, 'nyc1');
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
    final clients = _DigitalOceanClientFactory();

    final result = await _provider(clients).getMetadata('7', 'nyc1');

    expect(result.success, isTrue);
    expect(result.data, isNotEmpty);
  });

  test('metrics convert the string provider ID for every API call', () async {
    final clients = _DigitalOceanClientFactory();
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
    final clients = _DigitalOceanClientFactory();
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
      ['/volumes/7724db7c-e098-11e5-b522-000f53304e51', '/droplets/7'],
    );
  });

  test('maps available server types for a location', () async {
    final clients = _DigitalOceanClientFactory();
    final provider = _provider(clients);
    final locations = await provider.getAvailableLocations();

    final result = await provider.getServerTypes(
      location: locations.data.single,
    );

    expect(result.success, isTrue);
    expect(result.data, hasLength(1));
    final serverType = result.data.single;
    expect(serverType.identifier, 's-1vcpu-2gb');
    expect(serverType.title, 'Basic');
    expect(serverType.ram, 2);
    expect(serverType.cores, 1);
    expect(serverType.disk.byte, 50 * 1024 * 1024 * 1024);
    expect(serverType.price.value, 12);
    expect(serverType.price.currency.shortcode, 'USD');
    expect(serverType.location.identifier, 'nyc1');
  });
}
