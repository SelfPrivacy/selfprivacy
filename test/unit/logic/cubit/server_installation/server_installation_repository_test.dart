import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/wizards_data/server_installation_wizard_data.dart';
import 'package:selfprivacy/logic/models/json/device_token.dart';

import '../../../../fakes/hive/in_memory_hive.dart';
import '../../../../helpers/fixtures/server_fixtures.dart';

class _MockServerApi extends Mock implements ServerApi {}

class _FixedIpRepository extends ServerInstallationRepository {
  _FixedIpRepository({required super.serverApi, required super.deviceName});

  @override
  Future<String> getServerIpFromDomain(final ServerDomain serverDomain) async =>
      '203.0.113.10';
}

void main() {
  setUpAll(() async {
    registerFallbackValue(DeviceToken(device: 'device', token: 'token'));
    await setUpInMemoryHive();
  });
  tearDownAll(tearDownInMemoryHive);

  late _MockServerApi api;
  late ServerInstallationRepository repository;
  late Map<String, Object?> lastFactoryCall;

  setUp(() async {
    await Hive.openBox(BNames.serverInstallationBox);
    await Hive.openBox(BNames.wizardDataBox);

    final wizard = WizardDataModel()..init();
    await wizard.setServerDomain(aServerDomain());
    await wizard.setServerDetails(aServerHostingDetails());
    getIt.registerSingleton<WizardDataModel>(wizard);

    api = _MockServerApi();
    lastFactoryCall = {};
    repository = _FixedIpRepository(
      deviceName: () async => 'Test device',
      serverApi:
          ({
            required final ServerDomainProvider domainProvider,
            final bool hasLogger = false,
            final ServerTokenProvider? tokenProvider,
          }) {
            lastFactoryCall = {
              'isWithToken': tokenProvider != null,
              'token': tokenProvider?.call(),
              'domain': domainProvider(),
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

  test('the cubit builds its own repository when none is injected', () {
    final cubit = ServerInstallationCubit();
    addTearDown(cubit.close);

    expect(cubit.repository, isNotNull);
  });

  group('probeServer', () {
    test('builds an anonymous client, so no token can leak', () async {
      when(
        () => api.probe(),
      ).thenAnswer((_) async => ServerProbeResult.reachable);

      await repository.probeServer();

      expect(lastFactoryCall['isWithToken'], isFalse);
      expect(lastFactoryCall['token'], isNull);
      expect(lastFactoryCall['domain'], 'example.org');
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
    test(
      'succeeds on an accepted reboot, over an authenticated client',
      () async {
        when(() => api.reboot()).thenAnswer(
          (_) async => GenericResult<void>(success: true, data: null),
        );

        expect(await repository.restart(), isTrue);
        expect(lastFactoryCall['isWithToken'], isTrue);
        expect(lastFactoryCall['token'], 'api-token');
      },
    );

    test('fails when the server refuses the reboot', () async {
      when(() => api.reboot()).thenAnswer(
        (_) async => GenericResult<void>(success: false, data: null),
      );

      expect(await repository.restart(), isFalse);
    });
  });

  group(
    'the certificate and reboot gates round-trip through the wizard box',
    () {
      // Reopening the box forces the generated adapter to deserialize rather
      // than hand back the cached instance. Both fields reuse the Hive ids of
      // the old reset flags, so this is what proves the reuse is safe.
      Future<ServerInstallationWizardData> reload() async {
        await Hive.box(BNames.wizardDataBox).close();
        await Hive.openBox(BNames.wizardDataBox);
        return (WizardDataModel()..init()).serverInstallation!;
      }

      test('saveIsCertificateVerified', () async {
        await repository.saveIsCertificateVerified(certificateVerified: true);

        expect((await reload()).isCertificateVerified, isTrue);
      });

      test('saveIsServerRebooted', () async {
        await repository.saveIsServerRebooted(serverRebooted: true);

        expect((await reload()).isServerRebooted, isTrue);
      });
    },
  );

  group('getRecoveryCapabilities', () {
    Future<ServerRecoveryCapabilities> capabilitiesFor(final String? version) {
      when(() => api.getApiVersion()).thenAnswer((_) async => version);
      return repository.getRecoveryCapabilities(aServerDomain());
    }

    test('a server that does not answer offers nothing', () async {
      expect(await capabilitiesFor(null), ServerRecoveryCapabilities.none);
      expect(lastFactoryCall['isWithToken'], isFalse);
    });

    test('a pre-1.2 server only offers the legacy path', () async {
      expect(await capabilitiesFor('1.1.9'), ServerRecoveryCapabilities.legacy);
    });

    test('1.2.0 and later offer login tokens', () async {
      expect(
        await capabilitiesFor('1.2.0'),
        ServerRecoveryCapabilities.loginTokens,
      );
    });

    test('an unparseable version offers nothing', () async {
      expect(
        await capabilitiesFor('not-a-version'),
        ServerRecoveryCapabilities.none,
      );
    });
  });

  group('recovery token age', () {
    Future<void> expectFresh(
      final Future<ServerHostingDetails> Function() authorize,
    ) async {
      final before = DateTime.now();
      final details = await authorize();
      final after = DateTime.now();

      expect(details.apiToken, 'fresh-token');
      expect(details.apiTokenRotatedAt, isNotNull);
      expect(details.apiTokenRotatedAt!.isBefore(before), isFalse);
      expect(details.apiTokenRotatedAt!.isAfter(after), isFalse);
    }

    test('a new-device key produces a fresh token', () async {
      when(() => api.authorizeDevice(any())).thenAnswer(
        (_) async => GenericResult(success: true, data: 'fresh-token'),
      );

      await expectFresh(
        () => repository.authorizeByNewDeviceKey(
          aServerDomain(),
          'new-device-key',
          ServerRecoveryCapabilities.loginTokens,
        ),
      );
    });

    test('a recovery key produces a fresh token', () async {
      when(() => api.useRecoveryToken(any())).thenAnswer(
        (_) async => GenericResult(success: true, data: 'fresh-token'),
      );

      await expectFresh(
        () => repository.authorizeByRecoveryKey(
          aServerDomain(),
          'recovery-key',
          ServerRecoveryCapabilities.loginTokens,
        ),
      );
    });

    test('a current API token is exchanged for a fresh device token', () async {
      when(() => api.createDeviceToken()).thenAnswer(
        (_) async => GenericResult(success: true, data: 'device-key'),
      );
      when(() => api.authorizeDevice(any())).thenAnswer(
        (_) async => GenericResult(success: true, data: 'fresh-token'),
      );

      await expectFresh(
        () => repository.authorizeByApiToken(
          aServerDomain(),
          'api-token',
          ServerRecoveryCapabilities.loginTokens,
        ),
      );
    });

    test('a legacy supplied token keeps an unknown age', () async {
      when(() => api.isHttpServerWorking()).thenAnswer((_) async => true);

      final details = await repository.authorizeByApiToken(
        aServerDomain(),
        'legacy-token',
        ServerRecoveryCapabilities.legacy,
      );

      expect(details.apiToken, 'legacy-token');
      expect(details.apiTokenRotatedAt, isNull);
    });
  });

  test(
    'isHttpServerWorking asks the server over an authenticated client',
    () async {
      when(() => api.isHttpServerWorking()).thenAnswer((_) async => true);

      expect(await repository.isHttpServerWorking(), isTrue);
      expect(lastFactoryCall['isWithToken'], isTrue);
      expect(lastFactoryCall['token'], 'api-token');
    },
  );
}
