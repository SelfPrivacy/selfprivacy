import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/get_it/developer_settings_model.dart';

import '../../../fakes/hive/in_memory_hive.dart';

/// Serves each asset from [resolve], failing the load where it answers null.
///
/// [rootBundle] caches by key, so the cache is dropped before and after to keep
/// the mock from leaking into tests that want the real certificates.
void _mockAssets(final String? Function(String asset) resolve) {
  rootBundle.clear();
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMessageHandler('flutter/assets', (final ByteData? message) async {
        final String? content = resolve(
          utf8.decode(
            message!.buffer.asUint8List(
              message.offsetInBytes,
              message.lengthInBytes,
            ),
          ),
        );
        if (content == null) {
          return null;
        }
        final Uint8List bytes = utf8.encode(content);
        return ByteData.view(bytes.buffer);
      });
}

Future<HttpServer> _startServerSignedByTestRoot() async {
  final SecurityContext context = SecurityContext()
    ..useCertificateChain('test/helpers/certs/signed-localhost-cert.pem')
    ..usePrivateKey('test/helpers/certs/signed-localhost-key.pem');

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
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', null);
    rootBundle.clear();
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

  test('a staging root that will not load leaves the app usable', () async {
    _mockAssets((final _) => null);

    await tls.loadStagingRoots();
    await settings.setStagingAcme(enabled: true);

    expect(() => tls.httpClientFor(host: 'api.example.org'), returnsNormally);
  });

  test('a corrupt staging root is skipped rather than fatal', () async {
    _mockAssets((final _) => '-----BEGIN CERTIFICATE-----\nnot base64\n');

    await tls.loadStagingRoots();
    await settings.setStagingAcme(enabled: true);

    expect(() => tls.httpClientFor(host: 'api.example.org'), returnsNormally);
  });

  test('loading twice does not accumulate roots', () async {
    _mockAssets((final _) => null);

    await tls.loadStagingRoots();
    await tls.loadStagingRoots();
    await settings.setStagingAcme(enabled: true);

    expect(() => tls.httpClientFor(host: 'api.example.org'), returnsNormally);
  });

  group('a bundled root is really added to the trust store', () {
    late HttpServer server;
    late Uri url;
    HttpOverrides? bindingOverrides;

    setUp(() async {
      // The binding stubs every HttpClient, which would fake away the handshake
      // this group exists to observe. The binding itself has to stay up for
      // rootBundle.
      bindingOverrides = HttpOverrides.current;
      HttpOverrides.global = null;

      server = await _startServerSignedByTestRoot();
      url = Uri.parse('https://localhost:${server.port}/');
      _mockAssets(
        (final asset) => asset.endsWith('x1.pem')
            ? File('test/helpers/certs/ca-cert.pem').readAsStringSync()
            : null,
      );
    });

    tearDown(() async {
      HttpOverrides.global = bindingOverrides;
      await server.close(force: true);
    });

    test('the certificate is rejected while staging trust is off', () async {
      await tls.loadStagingRoots();

      await expectLater(
        tls.httpClientFor(host: 'localhost').getUrl(url),
        throwsA(isA<HandshakeException>()),
      );
    });

    test('and accepted once it is on', () async {
      await tls.loadStagingRoots();
      await settings.setStagingAcme(enabled: true);

      final HttpClientRequest request = await tls
          .httpClientFor(host: 'localhost')
          .getUrl(url);
      final HttpClientResponse response = await request.close();

      expect(
        await response.transform(const SystemEncoding().decoder).join(),
        'ok',
      );
    });
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
