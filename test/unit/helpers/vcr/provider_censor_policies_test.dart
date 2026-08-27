import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sp_vcr/sp_vcr.dart';

import '../../../cassettes/backups_providers/backblaze/censor_policy.dart';
import '../../../cassettes/dns_providers/cloudflare/censor_policy.dart';
import '../../../cassettes/dns_providers/desec/censor_policy.dart';
import '../../../cassettes/dns_providers/digital_ocean/censor_policy.dart';
import '../../../cassettes/dns_providers/porkbun/censor_policy.dart';
import '../../../cassettes/provider_censors.dart';
import '../../../cassettes/server_providers/digital_ocean/censor_policy.dart';
import '../../../cassettes/server_providers/hetzner/censor_policy.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'selfprivacy_provider_censors_',
    );
  });

  tearDown(() async {
    await temporaryDirectory.delete(recursive: true);
  });

  test('censors provider authentication headers in raw cassettes', () async {
    final cases =
        <
          ({
            String name,
            CensorPolicy policy,
            Map<String, String> headers,
            List<String> secrets,
          })
        >[
          (
            name: 'hetzner',
            policy: hetznerCensorPolicy,
            headers: <String, String>{
              'Authorization': 'Bearer hetzner-provider-secret',
            },
            secrets: <String>['hetzner-provider-secret'],
          ),
          (
            name: 'digital_ocean_server',
            policy: digitalOceanServerCensorPolicy,
            headers: <String, String>{
              'Authorization': 'Bearer digital-ocean-server-secret',
            },
            secrets: <String>['digital-ocean-server-secret'],
          ),
          (
            name: 'cloudflare',
            policy: cloudflareCensorPolicy,
            headers: <String, String>{
              'Authorization': 'Bearer cloudflare-secret',
            },
            secrets: <String>['cloudflare-secret'],
          ),
          (
            name: 'desec',
            policy: desecCensorPolicy,
            headers: <String, String>{'Authorization': 'Token desec-secret'},
            secrets: <String>['desec-secret'],
          ),
          (
            name: 'digital_ocean_dns',
            policy: digitalOceanDnsCensorPolicy,
            headers: <String, String>{
              'Authorization': 'Bearer digital-ocean-dns-secret',
            },
            secrets: <String>['digital-ocean-dns-secret'],
          ),
          (
            name: 'porkbun',
            policy: porkbunCensorPolicy,
            headers: <String, String>{
              'X-API-Key': 'porkbun-api-key-secret',
              'X-Secret-API-Key': 'porkbun-secret-key-secret',
            },
            secrets: <String>[
              'porkbun-api-key-secret',
              'porkbun-secret-key-secret',
            ],
          ),
          (
            name: 'backblaze',
            policy: backblazeCensorPolicy,
            headers: <String, String>{
              'Authorization': 'Basic backblaze-provider-secret',
            },
            secrets: <String>['backblaze-provider-secret'],
          ),
        ];

    for (final entry in cases) {
      final rawCassette = await _recordInteraction(
        directory: temporaryDirectory,
        cassetteName: entry.name,
        policy: entry.policy,
        headers: entry.headers,
        requestBody: <String, String>{'safe': 'request-safe'},
        responseBody: <String, String>{'safe': 'response-safe'},
      );

      for (final secret in entry.secrets) {
        expect(rawCassette, isNot(contains(secret)), reason: entry.name);
      }
      expect(rawCassette, contains('******'), reason: entry.name);
      expect(rawCassette, contains('request-safe'), reason: entry.name);
      expect(rawCassette, contains('response-safe'), reason: entry.name);
    }
  });

  test('censors server installation secrets inside user_data', () async {
    const userData =
        'API_TOKEN=server-api-secret '
        "DNS_PROVIDER_TOKEN='dns-primary-secret' "
        'DNS_PROVIDER_TOKEN_ID=dns-id-secret '
        'DNS_PROVIDER_SECONDARY_TOKEN="dns-secondary-secret" '
        "SSH_AUTHORIZED_KEY='ssh-key-secret' "
        'SAFE_VALUE=request-safe';
    final cases = <({String name, CensorPolicy policy})>[
      (name: 'hetzner_userdata', policy: hetznerCensorPolicy),
      (name: 'digital_ocean_userdata', policy: digitalOceanServerCensorPolicy),
    ];

    for (final entry in cases) {
      final rawCassette = await _recordInteraction(
        directory: temporaryDirectory,
        cassetteName: entry.name,
        policy: entry.policy,
        requestBody: <String, String>{'user_data': userData},
        responseBody: <String, String>{'safe': 'response-safe'},
      );

      for (final secret in <String>[
        'server-api-secret',
        'dns-primary-secret',
        'dns-id-secret',
        'dns-secondary-secret',
        'ssh-key-secret',
      ]) {
        expect(rawCassette, isNot(contains(secret)), reason: entry.name);
      }
      expect(rawCassette, contains('API_TOKEN=******'), reason: entry.name);
      expect(rawCassette, contains('SAFE_VALUE=request-safe'));
      expect(rawCassette, contains('response-safe'));
    }
  });

  test('censors Backblaze response secrets but keeps identifiers', () async {
    final rawCassette = await _recordInteraction(
      directory: temporaryDirectory,
      cassetteName: 'backblaze_response',
      policy: backblazeCensorPolicy,
      headers: <String, String>{
        'Authorization': 'Basic backblaze-provider-secret',
      },
      requestBody: <String, String>{'safe': 'request-safe'},
      responseBody: <String, String>{
        'authorizationToken': 'backblaze-auth-secret',
        'applicationKey': 'backblaze-application-key-secret',
        'applicationKeyId': 'public-key-id',
        'accountId': 'public-account-id',
        'safe': 'response-safe',
      },
    );

    for (final secret in <String>[
      'backblaze-provider-secret',
      'backblaze-auth-secret',
      'backblaze-application-key-secret',
    ]) {
      expect(rawCassette, isNot(contains(secret)));
    }
    expect(rawCassette, contains('public-key-id'));
    expect(rawCassette, contains('public-account-id'));
    expect(rawCassette, contains('response-safe'));
  });

  test('creates independent Censors instances for provider harnesses', () {
    final porkbun = providerCensors(porkbunCensorPolicy)
      ..censorHeaderElementsByKeys(<String>['X-Test-Only']);
    final cloudflare = providerCensors(cloudflareCensorPolicy);

    expect(identical(porkbun, cloudflare), isFalse);
    expect(
      porkbun.applyHeaderCensors(<String, String>{'X-Test-Only': 'secret'}),
      <String, String>{'X-Test-Only': '******'},
    );
    expect(
      cloudflare.applyHeaderCensors(<String, String>{'X-Test-Only': 'visible'}),
      <String, String>{'X-Test-Only': 'visible'},
    );
  });
}

Future<String> _recordInteraction({
  required final Directory directory,
  required final String cassetteName,
  required final CensorPolicy policy,
  required final Map<String, String> requestBody,
  required final Map<String, String> responseBody,
  final Map<String, String> headers = const <String, String>{},
}) async {
  final cassette = Cassette(directory.path, cassetteName);
  final vcr =
      VCR(advancedOptions: AdvancedOptions(censors: providerCensors(policy)))
        ..insert(cassette)
        ..record();
  final dio = Dio()
    ..httpClientAdapter = _ResponseAdapter(jsonEncode(responseBody));
  vcr.attach(dio);

  try {
    await dio.post<String>(
      'https://example.test/$cassetteName',
      data: jsonEncode(requestBody),
      options: Options(
        contentType: Headers.jsonContentType,
        headers: headers,
        responseType: ResponseType.plain,
      ),
    );
  } finally {
    dio.close(force: true);
  }

  return File('${directory.path}/$cassetteName.json').readAsString();
}

class _ResponseAdapter implements HttpClientAdapter {
  _ResponseAdapter(this.responseBody);

  final String responseBody;

  @override
  Future<ResponseBody> fetch(
    final RequestOptions options,
    final Stream<Uint8List>? requestStream,
    final Future<void>? cancelFuture,
  ) async {
    await requestStream?.drain<void>();
    return ResponseBody.fromString(
      responseBody,
      HttpStatus.ok,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({final bool force = false}) {}
}
