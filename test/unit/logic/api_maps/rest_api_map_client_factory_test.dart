import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';

class _ResponseAdapter implements HttpClientAdapter {
  bool wasClosed = false;

  @override
  Future<ResponseBody> fetch(
    final RequestOptions options,
    final Stream<Uint8List>? requestStream,
    final Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    '{"servers":[]}',
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({final bool force = false}) {
    wasClosed = true;
  }
}

class _TestRestApiMap extends RestApiMap {
  _TestRestApiMap({required super.clientFactory});

  @override
  final bool hasLogger = false;

  @override
  final bool isWithToken = false;

  @override
  BaseOptions get options => BaseOptions(baseUrl: rootAddress);

  @override
  String get rootAddress => 'https://provider.example';
}

void main() {
  setUp(() {
    getIt.registerSingleton<ConsoleModel>(ConsoleModel());
  });

  tearDown(() async {
    await getIt.reset();
  });

  test('provider operations create and close independent clients', () async {
    final receivedOptions = <BaseOptions>[];
    final adapters = <_ResponseAdapter>[];
    final api = HetznerApi(
      token: 'provider-token',
      clientFactory: (final options) {
        receivedOptions.add(options);
        final adapter = _ResponseAdapter();
        adapters.add(adapter);
        return Dio(options)..httpClientAdapter = adapter;
      },
    );

    final firstResult = await api.getServers();
    final secondResult = await api.getServers();

    expect(firstResult.success, isTrue);
    expect(secondResult.success, isTrue);
    expect(receivedOptions, hasLength(2));
    expect(receivedOptions[0], isNot(same(receivedOptions[1])));
    for (final options in receivedOptions) {
      expect(options.baseUrl, 'https://api.hetzner.cloud/v1');
      expect(options.headers['Authorization'], 'Bearer provider-token');
      expect(options.responseType, ResponseType.json);
    }
    expect(adapters, hasLength(2));
    expect(adapters.every((final adapter) => adapter.wasClosed), isTrue);
  });

  test('custom options are passed to the injected factory', () async {
    late BaseOptions receivedOptions;
    final api = _TestRestApiMap(
      clientFactory: (final options) {
        receivedOptions = options;
        return Dio(options);
      },
    );
    final customOptions = BaseOptions(baseUrl: 'https://custom.example');

    final client = await api.getClient(customOptions: customOptions);

    expect(receivedOptions, same(customOptions));
    client.close();
  });
}
