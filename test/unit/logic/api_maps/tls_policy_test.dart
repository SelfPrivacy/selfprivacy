import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/get_it/developer_settings_model.dart';

import '../../../fakes/hive/in_memory_hive.dart';

Future<HttpServer> _startSelfSignedServer() async {
  final SecurityContext context = SecurityContext()
    ..useCertificateChain('test/fixtures/certs/localhost-cert.pem')
    ..usePrivateKey('test/fixtures/certs/localhost-key.pem');

  final HttpServer server = await HttpServer.bindSecure(
    InternetAddress.loopbackIPv4,
    0,
    context,
  );
  server.listen((final HttpRequest request) async {
    request.response.write('ok');
    await request.response.close();
  });
  return server;
}

Future<String> _get(final HttpClient client, final Uri url) async {
  final HttpClientRequest request = await client.getUrl(url);
  final HttpClientResponse response = await request.close();
  return response.transform(const SystemEncoding().decoder).join();
}

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  late HttpServer server;
  late Uri url;
  late DeveloperSettingsModel settings;
  late TlsContext tls;

  setUp(() async {
    await Hive.openBox(BNames.appSettingsBox);
    server = await _startSelfSignedServer();
    url = Uri.parse('https://localhost:${server.port}/');
    settings = DeveloperSettingsModel();
    tls = TlsContext(settings);
  });

  tearDown(() async {
    tls.reset();
    await server.close(force: true);
    final Box box = Hive.box(BNames.appSettingsBox);
    await box.clear();
    await box.close();
  });

  test('the default policy rejects an untrusted certificate', () async {
    final HttpClient client = tls.httpClientFor(host: 'localhost');

    await expectLater(_get(client, url), throwsA(isA<HandshakeException>()));
  });

  test('allowUnverified accepts an untrusted certificate', () async {
    final HttpClient client = tls.httpClientFor(
      host: 'localhost',
      policy: TlsPolicy.allowUnverified,
    );

    expect(await _get(client, url), 'ok');
  });

  test('the developer override applies to the host it names', () async {
    settings.unverifiedTlsHost = 'localhost';

    final HttpClient client = tls.httpClientFor(host: 'localhost');

    expect(await _get(client, url), 'ok');
  });

  test('the developer override does not leak to other hosts', () async {
    settings.unverifiedTlsHost = 'api.example.org';

    final HttpClient client = tls.httpClientFor(host: 'localhost');

    await expectLater(_get(client, url), throwsA(isA<HandshakeException>()));
  });

  test(
    'an unverified client refuses certificates from a host it was not built for',
    () async {
      final HttpClient client = tls.httpClientFor(
        host: 'someone.else',
        policy: TlsPolicy.allowUnverified,
      );

      await expectLater(_get(client, url), throwsA(isA<HandshakeException>()));
    },
  );
}
