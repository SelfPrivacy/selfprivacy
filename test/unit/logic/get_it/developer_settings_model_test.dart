import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/get_it/developer_settings_model.dart';

import '../../../fakes/hive/in_memory_hive.dart';

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  late DeveloperSettingsModel settings;

  setUp(() async {
    await Hive.openBox(BNames.appSettingsBox);
    settings = DeveloperSettingsModel();
  });

  tearDown(() async {
    final Box box = Hive.box(BNames.appSettingsBox);
    await box.clear();
    await box.close();
  });

  test('staging ACME defaults to off', () {
    expect(settings.stagingAcme, isFalse);
  });

  test('staging ACME survives a restart', () async {
    await settings.setStagingAcme(enabled: true);

    expect(DeveloperSettingsModel().stagingAcme, isTrue);
  });

  test('automatic GraphQL token refresh defaults to on', () {
    expect(settings.automaticGraphqlTokenRefresh, isTrue);
  });

  test('automatic GraphQL token refresh survives a restart', () async {
    await settings.setAutomaticGraphqlTokenRefresh(enabled: false);

    expect(DeveloperSettingsModel().automaticGraphqlTokenRefresh, isFalse);
  });

  test('the TLS override is never persisted', () {
    settings.unverifiedTlsHost = 'api.example.org';

    expect(DeveloperSettingsModel().unverifiedTlsHost, isNull);
  });

  test('clear resets the in-memory toggles', () async {
    await settings.setStagingAcme(enabled: true);
    settings
      ..allowCustomSshKeyDuringSetup = true
      ..unverifiedTlsHost = 'api.example.org'
      ..clear();

    expect(settings.allowCustomSshKeyDuringSetup, isFalse);
    expect(settings.unverifiedTlsHost, isNull);
  });

  test(
    'clear preserves stagingAcme so a failed install does not silently switch '
    "the next attempt to production Let's Encrypt",
    () async {
      await settings.setStagingAcme(enabled: true);

      settings.clear();

      expect(settings.stagingAcme, isTrue);
    },
  );
}
