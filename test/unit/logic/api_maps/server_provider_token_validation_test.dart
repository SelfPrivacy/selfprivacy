import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';

class _StubHttpClientAdapter implements HttpClientAdapter {
  _StubHttpClientAdapter.response(this.statusCode) : error = null;

  _StubHttpClientAdapter.error(this.error) : statusCode = null;

  final int? statusCode;
  final Object? error;
  RequestOptions? request;

  @override
  Future<ResponseBody> fetch(
    final RequestOptions options,
    final Stream<Uint8List>? requestStream,
    final Future<void>? cancelFuture,
  ) async {
    request = options;
    if (error != null) {
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        error: error,
      );
    }

    return ResponseBody.fromString(
      '{}',
      statusCode!,
      statusMessage: 'status $statusCode',
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({final bool force = false}) {}
}

void _runTokenValidationTests({
  required final String providerName,
  required final String rootAddress,
  required final String endpoint,
  required final Future<GenericResult<bool>> Function(String token) Function(
    Dio client,
  )
  createValidator,
}) {
  group('$providerName token validation', () {
    Future<({GenericResult<bool> result, RequestOptions request})> validate({
      final int? statusCode,
      final Object? error,
    }) async {
      final adapter = error == null
          ? _StubHttpClientAdapter.response(statusCode)
          : _StubHttpClientAdapter.error(error);
      final client = Dio(BaseOptions(baseUrl: rootAddress))
        ..httpClientAdapter = adapter;
      final result = await createValidator(client)('provider-token');
      return (result: result, request: adapter.request!);
    }

    test('accepts a valid token', () async {
      final validation = await validate(statusCode: 200);

      expect(validation.result.success, isTrue);
      expect(validation.result.data, isTrue);
      expect(validation.request.path, endpoint);
      expect(
        validation.request.headers['Authorization'],
        'Bearer provider-token',
      );
    });

    test('rejects an unauthorized token', () async {
      final validation = await validate(statusCode: 401);

      expect(validation.result.success, isTrue);
      expect(validation.result.data, isFalse);
      expect(validation.result.message, 'initializing.provider_bad_key_error');
    });

    for (final statusCode in [429, 500]) {
      test('reports HTTP $statusCode as unavailable', () async {
        final validation = await validate(statusCode: statusCode);

        expect(validation.result.success, isFalse);
        expect(validation.result.data, isFalse);
        expect(validation.result.message, contains('$statusCode'));
      });
    }

    test('reports a transport failure as unavailable', () async {
      final validation = await validate(error: 'connection failed');

      expect(validation.result.success, isFalse);
      expect(validation.result.data, isFalse);
      expect(validation.result.message, contains('connection failed'));
    });
  });
}

void main() {
  setUp(() {
    getIt.registerSingleton<ConsoleModel>(ConsoleModel());
  });

  tearDown(() async {
    await getIt.reset();
  });

  _runTokenValidationTests(
    providerName: 'Hetzner',
    rootAddress: 'https://api.hetzner.cloud/v1',
    endpoint: '/servers',
    createValidator: (final client) {
      final api = HetznerApi(isWithToken: false, clientFactory: (_) => client);
      return api.isApiTokenValid;
    },
  );

  _runTokenValidationTests(
    providerName: 'DigitalOcean',
    rootAddress: 'https://api.digitalocean.com/v2',
    endpoint: '/account',
    createValidator: (final client) {
      final api = DigitalOceanApi(
        isWithToken: false,
        clientFactory: (_) => client,
      );
      return api.isApiTokenValid;
    },
  );
}
