import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/resource_creation_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/credential_fixtures.dart';
import '../../../helpers/fixtures/json_fixture.dart';

enum _Provider { hetzner, digitalOcean }

enum _Resource { server, volume }

Map<String, dynamic> _creationResponse(
  final _Provider provider,
  final _Resource resource,
) {
  final folder = provider == _Provider.hetzner ? 'hetzner' : 'digital_ocean';
  final collection = resource == _Resource.volume
      ? 'volumes'
      : provider == _Provider.hetzner
      ? 'servers'
      : 'droplets';
  final key = resource == _Resource.volume
      ? 'volume'
      : provider == _Provider.hetzner
      ? 'server'
      : 'droplet';
  return {
    key: loadJsonFixtureItem(
      'server_providers/$folder/$collection.json',
      collection,
    ),
  };
}

Future<ResourceCreationResult<Object>> _create(
  final _Provider provider,
  final _Resource resource,
  final Dio Function(BaseOptions) clientFactory,
) {
  if (provider == _Provider.hetzner) {
    final api = HetznerApi(
      token: 'provider-token',
      clientFactory: clientFactory,
    );
    return resource == _Resource.volume
        ? api.createVolume(gb: 10, region: 'fsn1')
        : api.createServer(
            dnsApiCredential: aDnsProviderCredential(),
            serverApiToken: 'server-token',
            domainName: 'example.org',
            hostName: 'example',
            volumeId: 41,
            serverType: 'cx22',
            customSshKey: null,
            region: 'fsn1',
          );
  }
  final api = DigitalOceanApi(
    token: 'provider-token',
    clientFactory: clientFactory,
  );
  return resource == _Resource.volume
      ? api.createVolume(gb: 10, region: 'nyc1')
      : api.createServer(
          dnsApiCredential: aDnsProviderCredential(),
          serverApiToken: 'server-token',
          domainName: 'example.org',
          hostName: 'example',
          serverType: 's-1vcpu-1gb',
          customSshKey: null,
          region: 'nyc1',
        );
}

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

  for (final provider in _Provider.values) {
    for (final resource in _Resource.values) {
      group('${provider.name} ${resource.name}', () {
        late List<RequestOptions> requests;
        late Map<String, dynamic> response;
        late int? status;

        setUp(() {
          requests = [];
          response = _creationResponse(provider, resource);
          status = 201;
        });

        Dio clientFactory(final BaseOptions options) =>
            Dio(options)
              ..interceptors.add(
                InterceptorsWrapper(
                  onRequest: (final request, final handler) {
                    requests.add(request);
                    if (status == null) {
                      handler.reject(
                        DioException(
                          requestOptions: request,
                          type: DioExceptionType.receiveTimeout,
                        ),
                      );
                      return;
                    }
                    final reply = Response<dynamic>(
                      requestOptions: request,
                      data: response,
                      statusCode: status,
                    );
                    if (status! >= 400) {
                      handler.reject(
                        DioException(
                          requestOptions: request,
                          response: reply,
                          type: DioExceptionType.badResponse,
                        ),
                      );
                    } else {
                      handler.resolve(reply);
                    }
                  },
                ),
              );

        Future<ResourceCreationResult<Object>> create(
          final WidgetTester tester,
        ) async {
          final pending = _create(provider, resource, clientFactory);
          await tester.pump(Duration.zero);
          if (provider == _Provider.digitalOcean &&
              resource == _Resource.volume) {
            await tester.pump(const Duration(seconds: 6));
          }
          final result = await pending;
          expect(requests, hasLength(1));
          expect(requests.single.method, 'POST');
          expect(
            requests.single.path,
            resource == _Resource.volume
                ? '/volumes'
                : provider == _Provider.hetzner
                ? '/servers'
                : '/droplets',
          );
          return result;
        }

        testWidgets('preserves a confirmed creation and its usable payload', (
          final tester,
        ) async {
          final result = await create(tester);
          expect(result.outcome, ResourceCreationOutcome.confirmed);
          expect(result.success, isTrue);
          expect(result.data, isNotNull);
          expect(result.wasCreated, isTrue);
          expect(
            result.resourceId,
            provider == _Provider.hetzner
                ? resource == _Resource.server
                      ? '7'
                      : '41'
                : resource == _Resource.server
                ? '7'
                : '7724db7c-e098-11e5-b522-000f53304e51',
          );
        });

        testWidgets('preserves confirmation when the response has no ID', (
          final tester,
        ) async {
          (response.values.single as Map<String, dynamic>).remove('id');
          final result = await create(tester);
          expect(result.outcome, ResourceCreationOutcome.confirmed);
          expect(result.resourceId, isNull);
        });

        if (provider != _Provider.digitalOcean ||
            resource != _Resource.server) {
          testWidgets(
            'preserves confirmation and ID after payload decoding fails',
            (final tester) async {
              final payload = response.values.single as Map<String, dynamic>;
              if (provider == _Provider.digitalOcean) {
                payload['size_gigabytes'] = 'invalid-size';
              } else {
                payload.remove(
                  resource == _Resource.volume ? 'name' : 'server_type',
                );
              }
              final result = await create(tester);
              expect(result.outcome, ResourceCreationOutcome.confirmed);
              expect(result.success, isFalse);
              expect(
                result.resourceId,
                provider == _Provider.hetzner
                    ? resource == _Resource.server
                          ? '7'
                          : '41'
                    : '7724db7c-e098-11e5-b522-000f53304e51',
              );
            },
          );
        }

        for (final scenario in const [
          (status: 422, outcome: ResourceCreationOutcome.rejected),
          (status: 408, outcome: ResourceCreationOutcome.indeterminate),
          (status: 500, outcome: ResourceCreationOutcome.indeterminate),
          (status: null, outcome: ResourceCreationOutcome.indeterminate),
        ]) {
          testWidgets(
            'classifies ${scenario.status ?? 'a lost response'} without retry',
            (final tester) async {
              status = scenario.status;
              response = {};
              final result = await create(tester);
              expect(result.outcome, scenario.outcome);
              expect(result.success, isFalse);
              expect(result.wasCreated, isFalse);
              expect(result.resourceId, isNull);
              expect(result.code, scenario.status);
            },
          );
        }
      });
    }
  }
}
