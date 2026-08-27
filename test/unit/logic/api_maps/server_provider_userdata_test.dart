import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/credential_fixtures.dart';

Dio _recordingClient(final void Function(RequestOptions) record) {
  final client = Dio();
  client.interceptors.add(
    InterceptorsWrapper(
      onRequest: (final options, final handler) {
        record(options);
        handler.reject(
          DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: 400,
              data: {
                'error': {'code': 'test_error'},
              },
            ),
            type: DioExceptionType.badResponse,
          ),
        );
      },
    ),
  );
  return client;
}

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  setUp(() async {
    await Hive.openBox(BNames.appSettingsBox);
    getIt.registerSingleton<DeveloperSettingsModel>(DeveloperSettingsModel());
  });

  tearDown(() async {
    await getIt.reset();
    final box = Hive.box(BNames.appSettingsBox);
    await box.clear();
    await box.close();
  });

  test('Hetzner userdata omits the legacy Unix-user arguments', () async {
    late RequestOptions request;
    final api = HetznerApi(
      token: 'provider-token',
      clientFactory: (_) => _recordingClient((final options) {
        request = options;
      }),
    );

    await api.createServer(
      dnsApiCredential: aDnsProviderCredential(),
      serverApiToken: 'server-token',
      domainName: 'example.com',
      hostName: 'example',
      volumeId: 1,
      serverType: 'cx22',
      customSshKey: null,
      region: 'fsn1',
    );

    final userData =
        (request.data as Map<String, Object?>)['user_data']! as String;
    expect(userData, contains('API_TOKEN=server-token'));
    expect(userData, isNot(contains('ENCODED_PASSWORD=')));
    expect(userData, isNot(contains('LUSER=')));
  });

  test('Hetzner userdata retains an optional root SSH key', () async {
    late RequestOptions request;
    final api = HetznerApi(
      token: 'provider-token',
      clientFactory: (_) => _recordingClient((final options) {
        request = options;
      }),
    );

    await api.createServer(
      dnsApiCredential: aDnsProviderCredential(),
      serverApiToken: 'server-token',
      domainName: 'example.com',
      hostName: 'example',
      volumeId: 1,
      serverType: 'cx22',
      customSshKey: 'ssh-ed25519 key',
      region: 'fsn1',
    );

    final userData =
        (request.data as Map<String, Object?>)['user_data']! as String;
    expect(userData, contains("SSH_AUTHORIZED_KEY='ssh-ed25519 key'"));
  });

  test('DigitalOcean userdata omits the legacy Unix-user arguments', () async {
    late RequestOptions request;
    final api = DigitalOceanApi(
      token: 'provider-token',
      clientFactory: (_) => _recordingClient((final options) {
        request = options;
      }),
    );

    await api.createServer(
      dnsApiCredential: aDnsProviderCredential(),
      serverApiToken: 'server-token',
      domainName: 'example.com',
      hostName: 'example',
      serverType: 's-1vcpu-1gb',
      customSshKey: null,
      region: 'fra1',
    );

    final userData =
        (request.data as Map<String, Object?>)['user_data']! as String;
    expect(userData, contains('API_TOKEN=server-token'));
    expect(userData, isNot(contains('ENCODED_PASSWORD=')));
    expect(userData, isNot(contains('LUSER=')));
  });

  test('DigitalOcean userdata retains an optional root SSH key', () async {
    late RequestOptions request;
    final api = DigitalOceanApi(
      token: 'provider-token',
      clientFactory: (_) => _recordingClient((final options) {
        request = options;
      }),
    );

    await api.createServer(
      dnsApiCredential: aDnsProviderCredential(),
      serverApiToken: 'server-token',
      domainName: 'example.com',
      hostName: 'example',
      serverType: 's-1vcpu-1gb',
      customSshKey: 'ssh-ed25519 key',
      region: 'fra1',
    );

    final userData =
        (request.data as Map<String, Object?>)['user_data']! as String;
    expect(userData, contains("SSH_AUTHORIZED_KEY='ssh-ed25519 key'"));
  });
}
