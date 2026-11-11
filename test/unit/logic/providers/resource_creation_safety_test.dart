import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/credential_fixtures.dart';
import '../../../helpers/fixtures/json_fixture.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

enum _HetznerResponse { unreadableVolume, unreadableServer, serverWithoutId }

class _HetznerCreationClientFactory {
  _HetznerCreationClientFactory(this.response);

  final _HetznerResponse response;
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
                    _responseFor(
                      request,
                      statusCode: 201,
                      data: {
                        'volume': response == _HetznerResponse.unreadableVolume
                            ? {'id': 41}
                            : _hetznerVolume(),
                      },
                    ),
                  );
                case ('POST', '/servers'):
                  final server = _hetznerServer();
                  server.remove('server_type');
                  if (response == _HetznerResponse.serverWithoutId) {
                    server.remove('id');
                  }
                  handler.resolve(
                    _responseFor(
                      request,
                      statusCode: 201,
                      data: {'server': server},
                    ),
                  );
                case ('POST', '/volumes/41/actions/detach'):
                  handler.resolve(_responseFor(request, statusCode: 201));
                case ('DELETE', '/servers/7'):
                case ('DELETE', '/volumes/41'):
                  handler.resolve(_responseFor(request, statusCode: 204));
                default:
                  handler.reject(_unexpectedRequest(request));
              }
            },
      ),
    );
}

enum _DigitalOceanResponse {
  dropletWithoutId,
  unreadableVolume,
  nameConflict,
  serverDiscoveryFailed,
  attachmentFailed,
}

class _DigitalOceanCreationClientFactory {
  _DigitalOceanCreationClientFactory(
    this.response, {
    this.failCleanup = false,
    this.emptyVolumeId = false,
  });

  final _DigitalOceanResponse response;
  bool failCleanup;
  final bool emptyVolumeId;
  final List<RequestOptions> requests = [];
  bool _created = false;

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
                case ('GET', '/droplets'):
                  if (response == _DigitalOceanResponse.serverDiscoveryFailed) {
                    handler.reject(
                      DioException(
                        requestOptions: request,
                        type: DioExceptionType.connectionError,
                      ),
                    );
                    return;
                  }
                  final server = loadJsonFixtureItem(
                    'server_providers/digital_ocean/droplets.json',
                    'droplets',
                  )..['name'] = 'example';
                  handler.resolve(
                    _responseFor(
                      request,
                      statusCode: 200,
                      data: {
                        'droplets': [
                          if (_created ||
                              response == _DigitalOceanResponse.nameConflict)
                            server,
                        ],
                      },
                    ),
                  );
                case ('POST', '/droplets'):
                  _created = true;
                  handler.resolve(
                    _responseFor(
                      request,
                      statusCode: 202,
                      data: {
                        'droplet':
                            response == _DigitalOceanResponse.dropletWithoutId
                            ? <String, Object>{}
                            : {'id': 7},
                      },
                    ),
                  );
                case ('POST', '/volumes'):
                  handler.resolve(
                    _responseFor(
                      request,
                      statusCode: 201,
                      data: {
                        'volume':
                            response == _DigitalOceanResponse.attachmentFailed
                            ? loadJsonFixtureItem(
                                'server_providers/digital_ocean/volumes.json',
                                'volumes',
                              )
                            : {'id': emptyVolumeId ? '' : 'volume-id'},
                      },
                    ),
                  );
                case ('GET', '/volumes'):
                  final volume = loadJsonFixtureItem(
                    'server_providers/digital_ocean/volumes.json',
                    'volumes',
                  );
                  handler.resolve(
                    _responseFor(
                      request,
                      statusCode: 200,
                      data: {
                        'volumes': [
                          {...volume, 'id': 'unrelated-volume'},
                          volume,
                        ],
                      },
                    ),
                  );
                case ('POST', '/volumes/actions'):
                case (
                  'POST',
                  '/volumes/7724db7c-e098-11e5-b522-000f53304e51/actions',
                ):
                  handler.resolve(
                    _responseFor(
                      request,
                      statusCode: 201,
                      data: {
                        'action': {
                          'status':
                              (request.data as Map<String, dynamic>)['type'] ==
                                  'attach'
                              ? 'errored'
                              : 'completed',
                        },
                      },
                    ),
                  );
                case ('DELETE', '/volumes/volume-id'):
                case (
                  'DELETE',
                  '/volumes/7724db7c-e098-11e5-b522-000f53304e51',
                ):
                  if (failCleanup) {
                    handler.reject(
                      DioException(
                        requestOptions: request,
                        response: _responseFor(request, statusCode: 500),
                        type: DioExceptionType.badResponse,
                      ),
                    );
                  } else {
                    handler.resolve(_responseFor(request, statusCode: 204));
                  }
                case ('DELETE', '/droplets/7'):
                  if (!_created) {
                    handler.reject(
                      DioException(
                        requestOptions: request,
                        response: _responseFor(request, statusCode: 404),
                        type: DioExceptionType.badResponse,
                      ),
                    );
                    return;
                  }
                  _created = false;
                  handler.resolve(_responseFor(request, statusCode: 204));
                case ('DELETE', '/volumes/unrelated-volume'):
                  handler.resolve(_responseFor(request, statusCode: 204));
                default:
                  handler.reject(_unexpectedRequest(request));
              }
            },
      ),
    );
}

Response<dynamic> _responseFor(
  final RequestOptions request, {
  required final int statusCode,
  final Object? data,
}) => Response<dynamic>(
  requestOptions: request,
  statusCode: statusCode,
  data: data,
);

DioException _unexpectedRequest(final RequestOptions request) => DioException(
  requestOptions: request,
  error: StateError('Unexpected request: ${request.uri}'),
);

Map<String, dynamic> _hetznerVolume() => {
  'id': 41,
  'size': 10,
  'server': null,
  'name': 'selfprivacy-volume',
  'linux_device': null,
  'location': _hetznerLocation(),
};

Map<String, dynamic> _hetznerServer() => {
  'id': 7,
  'name': 'example',
  'status': 'initializing',
  'created': '2026-08-29T12:00:00Z',
  'server_type': {
    'name': 'cpx12',
    'description': 'CPX 12',
    'architecture': 'x86',
    'cores': 1,
    'memory': 2,
    'disk': 40,
    'prices': <Object>[],
    'locations': <Object>[],
  },
  'location': _hetznerLocation(),
  'public_net': {
    'ipv4': {
      'id': 8,
      'ip': '203.0.113.10',
      'blocked': false,
      'dns_ptr': 'example.org',
    },
  },
  'volumes': [41],
};

Map<String, dynamic> _hetznerLocation() => {
  'name': 'fsn1',
  'country': 'DE',
  'city': 'Falkenstein',
  'description': 'Falkenstein DC Park 1',
  'network_zone': 'eu-central',
};

LaunchInstallationData _installationData({
  required final void Function() onError,
}) => LaunchInstallationData(
  dnsApiCredential: aDnsProviderCredential(),
  serverDomain: aServerDomain(),
  serverTypeId: 'cpx12',
  errorCallback: onError,
  successCallback: (final _) {},
  storageSize: DiskSize.fromGibibyte(10),
  customSshKey: null,
  location: 'fsn1',
);

ServerProvider _provider(
  final ServerProviderType type,
  final Dio Function(BaseOptions) clientFactory,
) => ServerProviderFactory.createServerProviderInterface(
  ServerProviderSettings(
    provider: type,
    credentials: const BearerTokenCredential(token: 'provider-token'),
  ),
  clientFactory: clientFactory,
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

  test('Hetzner waits for confirmation before deleting a server', () async {
    final clients = _HetznerCreationClientFactory(
      _HetznerResponse.unreadableServer,
    );
    int errorCalls = 0;

    final result = await _provider(
      ServerProviderType.hetzner,
      clients.call,
    ).launchInstallation(_installationData(onError: () => errorCalls++));

    expect(result.success, isFalse);
    expect(result.data, isNotNull);
    expect(
      clients.requests.where((final request) => request.method == 'DELETE'),
      isEmpty,
    );

    final cleanupFuture = result.data!.choices[1].callback!();
    final cleanupResult = await cleanupFuture;

    expect(cleanupResult.success, isTrue);
    expect(errorCalls, 1);
    expect(
      clients.requests.map((final request) => (request.method, request.path)),
      [
        ('POST', '/volumes'),
        ('POST', '/servers'),
        ('DELETE', '/servers/7'),
        ('DELETE', '/volumes/41'),
      ],
    );
  });

  test('Hetzner deletes only an unreadable volume and stops', () async {
    final clients = _HetznerCreationClientFactory(
      _HetznerResponse.unreadableVolume,
    );
    int errorCalls = 0;

    final result = await _provider(
      ServerProviderType.hetzner,
      clients.call,
    ).launchInstallation(_installationData(onError: () => errorCalls++));
    final cleanupResult = await result.data!.choices[1].callback!();

    expect(cleanupResult.success, isTrue);
    expect(errorCalls, 1);
    expect(
      clients.requests.map((final request) => (request.method, request.path)),
      [('POST', '/volumes'), ('DELETE', '/volumes/41')],
    );
  });

  test('leaving an unreadable resource does not delete it', () async {
    final clients = _HetznerCreationClientFactory(
      _HetznerResponse.unreadableVolume,
    );
    int errorCalls = 0;

    final result = await _provider(
      ServerProviderType.hetzner,
      clients.call,
    ).launchInstallation(_installationData(onError: () => errorCalls++));
    final stopResult = await result.data!.choices[0].callback!();

    expect(stopResult.success, isTrue);
    expect(errorCalls, 1);
    expect(
      clients.requests.map((final request) => (request.method, request.path)),
      [('POST', '/volumes')],
    );
  });

  test('Hetzner does not guess when the response has no resource ID', () async {
    final clients = _HetznerCreationClientFactory(
      _HetznerResponse.serverWithoutId,
    );
    int errorCalls = 0;

    final result = await _provider(
      ServerProviderType.hetzner,
      clients.call,
    ).launchInstallation(_installationData(onError: () => errorCalls++));
    final stopResult = await result.data!.choices[1].callback!();

    expect(stopResult.success, isTrue);
    expect(errorCalls, 1);
    expect(
      clients.requests.where((final request) => request.method == 'DELETE'),
      isEmpty,
    );
  });

  test('DigitalOcean stops when an accepted droplet has no ID', () async {
    final clients = _DigitalOceanCreationClientFactory(
      _DigitalOceanResponse.dropletWithoutId,
    );
    int errorCalls = 0;

    final result = await _provider(
      ServerProviderType.digitalOcean,
      clients.call,
    ).launchInstallation(_installationData(onError: () => errorCalls++));
    final stopResult = await result.data!.choices[1].callback!();

    expect(stopResult.success, isTrue);
    expect(errorCalls, 1);
    expect(
      clients.requests.map((final request) => (request.method, request.path)),
      [('GET', '/droplets'), ('POST', '/droplets')],
    );
  });

  test('DigitalOcean name conflict requires manual cleanup', () async {
    final clients = _DigitalOceanCreationClientFactory(
      _DigitalOceanResponse.nameConflict,
    );
    var stopped = false;
    final result = await _provider(
      ServerProviderType.digitalOcean,
      clients.call,
    ).launchInstallation(_installationData(onError: () => stopped = true));
    expect(result.success, isFalse);
    expect(result.data!.choices, hasLength(1));
    await result.data!.choices.single.callback!();
    expect(stopped, isTrue);
    expect(clients.requests.map((final request) => request.method), ['GET']);
  });

  test('DigitalOcean does not create resources when discovery fails', () async {
    final clients = _DigitalOceanCreationClientFactory(
      _DigitalOceanResponse.serverDiscoveryFailed,
    );
    final result = await _provider(
      ServerProviderType.digitalOcean,
      clients.call,
    ).launchInstallation(_installationData(onError: () {}));
    expect(result.success, isFalse);
    expect(clients.requests.map((final request) => request.method), ['GET']);
  });

  testWidgets(
    'DigitalOcean cleanup retains exact IDs after attachment failure',
    (final tester) async {
      final clients = _DigitalOceanCreationClientFactory(
        _DigitalOceanResponse.attachmentFailed,
        failCleanup: true,
      );
      final resultFuture = _provider(
        ServerProviderType.digitalOcean,
        clients.call,
      ).launchInstallation(_installationData(onError: () {}));
      for (var i = 0; i < 10; i++) {
        await tester.pump();
        if (clients.requests.any(
          (final request) =>
              request.method == 'POST' && request.path == '/droplets',
        )) {
          break;
        }
      }
      await tester.pump();
      await tester.pump(const Duration(seconds: 6));
      final result = await resultFuture;
      final pending = result.data!.choices[1].callback!();
      await tester.pump();
      await tester.pump(const Duration(seconds: 5));
      await tester.pump(const Duration(seconds: 10));

      expect(
        clients.requests
            .where((final request) => request.method == 'DELETE')
            .map((final request) => request.path),
        ['/droplets/7', '/volumes/7724db7c-e098-11e5-b522-000f53304e51'],
      );
      final cleanup = await pending;
      expect(cleanup.success, isFalse);
      expect(
        clients.requests.where(
          (final request) =>
              request.path == '/droplets' && request.method == 'POST',
        ),
        hasLength(1),
      );
      expect(
        clients.requests.where(
          (final request) =>
              request.path == '/volumes' && request.method == 'GET',
        ),
        isEmpty,
      );
    },
  );

  testWidgets('DigitalOcean requires manual cleanup for an empty accepted ID', (
    final tester,
  ) async {
    final clients = _DigitalOceanCreationClientFactory(
      _DigitalOceanResponse.unreadableVolume,
      emptyVolumeId: true,
    );
    var stopped = false;
    final pending = _provider(
      ServerProviderType.digitalOcean,
      clients.call,
    ).launchInstallation(_installationData(onError: () => stopped = true));
    for (var i = 0; i < 10; i++) {
      await tester.pump();
      if (clients.requests.any(
        (final request) =>
            request.path == '/droplets' && request.method == 'POST',
      )) {
        break;
      }
    }
    await tester.pump();
    await tester.pump(const Duration(seconds: 6));
    final result = await pending;
    await result.data!.choices[1].callback!();
    expect(stopped, isTrue);
    expect(clients.requests.map((final request) => request.method), [
      'GET',
      'POST',
      'POST',
    ]);
  });

  testWidgets(
    'DigitalOcean deletes an unreadable volume and its droplet without retry',
    (final tester) async {
      final clients = _DigitalOceanCreationClientFactory(
        _DigitalOceanResponse.unreadableVolume,
      );
      int errorCalls = 0;

      final resultFuture = _provider(
        ServerProviderType.digitalOcean,
        clients.call,
      ).launchInstallation(_installationData(onError: () => errorCalls++));
      for (var i = 0; i < 10; i++) {
        await tester.pump();
        if (clients.requests.any(
          (final request) =>
              request.method == 'POST' && request.path == '/droplets',
        )) {
          break;
        }
      }
      await tester.pump();
      await tester.pump(const Duration(seconds: 6));
      final result = await resultFuture;

      expect(
        clients.requests.where((final request) => request.method == 'DELETE'),
        isEmpty,
      );
      final cleanupFuture = result.data!.choices[1].callback!();
      await tester.pumpAndSettle();
      final cleanupResult = await cleanupFuture;

      expect(cleanupResult.success, isTrue);
      expect(errorCalls, 1);
      expect(
        clients.requests.map((final request) => (request.method, request.path)),
        [
          ('GET', '/droplets'),
          ('POST', '/droplets'),
          ('POST', '/volumes'),
          ('DELETE', '/droplets/7'),
          ('DELETE', '/volumes/volume-id'),
        ],
      );
    },
  );

  testWidgets('cleanup failure retries the same DigitalOcean resources', (
    final tester,
  ) async {
    final clients = _DigitalOceanCreationClientFactory(
      _DigitalOceanResponse.unreadableVolume,
      failCleanup: true,
    );
    var stopped = false;

    final resultFuture = _provider(
      ServerProviderType.digitalOcean,
      clients.call,
    ).launchInstallation(_installationData(onError: () => stopped = true));
    for (var i = 0; i < 10; i++) {
      await tester.pump();
      if (clients.requests.any(
        (final request) =>
            request.method == 'POST' && request.path == '/droplets',
      )) {
        break;
      }
    }
    await tester.pump();
    await tester.pump(const Duration(seconds: 6));
    final result = await resultFuture;

    final cleanupFuture = result.data!.choices[1].callback!();
    await tester.pumpAndSettle();
    final cleanupResult = await cleanupFuture;
    expect(cleanupResult.success, isFalse);
    expect(cleanupResult.data, isNotNull);
    expect(stopped, isFalse);

    clients.failCleanup = false;
    final retryFuture = cleanupResult.data!.choices[1].callback!();
    await tester.pumpAndSettle();
    final retryResult = await retryFuture;

    expect(retryResult.success, isTrue);
    expect(stopped, isTrue);
    expect(
      clients.requests
          .where((final request) => request.method == 'POST')
          .length,
      2,
    );
    expect(
      clients.requests
          .where((final request) => request.method == 'DELETE')
          .map((final request) => request.path),
      [
        '/droplets/7',
        '/volumes/volume-id',
        '/droplets/7',
        '/volumes/volume-id',
      ],
    );
  });
}
