import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/credential_fixtures.dart';
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
                      data: {'volume': _volume()},
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
            data: {'server': _server()},
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

  Map<String, dynamic> _volume() => {
    'id': 41,
    'size': 10,
    'server': null,
    'name': 'selfprivacy-volume',
    'linux_device': null,
    'location': _location(),
  };

  Map<String, dynamic> _server() => {
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
    'location': _location(),
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

  Map<String, dynamic> _location() => {
    'name': 'fsn1',
    'country': 'DE',
    'city': 'Falkenstein',
    'description': 'Falkenstein DC Park 1',
    'network_zone': 'eu-central',
  };
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

              switch (request.path) {
                case '/servers':
                  handler.resolve(
                    _response(
                      request,
                      data: {
                        'servers': [_server()],
                      },
                    ),
                  );
                case '/volumes':
                  handler.resolve(
                    _response(
                      request,
                      data: {
                        'volumes': [_volume()],
                      },
                    ),
                  );
                case '/pricing':
                  handler.resolve(
                    _response(request, data: {'pricing': _pricing()}),
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

  Map<String, dynamic> _server() => {
    'id': 7,
    'name': 'selfprivacy-server',
    'status': 'running',
    'created': '2026-08-29T12:00:00Z',
    'server_type': {
      'name': 'cpx22',
      'description': 'CPX 22',
      'architecture': 'x86',
      'cores': 2,
      'memory': 4,
      'disk': 40,
      'prices': [
        _price(location: 'fsn1', monthly: '3.49'),
        _price(location: 'ash', monthly: '99.99'),
      ],
      'locations': <Object>[],
    },
    'location': _location(),
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

  Map<String, dynamic> _volume() => {
    'id': 41,
    'size': 10,
    'server': 7,
    'name': 'selfprivacy-volume',
    'linux_device': '/dev/disk/by-id/scsi-0HC_Volume_41',
    'location': _location(),
  };

  Map<String, dynamic> _pricing() => {
    'volume': {
      'price_per_gb_month': {'gross': '0.10'},
    },
    'primary_ips': [
      {
        'type': 'ipv4',
        'prices': [
          {
            'location': 'fsn1',
            'price_monthly': {'gross': '0.50'},
          },
        ],
      },
    ],
  };

  Map<String, dynamic> _price({
    required final String location,
    required final String monthly,
  }) => {
    'location': location,
    'price_hourly': {'gross': '0.01'},
    'price_monthly': {'gross': monthly},
  };

  Map<String, dynamic> _location() => {
    'name': 'fsn1',
    'country': 'DE',
    'city': 'Falkenstein',
    'description': 'Falkenstein DC Park 1',
    'network_zone': 'eu-central',
  };
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
        token: 'provider-token',
        isAuthorized: true,
      ),
      clientFactory: _HetznerInstallationClientFactory(failureStage).call,
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
      final provider = ServerProviderFactory.createServerProviderInterface(
        ServerProviderSettings(
          provider: ServerProviderType.hetzner,
          token: 'provider-token',
          isAuthorized: true,
        ),
        clientFactory: clients.call,
      );

      final result = await provider.getMetadata(7, 'fsn1');

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
}
