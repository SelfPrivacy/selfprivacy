import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/forms/checks/recovery_domain_check.dart';

import '../../../fakes/hive/in_memory_hive.dart';

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
  final String apiToken = 'server-token';
}

class _AnonymousApi extends GraphQLApiMap {
  @override
  final String? rootAddress = 'example.org';
  @override
  final bool hasLogger = false;
  @override
  final bool isWithToken = false;
  @override
  final String apiToken = '';
}

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  setUp(() async {
    await Hive.openBox(BNames.appSettingsBox);
    await Hive.openBox(BNames.serverInstallationBox);

    final developerSettings = DeveloperSettingsModel();
    getIt
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

    test('builds a token-bearing client without global server state', () async {
      expect(
        await _TokenBearingApi().getSubscriptionClient(),
        isA<GraphQLClient>(),
      );
    });
  });

  group('probe', () {
    test('refuses to run on a token-bearing client', () {
      expect(
        ServerApi(
          domainProvider: () => 'example.org',
          tokenProvider: () => 'server-token',
        ).probe(),
        throwsStateError,
      );
    });

    test('reports a host it cannot reach as unreachable', () async {
      final ServerApi api = ServerApi(
        domainProvider: () => _unresolvableDomain,
      );

      expect(await api.probe(), ServerProbeResult.unreachable);
    });

    test('reboot reports failure rather than throwing', () async {
      final ServerApi api = ServerApi(
        domainProvider: () => _unresolvableDomain,
      );

      expect((await api.reboot()).success, isFalse);
    });

    test('getApiVersion answers null rather than throwing', () async {
      final ServerApi api = ServerApi(
        domainProvider: () => _unresolvableDomain,
      );

      expect(await api.getApiVersion(), isNull);
    });

    test('a recovery-domain check rejects an unreachable domain', () async {
      expect(await checkRecoveryDomain(_unresolvableDomain), isFalse);
    });
  });

  test('reads current connection values from their providers', () {
    var domain = 'first.example';
    var token = 'first-token';
    final api = ServerApi(
      domainProvider: () => domain,
      tokenProvider: () => token,
    );

    expect(api.rootAddress, 'first.example');
    expect(api.apiToken, 'first-token');

    domain = 'second.example';
    token = 'rotated-token';

    expect(api.rootAddress, 'second.example');
    expect(api.apiToken, 'rotated-token');
  });
}
