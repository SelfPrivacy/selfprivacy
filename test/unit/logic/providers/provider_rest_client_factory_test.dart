import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider_factory.dart';
import 'package:selfprivacy/logic/providers/dns_providers/cloudflare.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider_factory.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

import '../../../helpers/fixtures/credential_fixtures.dart';

class _RecordingClientFactory {
  final List<BaseOptions> options = [];
  final List<RequestOptions> requests = [];

  Dio call(final BaseOptions baseOptions) {
    options.add(baseOptions);
    return Dio(baseOptions)
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest:
              (
                final RequestOptions request,
                final RequestInterceptorHandler handler,
              ) {
                requests.add(request);
                handler.resolve(
                  Response<dynamic>(
                    requestOptions: request,
                    statusCode: 200,
                    data: _responseFor(request),
                  ),
                );
              },
        ),
      );
  }

  Object _responseFor(final RequestOptions request) {
    switch (request.uri.path) {
      case '/servers':
        return {'servers': <Object>[]};
      case '/droplets':
        return {'droplets': <Object>[]};
      case '/account':
      case '/user/tokens/verify':
        return <String, Object>{};
      case '/client/v4/zones':
        return {
          'result': [
            {'id': 'zone-id', 'name': 'example.org'},
          ],
        };
      case '/v2/domains':
        return {'domains': <Object>[]};
      case '/api/v1/domains/':
        return <Object>[];
      case '/api/json/v3/domain/listAll':
        return {'domains': <Object>[]};
      case '/api/json/v3/ping':
        return {'credentialsValid': true};
      case '/b2api/v2/b2_authorize_account':
        return {
          'authorizationToken': 'authorization-token',
          'apiUrl': 'https://backblaze.example',
          'allowed': {
            'capabilities': ['listBuckets'],
          },
        };
      case '/b2api/v2/b2_create_bucket':
        return {'bucketId': 'bucket-id'};
      default:
        throw StateError('Unexpected request: ${request.uri}');
    }
  }
}

void main() {
  setUp(() {
    getIt.registerSingleton<ConsoleModel>(ConsoleModel());
  });

  tearDown(() async {
    await getIt.reset();
  });

  for (final testCase in [
    (
      name: 'Hetzner',
      type: ServerProviderType.hetzner,
      loadedPath: '/servers',
      loadedAuthorization: 'Bearer loaded-token',
      checkedAuthorization: 'Bearer checked-token',
    ),
    (
      name: 'DigitalOcean',
      type: ServerProviderType.digitalOcean,
      loadedPath: '/droplets',
      loadedAuthorization: 'Bearer loaded-token',
      checkedAuthorization: 'Bearer checked-token',
    ),
  ]) {
    test(
      '${testCase.name} server wrapper forwards the client factory',
      () async {
        final clients = _RecordingClientFactory();
        final loadedProvider =
            ServerProviderFactory.createServerProviderInterface(
              ServerProviderSettings(
                provider: testCase.type,
                token: 'loaded-token',
                isAuthorized: true,
              ),
              clientFactory: clients.call,
            );

        await loadedProvider.getServers();

        expect(clients.requests.single.path, testCase.loadedPath);
        expect(
          clients.requests.single.headers['Authorization'],
          testCase.loadedAuthorization,
        );

        final checkingProvider =
            ServerProviderFactory.createServerProviderInterface(
              ServerProviderSettings(provider: testCase.type),
              clientFactory: clients.call,
            );
        await checkingProvider.tryInitApiByToken('checked-token');

        expect(
          clients.requests.last.headers['Authorization'],
          testCase.checkedAuthorization,
        );
        expect(clients.options, hasLength(2));
      },
    );
  }

  for (final testCase in [
    (
      name: 'Cloudflare',
      type: DnsProviderType.cloudflare,
      loadedAuthorizationHeader: 'Authorization',
      loadedAuthorization: 'Bearer loaded-token',
      checkedAuthorizationHeader: 'Authorization',
      checkedAuthorization: 'Bearer checked-token',
      tokenId: null,
    ),
    (
      name: 'DigitalOcean',
      type: DnsProviderType.digitalOcean,
      loadedAuthorizationHeader: 'Authorization',
      loadedAuthorization: 'Bearer loaded-token',
      checkedAuthorizationHeader: 'Authorization',
      checkedAuthorization: 'Bearer checked-token',
      tokenId: null,
    ),
    (
      name: 'deSEC',
      type: DnsProviderType.desec,
      loadedAuthorizationHeader: 'Authorization',
      loadedAuthorization: 'Token loaded-token',
      checkedAuthorizationHeader: 'Authorization',
      checkedAuthorization: 'Token checked-token',
      tokenId: null,
    ),
    (
      name: 'Porkbun',
      type: DnsProviderType.porkbun,
      loadedAuthorizationHeader: 'X-Secret-API-Key',
      loadedAuthorization: 'loaded-token',
      checkedAuthorizationHeader: 'X-Secret-API-Key',
      checkedAuthorization: 'checked-token',
      tokenId: 'key-id',
    ),
  ]) {
    test('${testCase.name} DNS wrapper forwards the client factory', () async {
      final clients = _RecordingClientFactory();
      final loadedProvider = DnsProviderFactory.createDnsProviderInterface(
        DnsProviderSettings(
          provider: testCase.type,
          token: 'loaded-token',
          tokenId: testCase.tokenId,
          isAuthorized: true,
        ),
        clientFactory: clients.call,
      );

      await loadedProvider.domainList();

      expect(
        clients.requests.single.headers[testCase.loadedAuthorizationHeader],
        testCase.loadedAuthorization,
      );

      final checkingProvider = DnsProviderFactory.createDnsProviderInterface(
        DnsProviderSettings(provider: testCase.type),
        clientFactory: clients.call,
      );
      await checkingProvider.tryInitApiByToken(
        aDnsProviderCredential(
          provider: testCase.type,
          token: 'checked-token',
          tokenId: testCase.tokenId,
        ),
      );

      expect(
        clients.requests.last.headers[testCase.checkedAuthorizationHeader],
        testCase.checkedAuthorization,
      );
      expect(clients.options, hasLength(2));
    });
  }

  test('Backblaze wrapper forwards the client factory', () async {
    final clients = _RecordingClientFactory();
    final provider = BackupsProviderFactory.createBackupsProviderInterface(
      BackupsProviderSettings(
        provider: BackupsProviderType.backblaze,
        token: 'loaded-token',
        tokenId: 'loaded-key-id',
        isAuthorized: true,
      ),
      clientFactory: clients.call,
    );

    final createResult = await provider.createStorage('bucket-name');

    expect(createResult.success, isTrue);
    expect(createResult.data, 'bucket-id');
    expect(
      clients.requests.first.headers['Authorization'],
      startsWith('Basic '),
    );

    await provider.tryInitApiByToken('checked-encoded-key');

    expect(
      clients.requests.last.headers['Authorization'],
      'Basic checked-encoded-key',
    );
    expect(clients.options, hasLength(3));
  });

  test('Cloudflare keeps the client factory after caching a zone ID', () async {
    final clients = _RecordingClientFactory();
    final provider =
        DnsProviderFactory.createDnsProviderInterface(
              DnsProviderSettings(
                provider: DnsProviderType.cloudflare,
                token: 'loaded-token',
                isAuthorized: true,
              ),
              clientFactory: clients.call,
            )
            as CloudflareDnsProvider;

    final syncResult = await provider.syncZoneId('example.org');
    final domainsResult = await provider.domainList();

    expect(syncResult.success, isTrue);
    expect(domainsResult.success, isTrue);
    expect(clients.options, hasLength(2));
    expect(
      clients.requests.last.headers['Authorization'],
      'Bearer loaded-token',
    );
  });
}
