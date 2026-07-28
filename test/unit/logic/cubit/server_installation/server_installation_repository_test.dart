import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

import '../../../../fakes/hive/in_memory_hive.dart';

class _MockServerApi extends Mock implements ServerApi {}

ServerHostingDetails _serverDetails() => ServerHostingDetails(
  ip4: '203.0.113.10',
  id: 1,
  createTime: null,
  volume: ServerProviderVolume(
    id: 0,
    name: '',
    sizeByte: 0,
    serverId: 1,
    linuxDevice: '',
  ),
  apiToken: 'api-token',
  provider: ServerProviderType.hetzner,
);

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  late _MockServerApi api;
  late ServerInstallationRepository repository;
  late Map<String, Object?> lastFactoryCall;

  setUp(() async {
    await Hive.openBox(BNames.serverInstallationBox);
    await Hive.openBox(BNames.wizardDataBox);

    final wizard = WizardDataModel()..init();
    await wizard.setServerDomain(
      ServerDomain(
        domainName: 'example.org',
        provider: DnsProviderType.cloudflare,
      ),
    );
    await wizard.setServerDetails(_serverDetails());
    getIt.registerSingleton<WizardDataModel>(wizard);

    api = _MockServerApi();
    lastFactoryCall = {};
    repository = ServerInstallationRepository(
      serverApi:
          ({
            final bool hasLogger = false,
            final bool isWithToken = true,
            final String customToken = '',
            final String? overrideDomain,
          }) {
            lastFactoryCall = {
              'isWithToken': isWithToken,
              'customToken': customToken,
              'overrideDomain': overrideDomain,
            };
            return api;
          },
    );
  });

  tearDown(() async {
    await getIt.reset();
    for (final String name in [
      BNames.serverInstallationBox,
      BNames.wizardDataBox,
    ]) {
      final Box box = Hive.box(name);
      await box.clear();
      await box.close();
    }
  });

  group('probeServer', () {
    test('builds an anonymous client, so no token can leak', () async {
      when(
        () => api.probe(),
      ).thenAnswer((_) async => ServerProbeResult.reachable);

      await repository.probeServer();

      expect(lastFactoryCall['isWithToken'], isFalse);
      expect(lastFactoryCall['customToken'], '');
      expect(lastFactoryCall['overrideDomain'], 'example.org');
    });

    test('passes the probe result through', () async {
      when(
        () => api.probe(),
      ).thenAnswer((_) async => ServerProbeResult.untrustedCertificate);

      expect(
        await repository.probeServer(),
        ServerProbeResult.untrustedCertificate,
      );
    });
  });

  group('restart', () {
    test('returns the server with the new start time', () async {
      final DateTime startedAt = DateTime.utc(2026, 7, 27, 12);
      when(() => api.reboot()).thenAnswer(
        (_) async => GenericResult<DateTime?>(success: true, data: startedAt),
      );

      final ServerHostingDetails? result = await repository.restart();

      expect(result, isNotNull);
      expect(result!.startTime, startedAt);
      expect(lastFactoryCall['isWithToken'], isTrue);
      expect(lastFactoryCall['customToken'], 'api-token');
    });

    test('returns null when the reboot fails', () async {
      when(() => api.reboot()).thenAnswer(
        (_) async => GenericResult<DateTime?>(success: false, data: null),
      );

      expect(await repository.restart(), isNull);
    });

    test('returns null when the reboot reports no start time', () async {
      when(() => api.reboot()).thenAnswer(
        (_) async => GenericResult<DateTime?>(success: true, data: null),
      );

      expect(await repository.restart(), isNull);
    });
  });

  test(
    'isHttpServerWorking asks the server over an authenticated client',
    () async {
      when(() => api.isHttpServerWorking()).thenAnswer((_) async => true);

      expect(await repository.isHttpServerWorking(), isTrue);
      expect(lastFactoryCall['isWithToken'], isTrue);
      expect(lastFactoryCall['customToken'], 'api-token');
    },
  );
}
