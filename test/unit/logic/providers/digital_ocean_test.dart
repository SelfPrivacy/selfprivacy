import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
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
    'droplet_ids': <int>[],
    'region': {'slug': 'nyc1', 'name': 'New York 1'},
  };
}

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
      final provider = ServerProviderFactory.createServerProviderInterface(
        ServerProviderSettings(
          provider: ServerProviderType.digitalOcean,
          token: 'provider-token',
          isAuthorized: true,
        ),
        clientFactory: clients.call,
      );

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
}
