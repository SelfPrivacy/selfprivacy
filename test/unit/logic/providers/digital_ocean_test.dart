import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/provisioning_result.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/json_fixture.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _DigitalOceanClientFactory {
  _DigitalOceanClientFactory({
    this.volume,
    this.dropletsResponse,
    this.sizesResponse,
    this.volumesResponse,
    this.actionStatus = 'completed',
    this.provisioning = false,
  });

  final Map<String, dynamic>? volume;
  final Map<String, dynamic>? dropletsResponse;
  final Map<String, dynamic>? sizesResponse;
  final Map<String, dynamic>? volumesResponse;
  final String actionStatus;
  final bool provisioning;
  bool _created = false;
  final List<RequestOptions> requests = [];

  Map<String, dynamic> get _volume =>
      volume ??
      loadJsonFixtureItem(
        'server_providers/digital_ocean/volumes.json',
        'volumes',
      );

  Map<String, dynamic> get _volumesResponse {
    if (volumesResponse != null) {
      return volumesResponse!;
    }
    final response = loadJsonFixture(
      'server_providers/digital_ocean/volumes.json',
    );
    if (volume != null) {
      response['volumes'] = [_volume];
    }
    return response;
  }

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
                case ('POST', '/droplets'):
                  _created = true;
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 202,
                      data: {
                        'droplet': loadJsonFixtureItem(
                          'server_providers/digital_ocean/droplets.json',
                          'droplets',
                        ),
                      },
                    ),
                  );
                case ('POST', '/volumes'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 201,
                      data: {'volume': _volume},
                    ),
                  );
                case ('GET', '/volumes'):
                  handler.resolve(
                    _response(request, statusCode: 200, data: _volumesResponse),
                  );
                case ('GET', '/sizes'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data:
                          sizesResponse ??
                          loadJsonFixture(
                            'server_providers/digital_ocean/sizes.json',
                          ),
                    ),
                  );
                case ('GET', '/droplets'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 200,
                      data:
                          (provisioning && !_created
                              ? {'droplets': <Object>[]}
                              : dropletsResponse) ??
                          loadJsonFixture(
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
                case (
                  'POST',
                  '/volumes/7724db7c-e098-11e5-b522-000f53304e51/actions',
                ):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 201,
                      data: {
                        'action': {'status': actionStatus},
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
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);
  setUp(() async {
    await Hive.openBox(BNames.appSettingsBox);
    getIt
      ..registerSingleton<ConsoleModel>(ConsoleModel())
      ..registerSingleton<DeveloperSettingsModel>(DeveloperSettingsModel());
  });

  tearDown(() async {
    await getIt.reset();
    await Hive.box(BNames.appSettingsBox).clear();
    await Hive.box(BNames.appSettingsBox).close();
  });

  group('provisionServer', () {
    test('unreadable discovery returns a failure without creating', () async {
      final response = loadJsonFixture(
        'server_providers/digital_ocean/droplets.json',
      );
      final server = loadJsonFixtureItem(
        'server_providers/digital_ocean/droplets.json',
        'droplets',
      )..remove('region');
      response['droplets'] = [server];
      final clients = _DigitalOceanClientFactory(dropletsResponse: response);
      final result =
          await _provider(clients).provisionServer(aProvisioningRequest())
              as ProvisioningFailed;
      expect(result.stage, ProvisioningStage.discoverServers);
      expect(result.kind, ProvisioningFailureKind.unavailable);
      expect(clients.requests.map((final r) => r.method), ['GET']);
    });
    testWidgets('completes with the created IDs and caller token', (
      final tester,
    ) async {
      final response = loadJsonFixture(
        'server_providers/digital_ocean/droplets.json',
      );
      final original = loadJsonFixtureItem(
        'server_providers/digital_ocean/droplets.json',
        'droplets',
      );
      final unrelated =
          loadJsonFixtureItem(
              'server_providers/digital_ocean/droplets.json',
              'droplets',
            )
            ..['id'] = 99
            ..['networks'] = {
              'v4': [
                {'type': 'public', 'ip_address': '203.0.113.99'},
              ],
            };
      response['droplets'] = [unrelated, original];
      final clients = _DigitalOceanClientFactory(
        provisioning: true,
        dropletsResponse: response,
      );
      final pending = _provider(
        clients,
      ).provisionServer(aProvisioningRequest());
      await tester.pump(Duration.zero);
      await tester.pump(const Duration(seconds: 6));
      await tester.pump(const Duration(seconds: 20));
      final result = await pending as ProvisioningCompleted;
      expect(result.details.providerId, '7');
      expect(result.details.ip4, '135.181.45.111');
      expect(result.details.apiToken, 'installation-token');
      expect(result.details.volume.id, '7724db7c-e098-11e5-b522-000f53304e51');
      expect(result.resources.map((final r) => r.id), [
        '7',
        '7724db7c-e098-11e5-b522-000f53304e51',
      ]);
      expect(clients.requests.map((final r) => (r.method, r.path)), [
        ('GET', '/droplets'),
        ('POST', '/droplets'),
        ('POST', '/volumes'),
        ('POST', '/volumes/7724db7c-e098-11e5-b522-000f53304e51/actions'),
        ('GET', '/droplets'),
      ]);
    });

    testWidgets('IPv4 timeout retains resources without cleanup', (
      final tester,
    ) async {
      final clients = _DigitalOceanClientFactory(
        provisioning: true,
        dropletsResponse: {'droplets': <Object>[]},
      );
      final pending = _provider(
        clients,
      ).provisionServer(aProvisioningRequest());
      await tester.pump(Duration.zero);
      await tester.pump(const Duration(seconds: 6));
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(seconds: 20));
      }
      final result = await pending as ProvisioningFailed;
      expect(result.stage, ProvisioningStage.awaitIpv4);
      expect(result.resources, hasLength(2));
      expect(
        clients.requests.where((final r) => r.method == 'DELETE'),
        isEmpty,
      );
    });

    test('name conflict returns without a create or delete', () async {
      final response = loadJsonFixture(
        'server_providers/digital_ocean/droplets.json',
      );
      final server = loadJsonFixtureItem(
        'server_providers/digital_ocean/droplets.json',
        'droplets',
      )..['name'] = 'example';
      response['droplets'] = [server];
      final clients = _DigitalOceanClientFactory(dropletsResponse: response);
      final result =
          await _provider(clients).provisionServer(aProvisioningRequest())
              as ProvisioningFailed;
      expect(result.kind, ProvisioningFailureKind.nameConflict);
      expect(result.resources, isEmpty);
      expect(clients.requests.map((final r) => r.method), ['GET']);
    });

    test('deletes a recorded volume directly by UUID', () async {
      final clients = _DigitalOceanClientFactory();
      final result = await _provider(clients).deleteProvisionedResource(
        ProvisionedResource(
          provider: ServerProviderType.digitalOcean,
          kind: ProvisionedResourceKind.volume,
          id: '7724db7c-e098-11e5-b522-000f53304e51',
        ),
      );
      expect(result.success, isTrue);
      expect(clients.requests.map((final r) => (r.method, r.path)), [
        ('DELETE', '/volumes/7724db7c-e098-11e5-b522-000f53304e51'),
      ]);
    });
  });

  group('createVolume', () {
    test('uses the created UUID without listing volumes', () async {
      final clients = _DigitalOceanClientFactory(
        volumesResponse: {'volumes': <Object>[]},
      );

      final result = await _provider(clients).createVolume(10, 'nyc1');

      expect(result.success, isTrue);
      expect(result.data!.id, '7724db7c-e098-11e5-b522-000f53304e51');
      expect(
        clients.requests.map((final request) => (request.method, request.path)),
        [('POST', '/volumes')],
      );
    });
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

    testWidgets(
      'preserves creation details when the response volume is incomplete',
      (final tester) async {
        final incompleteVolume = Map<String, dynamic>.from(
          loadJsonFixtureItem(
            'server_providers/digital_ocean/volumes.json',
            'volumes',
          ),
        )..remove('region');
        final clients = _DigitalOceanClientFactory(volume: incompleteVolume);
        final provider = _provider(clients);

        final resultFuture = provider.createVolume(10, 'nyc1');

        await tester.pump();
        await tester.pump(const Duration(seconds: 6));
        final result = await resultFuture;

        expect(result.success, isFalse);
        expect(result.wasCreated, isTrue);
        expect(result.resourceId, '7724db7c-e098-11e5-b522-000f53304e51');
        expect(result.data, isNull);
        expect(result.message, 'DigitalOcean returned an incomplete volume.');
        expect(clients.requests, hasLength(1));
      },
    );
  });

  test('getVolumes fails when a volume is incomplete', () async {
    final incompleteVolume = Map<String, dynamic>.from(
      loadJsonFixtureItem(
        'server_providers/digital_ocean/volumes.json',
        'volumes',
      ),
    )..remove('size_gigabytes');
    final clients = _DigitalOceanClientFactory(volume: incompleteVolume);

    final result = await _provider(clients).getVolumes();

    expect(result.success, isFalse);
    expect(result.data, isEmpty);
    expect(result.message, contains('incomplete volume'));
  });

  test('getMetadata fails when its volume is incomplete', () async {
    final incompleteVolume = Map<String, dynamic>.from(
      loadJsonFixtureItem(
        'server_providers/digital_ocean/volumes.json',
        'volumes',
      ),
    )..remove('size_gigabytes');
    final clients = _DigitalOceanClientFactory(volume: incompleteVolume);

    final result = await _provider(clients).getMetadata('7', 'nyc1');

    expect(result.success, isFalse);
    expect(result.data, isEmpty);
    expect(result.message, contains('incomplete volume'));
  });

  test('getServers exposes provider IDs as strings', () async {
    final clients = _DigitalOceanClientFactory();
    final provider = _provider(clients);

    final result = await provider.getServers();

    expect(result.success, isTrue);
    expect(result.data.single.providerId, '7');
  });

  test('getServers excludes droplets without a public IPv4', () async {
    final response = loadJsonFixture(
      'server_providers/digital_ocean/droplets.json',
    );
    final droplet =
        (response['droplets'] as List<dynamic>).single as Map<String, dynamic>;
    (droplet['networks'] as Map<String, dynamic>).remove('v4');
    final clients = _DigitalOceanClientFactory(dropletsResponse: response);

    final result = await _provider(clients).getServers();

    expect(result.success, isTrue);
    expect(result.data, isEmpty);
  });

  test('getServers excludes malformed public IPv4 entries', () async {
    final response = loadJsonFixture(
      'server_providers/digital_ocean/droplets.json',
    );
    final droplet =
        (response['droplets'] as List<dynamic>).single as Map<String, dynamic>;
    final networks = droplet['networks'] as Map<String, dynamic>;
    final ipv4 =
        (networks['v4'] as List<dynamic>).single as Map<String, dynamic>;
    ipv4['ip_address'] = 'not-an-ip-address';
    final clients = _DigitalOceanClientFactory(dropletsResponse: response);

    final result = await _provider(clients).getServers();

    expect(result.success, isTrue);
    expect(result.data, isEmpty);
  });

  test('getServers excludes IPv4 entries with omitted fields', () async {
    for (final field in ['type', 'ip_address']) {
      final response = loadJsonFixture(
        'server_providers/digital_ocean/droplets.json',
      );
      final droplet =
          (response['droplets'] as List<dynamic>).single
              as Map<String, dynamic>;
      final networks = droplet['networks'] as Map<String, dynamic>;
      ((networks['v4'] as List<dynamic>).single as Map<String, dynamic>).remove(
        field,
      );
      final clients = _DigitalOceanClientFactory(dropletsResponse: response);

      final result = await _provider(clients).getServers();

      expect(result.success, isTrue);
      expect(result.data, isEmpty);
    }
  });

  test('getServers excludes droplets with only a private IPv4', () async {
    final response = loadJsonFixture(
      'server_providers/digital_ocean/droplets.json',
    );
    final droplet =
        (response['droplets'] as List<dynamic>).single as Map<String, dynamic>;
    final networks = droplet['networks'] as Map<String, dynamic>;
    final ipv4 =
        (networks['v4'] as List<dynamic>).single as Map<String, dynamic>;
    ipv4['type'] = 'private';
    final clients = _DigitalOceanClientFactory(dropletsResponse: response);

    final result = await _provider(clients).getServers();

    expect(result.success, isTrue);
    expect(result.data, isEmpty);
  });

  test('getServerType matches the string provider ID', () async {
    final clients = _DigitalOceanClientFactory();

    final result = await _provider(clients).getServerType('7');

    expect(result.success, isTrue);
    expect(result.data?.identifier, 's-1vcpu-1gb');
  });

  test('getServerType fails when the embedded size omits regions', () async {
    final response = loadJsonFixture(
      'server_providers/digital_ocean/droplets.json',
    );
    final droplet =
        (response['droplets'] as List<dynamic>).single as Map<String, dynamic>;
    (droplet['size'] as Map<String, dynamic>).remove('regions');
    final clients = _DigitalOceanClientFactory(dropletsResponse: response);

    final result = await _provider(clients).getServerType('7');

    expect(result.success, isFalse);
    expect(result.data, isNull);
    expect(
      result.message,
      'initializing.digital_ocean_regions_permission_error',
    );
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
    expect(volume.id, '7724db7c-e098-11e5-b522-000f53304e51');
    expect(volume.name, 'selfprivacy-volume');
    expect(volume.sizeByte, 10 * 1024 * 1024 * 1024);
    expect(volume.linuxDevice, 'scsi-0DO_Volume_selfprivacy-volume');
    expect(volume.location, 'nyc1');
    expect(attachResult.success, isTrue);
    expect(detachResult.success, isTrue);
    final actionRequests = clients.requests.where(
      (final request) =>
          request.path.startsWith('/volumes/') &&
          request.path.endsWith('/actions'),
    );
    expect(actionRequests.map((final request) => request.path), [
      '/volumes/7724db7c-e098-11e5-b522-000f53304e51/actions',
      '/volumes/7724db7c-e098-11e5-b522-000f53304e51/actions',
    ]);
    expect(
      actionRequests.map(
        (final request) => (request.data as Map<String, dynamic>)['droplet_id'],
      ),
      [7, 7],
    );
  });

  test(
    'errored volume actions are not treated as successful attachments',
    () async {
      final clients = _DigitalOceanClientFactory(actionStatus: 'errored');
      final provider = _provider(clients);
      final volume = (await provider.getVolumes()).data.single;

      expect((await provider.attachVolume(volume, '7')).data, isFalse);
      expect((await provider.detachVolume(volume)).data, isFalse);
    },
  );

  test(
    'unresolved volume identity cannot trigger provider mutations',
    () async {
      final clients = _DigitalOceanClientFactory();
      final provider = _provider(clients);
      final volume = aServerProviderVolume(id: null)..location = 'nyc1';
      final results = [
        await provider.deleteVolume(volume),
        await provider.attachVolume(volume, '7'),
        await provider.detachVolume(volume),
        await provider.resizeVolume(volume, DiskSize.fromGibibyte(20)),
      ];
      expect(results.every((final result) => !result.success), isTrue);
      expect(clients.requests, isEmpty);
    },
  );

  test('volume IDs are stable when the provider list changes order', () async {
    final first = loadJsonFixtureItem(
      'server_providers/digital_ocean/volumes.json',
      'volumes',
    );
    final second = Map<String, dynamic>.from(first)
      ..['id'] = '8724db7c-e098-11e5-b522-000f53304e51'
      ..['name'] = 'another-volume';
    final expected = {
      'selfprivacy-volume': '7724db7c-e098-11e5-b522-000f53304e51',
      'another-volume': '8724db7c-e098-11e5-b522-000f53304e51',
    };

    for (final volumes in [
      [first, second],
      [second, first],
    ]) {
      final result = await _provider(
        _DigitalOceanClientFactory(volumesResponse: {'volumes': volumes}),
      ).getVolumes();

      expect(result.success, isTrue);
      expect({
        for (final volume in result.data) volume.name: volume.id,
      }, expected);
    }
  });

  test('metadata selects a droplet by its string provider ID', () async {
    final clients = _DigitalOceanClientFactory();

    final result = await _provider(clients).getMetadata('7', 'nyc1');

    expect(result.success, isTrue);
    expect(result.data, isNotEmpty);
  });

  test('maps normalized metrics and uses the provider ID', () async {
    final clients = _DigitalOceanClientFactory();
    final start = DateTime.utc(2026, 1, 1);
    final end = start.add(const Duration(minutes: 5));

    final result = await _provider(clients).getMetrics('7', start, end);

    expect(result.success, isTrue);
    final metrics = result.data!;
    expect(metrics.start, start);
    expect(metrics.end, end);
    expect(metrics.stepsInSecond, 15);
    expect(metrics.cpu.map((final point) => point.secondsSinceEpoch), [
      1634052360,
      1634052480,
    ]);
    expect(metrics.cpu.map((final point) => point.value), [25, 40]);
    expect(
      metrics.bandwidthIn.first.value,
      closeTo(2075.0562612831696, 0.0000001),
    );
    expect(
      metrics.bandwidthOut.first.value,
      closeTo(1037.5281306415848, 0.0000001),
    );
    final metricRequests = clients.requests.where(
      (final request) => request.path.startsWith('/monitoring/metrics/'),
    );
    expect(
      metricRequests.map((final request) => request.queryParameters['host_id']),
      ['7', '7', '7'],
    );
  });

  test(
    'deleteServer targets its provider ID without deleting volumes',
    () async {
      final clients = _DigitalOceanClientFactory();
      final result = await _provider(clients).deleteServer('7');

      expect(result.success, isTrue);
      expect(
        clients.requests
            .where((final request) => request.method == 'DELETE')
            .map((final request) => request.path),
        ['/droplets/7'],
      );
    },
  );

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

  test('fails server type listing when a size omits regions', () async {
    final response = loadJsonFixture(
      'server_providers/digital_ocean/sizes.json',
    );
    final sizes = response['sizes'] as List<dynamic>;
    (sizes.first as Map<String, dynamic>).remove('regions');
    final clients = _DigitalOceanClientFactory(sizesResponse: response);
    final provider = _provider(clients);
    final locations = await provider.getAvailableLocations();

    final result = await provider.getServerTypes(
      location: locations.data.single,
    );

    expect(result.success, isFalse);
    expect(result.data, isEmpty);
    expect(
      result.message,
      'initializing.digital_ocean_regions_permission_error',
    );
  });
}
