import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

/// A domain under the reserved `.invalid` TLD, so the lookup cannot succeed and
/// cannot reach a real host by accident.
const String _unresolvableDomain = 'invalid';

class _TokenBearingApi extends GraphQLApiMap {
  @override
  final String? rootAddress = 'example.org';
  @override
  final bool hasLogger = false;
  @override
  final bool isWithToken = true;
  @override
  final String customToken = '';
}

class _AnonymousApi extends GraphQLApiMap {
  @override
  final String? rootAddress = 'example.org';
  @override
  final bool hasLogger = false;
  @override
  final bool isWithToken = false;
  @override
  final String customToken = '';
}

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  late ResourcesModel resources;

  setUp(() async {
    await Hive.openBox(BNames.appSettingsBox);
    await Hive.openBox(BNames.resourcesBox);
    await Hive.openBox(BNames.serverInstallationBox);

    resources = ResourcesModel()..init();
    final developerSettings = DeveloperSettingsModel();
    getIt
      ..registerSingleton<ResourcesModel>(resources)
      ..registerSingleton<ApiConfigModel>(ApiConfigModel())
      ..registerSingleton<ConsoleModel>(ConsoleModel())
      ..registerSingleton<DeveloperSettingsModel>(developerSettings)
      ..registerSingleton<TlsContext>(TlsContext(developerSettings));
  });

  tearDown(() async {
    getIt<TlsContext>().reset();
    await getIt.reset();
    for (final String name in [
      BNames.appSettingsBox,
      BNames.resourcesBox,
      BNames.serverInstallationBox,
    ]) {
      final Box box = Hive.box(name);
      await box.clear();
      await box.close();
    }
  });

  group('getClient', () {
    test('a client that carries a token cannot opt out of verification', () {
      expect(
        _TokenBearingApi().getClient(tlsPolicy: TlsPolicy.allowUnverified),
        throwsStateError,
      );
    });

    test('an anonymous client may opt out of verification', () async {
      expect(
        await _AnonymousApi().getClient(tlsPolicy: TlsPolicy.allowUnverified),
        isA<GraphQLClient>(),
      );
    });

    test('the shared verifying client backs the default policy', () async {
      await _AnonymousApi().getClient();

      expect(
        identical(
          getIt<TlsContext>().httpClientFor(host: 'api.example.org'),
          getIt<TlsContext>().httpClientFor(host: 'api.other.org'),
        ),
        isTrue,
      );
    });
  });

  group('getSubscriptionClient', () {
    test('builds a client when no server is known yet', () async {
      expect(
        await _AnonymousApi().getSubscriptionClient(),
        isA<GraphQLClient>(),
      );
    });

    test('builds a client once a server token exists', () async {
      await resources.addServer(aServer());

      expect(
        await _TokenBearingApi().getSubscriptionClient(),
        isA<GraphQLClient>(),
      );
    });
  });

  group('probe', () {
    test('refuses to run on a token-bearing client', () {
      expect(
        ServerApi(isWithToken: true, overrideDomain: 'example.org').probe(),
        throwsStateError,
      );
    });

    test('reports a host it cannot reach as unreachable', () async {
      final ServerApi api = ServerApi(
        isWithToken: false,
        overrideDomain: _unresolvableDomain,
      );

      expect(await api.probe(), ServerProbeResult.unreachable);
    });

    test('getApiVersion answers null rather than throwing', () async {
      final ServerApi api = ServerApi(
        isWithToken: false,
        overrideDomain: _unresolvableDomain,
      );

      expect(await api.getApiVersion(), isNull);
    });
  });
}
