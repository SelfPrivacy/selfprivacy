import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/json_fixture.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _Api extends Mock implements ServerApi {}

class _Tls extends Mock implements TlsContext {}

void main() {
  late ResourcesModel resources;
  late _Api api;
  late ApiConnectionRepository repository;
  late List<ApiToken> tokens;

  setUpAll(() async {
    await setUpInMemoryHive();
    registerFallbackValue(TlsPolicy.strict);
  });
  tearDownAll(tearDownInMemoryHive);
  setUp(() async {
    await Hive.openBox(BNames.resourcesBox);
    await Hive.openBox(BNames.serverInstallationBox);
    resources = ResourcesModel()..init();
    await resources.addServer(aServer());
    tokens = Query$GetApiTokens.fromJson(
      loadJsonFixture('graphql/domain_reads.json')['GetApiTokens']
          as Map<String, dynamic>,
    ).api.devices.map(ApiToken.fromGraphQL).toList();
    api = _Api();
    when(api.fetchApiVersion).thenAnswer((_) async => '3.6.0');
    when(api.getApiTokens).thenAnswer((_) async => tokens);
    repository = ApiConnectionRepository(resourcesModel: resources, api: api);
  });
  tearDown(() async {
    repository.dispose();
    await resources.dispose();
    await getIt.reset();
    for (final name in [BNames.resourcesBox, BNames.serverInstallationBox]) {
      await Hive.box(name).clear();
      await Hive.box(name).close();
    }
  });

  test(
    'refresh loads only devices and confirmed removal is published',
    () async {
      expect(await repository.refreshDevices(), RefreshResult.applied);
      final before = repository.devicesSnapshot;
      final name = tokens.firstWhere((final token) => !token.isCaller).name;
      when(() => api.deleteApiToken(name)).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      final changed = repository.devicesStream.firstWhere(
        (final value) => value.data?.length == 1,
      );
      await repository.revokeDevice(name);
      expect((await changed).data!.single.isCaller, isTrue);
      expect(repository.devicesSnapshot.updatedAt, before.updatedAt);
      verify(api.getApiTokens).called(1);
      verifyNever(api.getAllServices);
    },
  );

  for (final change in [
    'server',
    'credential',
    'endpoint',
    'clear',
    'dispose',
  ]) {
    test('$change detaches pending commands and reads', () async {
      await repository.refreshDevices();
      final read = Completer<List<ApiToken>>();
      when(api.getApiTokens).thenAnswer((_) => read.future);
      final reading = repository.refreshDevices();
      final name = tokens.firstWhere((final token) => !token.isCaller).name;
      final mutation = Completer<ServerMutationResult<void>>();
      when(() => api.deleteApiToken(name)).thenAnswer((_) => mutation.future);
      final deleting = repository.revokeDevice(name);
      switch (change) {
        case 'server':
          await resources.removeServer(resources.servers.single);
          await resources.addServer(aServer(uuid: 'new-server'));
        case 'credential':
          await resources.updateServerByUuid(
            aServer(
              hostingDetails: aServerHostingDetails(apiToken: 'replacement'),
            ),
          );
        case 'endpoint':
          await resources.updateServerByUuid(
            aServer(
              domain: aServerDomain(domainName: 'replacement.example.org'),
            ),
          );
        case 'clear':
          await repository.clear();
        case 'dispose':
          repository.dispose();
      }
      await pumpEventQueue();
      expect(await deleting, isNull);
      expect(await reading, RefreshResult.disposed);
      mutation.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      read.complete(tokens);
      await pumpEventQueue();
      expect(repository.devicesSnapshot.data, isNull);
    });
  }

  test('a late version response does not start a new session read', () async {
    final version = Completer<String>();
    when(api.fetchApiVersion).thenAnswer((_) => version.future);
    final reading = repository.refreshDevices();
    await repository.clear();
    expect(await reading, RefreshResult.disposed);
    version.complete('3.6.0');
    await pumpEventQueue();
    verifyNever(api.getApiTokens);
  });

  test(
    'bound requests keep their original credentials and ignore stale auth failures',
    () async {
      final tls = _Tls();
      final version = Completer<http.Response>();
      final requests = <http.Request>[];
      final client = MockClient((final request) {
        requests.add(request);
        return version.future;
      });
      when(
        () => tls.clientFor(
          host: any(named: 'host'),
          policy: any(named: 'policy'),
        ),
      ).thenReturn(client);
      getIt
        ..registerSingleton<TlsContext>(tls)
        ..registerSingleton<ApiConfigModel>(ApiConfigModel())
        ..registerSingleton<ConsoleModel>(ConsoleModel());
      final bound = ApiConnectionRepository(resourcesModel: resources);
      addTearDown(bound.dispose);
      final reading = bound.refreshDevices();
      await pumpEventQueue();
      expect(requests.single.url.host, 'api.example.org');
      expect(requests.single.headers['authorization'], 'Bearer api-token');
      await resources.updateServerByUuid(
        aServer(hostingDetails: aServerHostingDetails(apiToken: 'replacement')),
      );
      await pumpEventQueue();
      expect(await reading, RefreshResult.disposed);
      version.complete(
        http.Response(
          jsonEncode({
            'errors': [
              {
                'message': 'Authentication failed',
                'extensions': {'code': 'UNAUTHENTICATED'},
              },
            ],
          }),
          200,
          headers: {'content-type': 'application/json'},
        ),
      );
      await pumpEventQueue();
      expect(
        bound.currentConnectionStatus,
        isNot(ConnectionStatus.unauthorized),
      );
      expect(bound.devicesSnapshot.data, isNull);
      expect(requests, hasLength(1));
    },
  );
}
