import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/credential_fixtures.dart';
import '../../../helpers/fixtures/json_fixture.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

enum _FailureStage { server, uniqueness, reverseDns }

class _HetznerInstallationClientFactory {
  _HetznerInstallationClientFactory(this.failureStage);

  final _FailureStage failureStage;

  Dio call(final BaseOptions options) => Dio(options)
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (
              final RequestOptions request,
              final RequestInterceptorHandler handler,
            ) {
              switch ((request.method, request.path)) {
                case ('POST', '/volumes'):
                  handler.resolve(
                    _response(
                      request,
                      statusCode: 201,
                      statusMessage: 'volume-created',
                      data: {
                        'volume': loadJsonFixtureItem(
                          'server_providers/hetzner/volumes.json',
                          'volumes',
                        ),
                      },
                    ),
                  );
                case ('DELETE', '/volumes/41'):
                  handler.resolve(_response(request, statusCode: 204));
                case ('POST', '/servers'):
                  _handleServerCreation(request, handler);
                case ('POST', '/servers/7/actions/change_dns_ptr'):
                  handler.reject(
                    DioException(
                      requestOptions: request,
                      type: DioExceptionType.connectionError,
                      error: 'reverse-dns-failed',
                    ),
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

  void _handleServerCreation(
    final RequestOptions request,
    final RequestInterceptorHandler handler,
  ) {
    switch (failureStage) {
      case _FailureStage.server:
        handler.resolve(
          _response(
            request,
            statusCode: 422,
            statusMessage: 'server-create-failed',
            data: {'server': null},
          ),
        );
      case _FailureStage.uniqueness:
        handler.reject(
          DioException(
            requestOptions: request,
            response: _response(
              request,
              statusCode: 409,
              data: {
                'error': {'code': 'uniqueness_error'},
              },
            ),
            type: DioExceptionType.badResponse,
          ),
        );
      case _FailureStage.reverseDns:
        handler.resolve(
          _response(
            request,
            statusCode: 201,
            statusMessage: 'server-created',
            data: {
              'server': loadJsonFixtureItem(
                'server_providers/hetzner/servers.json',
                'servers',
              ),
            },
          ),
        );
    }
  }

  Response<dynamic> _response(
    final RequestOptions request, {
    required final int statusCode,
    final String? statusMessage,
    final Object? data,
  }) => Response<dynamic>(
    requestOptions: request,
    statusCode: statusCode,
    statusMessage: statusMessage,
    data: data,
  );
}

class _HetznerMetadataClientFactory {
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
                case ('GET', '/servers'):
                  handler.resolve(
                    _response(
                      request,
                      data: loadJsonFixture(
                        'server_providers/hetzner/servers.json',
                      ),
                    ),
                  );
                case ('GET', '/volumes'):
                  handler.resolve(
                    _response(
                      request,
                      data: loadJsonFixture(
                        'server_providers/hetzner/volumes.json',
                      ),
                    ),
                  );
                case ('GET', '/server_types'):
                  handler.resolve(
                    _response(
                      request,
                      data: loadJsonFixture(
                        'server_providers/hetzner/server_types.json',
                      ),
                    ),
                  );
                case ('GET', '/pricing'):
                  handler.resolve(
                    _response(
                      request,
                      data: loadJsonFixture(
                        'server_providers/hetzner/pricing.json',
                      ),
                    ),
                  );
                case ('POST', '/servers/7/actions/poweron'):
                case ('POST', '/servers/7/actions/reset'):
                  handler.resolve(_response(request, data: const {}));
                case ('POST', '/volumes'):
                  handler.resolve(
                    _response(
                      request,
                      data: {
                        'volume': loadJsonFixtureItem(
                          'server_providers/hetzner/volumes.json',
                          'volumes',
                        ),
                      },
                    ),
                  );
                case ('POST', '/volumes/41/actions/attach'):
                case ('POST', '/volumes/41/actions/resize'):
                  handler.resolve(
                    _response(
                      request,
                      data: {
                        'action': {'status': 'running'},
                      },
                    ),
                  );
                case ('GET', '/servers/7/metrics'):
                  handler.resolve(
                    _response(
                      request,
                      data: loadJsonFixture(
                        'server_providers/hetzner/metrics_${request.queryParameters['type']}.json',
                      ),
                    ),
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
    required final Object data,
  }) => Response<dynamic>(requestOptions: request, statusCode: 200, data: data);
}

LaunchInstallationData _installationData({
  required final void Function() onSuccess,
}) => LaunchInstallationData(
  dnsApiCredential: aDnsProviderCredential(),
  serverDomain: aServerDomain(),
  serverTypeId: 'cpx12',
  errorCallback: () {},
  successCallback: (final _) => onSuccess(),
  storageSize: DiskSize.fromGibibyte(10),
  customSshKey: null,
  location: 'fsn1',
);

ServerProvider _provider(final _FailureStage failureStage) =>
    ServerProviderFactory.createServerProviderInterface(
      ServerProviderSettings(
        provider: ServerProviderType.hetzner,
        credentials: const BearerTokenCredential(token: 'provider-token'),
      ),
      clientFactory: _HetznerInstallationClientFactory(failureStage).call,
    );

ServerProvider _metadataProvider(final _HetznerMetadataClientFactory clients) =>
    ServerProviderFactory.createServerProviderInterface(
      ServerProviderSettings(
        provider: ServerProviderType.hetzner,
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
    final box = Hive.box(BNames.appSettingsBox);
    await box.clear();
    await box.close();
  });

  group('launchInstallation', () {
    testWidgets('server creation failure uses the server result', (
      final tester,
    ) async {
      bool successCalled = false;
      final resultFuture = _provider(_FailureStage.server).launchInstallation(
        _installationData(onSuccess: () => successCalled = true),
      );

      await tester.pump();
      await tester.pump(const Duration(seconds: 5));
      final result = await resultFuture;

      expect(result.success, isFalse);
      expect(result.message, 'server-create-failed');
      expect(result.code, 422);
      expect(result.data!.description, 'server-create-failed');
      expect(successCalled, isFalse);
    });

    testWidgets('uniqueness failure uses the server result metadata', (
      final tester,
    ) async {
      bool successCalled = false;
      final resultFuture = _provider(_FailureStage.uniqueness)
          .launchInstallation(
            _installationData(onSuccess: () => successCalled = true),
          );

      await tester.pump();
      await tester.pump(const Duration(seconds: 5));
      final result = await resultFuture;

      expect(result.success, isFalse);
      expect(result.message, 'uniqueness_error');
      expect(result.code, 409);
      expect(result.data, isNotNull);
      expect(successCalled, isFalse);
    });

    testWidgets('reverse DNS failure uses the reverse DNS result', (
      final tester,
    ) async {
      bool successCalled = false;
      final resultFuture = _provider(_FailureStage.reverseDns)
          .launchInstallation(
            _installationData(onSuccess: () => successCalled = true),
          );

      await tester.pump();
      await tester.pump(const Duration(seconds: 5));
      final result = await resultFuture;

      expect(result.success, isFalse);
      expect(result.message, contains('reverse-dns-failed'));
      expect(result.code, isNull);
      expect(result.data!.description, result.message);
      expect(successCalled, isFalse);
    });
  });

  group('getMetadata', () {
    test('selects the server price by location', () async {
      final clients = _HetznerMetadataClientFactory();
      final provider = _metadataProvider(clients);

      final result = await provider.getMetadata('7', 'fsn1');

      expect(result.success, isTrue);
      final cost = result.data.singleWhere(
        (final metadata) => metadata.type == MetadataType.cost,
      );
      expect(cost.value, '3.49 + 1.00 + 0.50 EUR');
      expect(clients.requests.map((final request) => request.path), [
        '/servers',
        '/volumes',
        '/pricing',
      ]);
    });
  });

  test('getServers exposes provider IDs as strings', () async {
    final clients = _HetznerMetadataClientFactory();
    final provider = _metadataProvider(clients);

    final result = await provider.getServers();

    expect(result.success, isTrue);
    expect(result.data.single.providerId, '7');
  });

  test('getServerType matches the string provider ID', () async {
    final clients = _HetznerMetadataClientFactory();

    final result = await _metadataProvider(clients).getServerType('7');

    expect(result.success, isTrue);
    expect(result.data?.identifier, 'cpx22');
  });

  test('power actions convert the string provider ID for the API', () async {
    final clients = _HetznerMetadataClientFactory();
    final provider = _metadataProvider(clients);

    final powerOnResult = await provider.powerOn('7');
    final restartResult = await provider.restart('7');

    expect(powerOnResult.success, isTrue);
    expect(restartResult.success, isTrue);
    expect(clients.requests.map((final request) => request.path), [
      '/servers/7/actions/poweron',
      '/servers/7/actions/reset',
    ]);
  });

  test('volume reads and creation expose associated IDs as strings', () async {
    final clients = _HetznerMetadataClientFactory();
    final provider = _metadataProvider(clients);

    final volumesResult = await provider.getVolumes();
    final creationResult = await provider.createVolume(10, 'fsn1');

    final volume = volumesResult.data.single;
    expect(volume.id, 41);
    expect(volume.name, 'selfprivacy-volume');
    expect(volume.sizeByte, 10 * 1024 * 1024 * 1024);
    expect(volume.serverId, '7');
    expect(volume.linuxDevice, '/dev/disk/by-id/scsi-0HC_Volume_41');
    expect(volume.location, 'fsn1');
    expect(creationResult.success, isTrue);
    expect(creationResult.data?.serverId, '7');
  });

  test('maps and sorts available server types for a location', () async {
    final clients = _HetznerMetadataClientFactory();
    final provider = _metadataProvider(clients);

    final result = await provider.getServerTypes(
      location: ServerProviderLocation(
        title: 'Falkenstein',
        identifier: 'fsn1',
        countryDisplayKey: 'countries.germany',
      ),
    );

    expect(result.success, isTrue);
    expect(result.data.map((final serverType) => serverType.identifier), [
      'cpx22',
      'cpx32',
    ]);
    final serverType = result.data.first;
    expect(serverType.title, 'CPX 22');
    expect(serverType.ram, 4);
    expect(serverType.cores, 2);
    expect(serverType.disk.byte, 80 * 1024 * 1024 * 1024);
    expect(serverType.price.value, 3.57);
    expect(serverType.price.currency.shortcode, 'EUR');
    expect(serverType.location.identifier, 'fsn1');
  });

  test('volume mutations convert server IDs at the API boundary', () async {
    final clients = _HetznerMetadataClientFactory();
    final provider = _metadataProvider(clients);
    final volume = (await provider.getVolumes()).data.single;

    final resizeResult = await provider.resizeVolume(
      volume,
      DiskSize.fromGibibyte(20),
    );
    final attachResult = await provider.attachVolume(volume, '7');

    expect(resizeResult.success, isTrue);
    expect(attachResult.success, isTrue);
    final attachRequest = clients.requests.singleWhere(
      (final request) => request.path == '/volumes/41/actions/attach',
    );
    expect((attachRequest.data as Map<String, dynamic>)['server'], 7);
  });

  test('maps normalized metrics and uses the provider ID', () async {
    final clients = _HetznerMetadataClientFactory();
    final start = DateTime.utc(2026, 1, 1);
    final end = start.add(const Duration(minutes: 5));

    final result = await _metadataProvider(clients).getMetrics('7', start, end);

    expect(result.success, isTrue);
    final metrics = result.data!;
    expect(metrics.start, start);
    expect(metrics.end, end);
    expect(metrics.stepsInSecond, 60);
    expect(metrics.cpu.map((final point) => point.secondsSinceEpoch), [
      1767225600,
      1767225660,
    ]);
    expect(metrics.cpu.map((final point) => point.value), [20, 30]);
    expect(metrics.bandwidthIn.map((final point) => point.value), [2048, 4096]);
    expect(metrics.bandwidthOut.map((final point) => point.value), [
      1024,
      3072,
    ]);
    expect(
      clients.requests
          .where((final request) => request.path == '/servers/7/metrics')
          .map((final request) => request.queryParameters['type']),
      ['cpu', 'network'],
    );
  });
}
