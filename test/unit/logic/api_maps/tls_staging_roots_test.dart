import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/get_it/developer_settings_model.dart';

import '../../../fakes/hive/in_memory_hive.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  late DeveloperSettingsModel settings;
  late TlsContext tls;

  setUp(() async {
    await Hive.openBox(BNames.appSettingsBox);
    settings = DeveloperSettingsModel();
    tls = TlsContext(settings);
  });

  tearDown(() async {
    tls.reset();
    final Box box = Hive.box(BNames.appSettingsBox);
    await box.clear();
    await box.close();
  });

  test('every bundled staging root loads', () async {
    await tls.loadStagingRoots();
    await settings.setStagingAcme(enabled: true);

    expect(() => tls.httpClientFor(host: 'api.example.org'), returnsNormally);
  });

  test('enabling staging trust rebuilds the verifying client', () async {
    await tls.loadStagingRoots();
    final HttpClient plain = tls.httpClientFor(host: 'api.example.org');

    await settings.setStagingAcme(enabled: true);

    expect(
      identical(plain, tls.httpClientFor(host: 'api.example.org')),
      isFalse,
    );
  });

  test('staging trust is ignored when the toggle is off', () async {
    await tls.loadStagingRoots();

    final HttpClient first = tls.httpClientFor(host: 'api.example.org');

    expect(
      identical(first, tls.httpClientFor(host: 'api.example.org')),
      isTrue,
    );
  });

  test('reset drops the cached clients', () {
    final HttpClient before = tls.httpClientFor(host: 'api.example.org');

    tls.reset();

    expect(
      identical(before, tls.httpClientFor(host: 'api.example.org')),
      isFalse,
    );
  });
}
