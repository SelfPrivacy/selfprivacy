import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/backblaze.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/cloudflare/cloudflare_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desec/desec_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/digital_ocean_dns/digital_ocean_dns_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/porkbun/porkbun_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:sp_vcr/sp_vcr.dart';

import '../../cassettes/backups_providers/backblaze/censor_policy.dart';
import '../../cassettes/dns_providers/cloudflare/censor_policy.dart';
import '../../cassettes/dns_providers/desec/censor_policy.dart';
import '../../cassettes/dns_providers/digital_ocean/censor_policy.dart';
import '../../cassettes/dns_providers/porkbun/censor_policy.dart';
import '../../cassettes/server_providers/digital_ocean/censor_policy.dart';
import '../../cassettes/server_providers/hetzner/censor_policy.dart';
import '../../helpers/vcr/vcr_mode.dart';
import '../../helpers/vcr/vcr_rest_api_client_factory.dart';

void main() {
  final environment = Platform.environment;
  final mode = vcrModeFromEnvironment(environment);

  setUpAll(() {
    getIt.registerSingleton<ConsoleModel>(ConsoleModel());
  });

  tearDownAll(() async {
    await getIt.reset();
  });

  group('provider API VCR smoke tests', () {
    _providerSmokeTest(
      name: 'Hetzner validates credentials',
      cassetteDirectory: 'test/cassettes/server_providers/hetzner',
      mode: mode,
      environment: environment,
      credentialNames: const <String>['HETZNER_API_TOKEN'],
      censorPolicy: _withJsonBodyKeys(hetznerCensorPolicy, const <String>[
        'meta',
        'servers',
      ]),
      request: (final clientFactory, final credential) async {
        final token = credential('HETZNER_API_TOKEN');
        final result = await HetznerApi(
          isWithToken: false,
          clientFactory: clientFactory,
        ).isApiTokenValid(token);
        expect(result.success, isTrue, reason: result.message);
        expect(result.data, isTrue, reason: result.message);
      },
    );

    _providerSmokeTest(
      name: 'DigitalOcean server validates credentials',
      cassetteDirectory: 'test/cassettes/server_providers/digital_ocean',
      mode: mode,
      environment: environment,
      credentialNames: const <String>['DIGITAL_OCEAN_API_TOKEN'],
      censorPolicy: _withJsonBodyKeys(
        digitalOceanServerCensorPolicy,
        const <String>['account'],
      ),
      request: (final clientFactory, final credential) async {
        final token = credential('DIGITAL_OCEAN_API_TOKEN');
        final result = await DigitalOceanApi(
          isWithToken: false,
          clientFactory: clientFactory,
        ).isApiTokenValid(token);
        expect(result.success, isTrue, reason: result.message);
        expect(result.data, isTrue, reason: result.message);
      },
    );

    _providerSmokeTest(
      name: 'Cloudflare validates credentials',
      cassetteDirectory: 'test/cassettes/dns_providers/cloudflare',
      mode: mode,
      environment: environment,
      credentialNames: const <String>['CLOUDFLARE_API_TOKEN'],
      censorPolicy: _withJsonBodyKeys(cloudflareCensorPolicy, const <String>[
        'result',
      ]),
      request: (final clientFactory, final credential) async {
        final token = credential('CLOUDFLARE_API_TOKEN');
        final result = await CloudflareApi(
          isWithToken: false,
          clientFactory: clientFactory,
        ).isApiTokenValid(token);
        expect(result.success, isTrue, reason: result.message);
        expect(result.data, isTrue, reason: result.message);
      },
    );

    _providerSmokeTest(
      name: 'deSEC validates credentials',
      cassetteDirectory: 'test/cassettes/dns_providers/desec',
      mode: mode,
      environment: environment,
      credentialNames: const <String>['DESEC_API_TOKEN'],
      censorPolicy: _withJsonBodyKeys(desecCensorPolicy, const <String>[
        'name',
      ]),
      request: (final clientFactory, final credential) async {
        final token = credential('DESEC_API_TOKEN');
        final result = await DesecApi(
          isWithToken: false,
          clientFactory: clientFactory,
        ).isApiTokenValid(token);
        expect(result.success, isTrue, reason: result.message);
        expect(result.data, isTrue, reason: result.message);
      },
    );

    _providerSmokeTest(
      name: 'DigitalOcean DNS validates credentials',
      cassetteDirectory: 'test/cassettes/dns_providers/digital_ocean',
      mode: mode,
      environment: environment,
      credentialNames: const <String>['DIGITAL_OCEAN_API_TOKEN'],
      censorPolicy: _withJsonBodyKeys(
        digitalOceanDnsCensorPolicy,
        const <String>['account'],
      ),
      request: (final clientFactory, final credential) async {
        final token = credential('DIGITAL_OCEAN_API_TOKEN');
        final result = await DigitalOceanDnsApi(
          isWithToken: false,
          clientFactory: clientFactory,
        ).isApiTokenValid(token);
        expect(result.success, isTrue, reason: result.message);
        expect(result.data, isTrue, reason: result.message);
      },
    );

    _providerSmokeTest(
      name: 'Porkbun validates credentials',
      cassetteDirectory: 'test/cassettes/dns_providers/porkbun',
      mode: mode,
      environment: environment,
      credentialNames: const <String>[
        'PORKBUN_API_KEY',
        'PORKBUN_SECRET_API_KEY',
      ],
      censorPolicy: _withJsonBodyKeys(porkbunCensorPolicy, const <String>[
        'requestId',
        'xForwardedFor',
        'yourIp',
      ]),
      request: (final clientFactory, final credential) async {
        final apiKey = credential('PORKBUN_API_KEY');
        final secretApiKey = credential('PORKBUN_SECRET_API_KEY');
        final result = await PorkbunApi(
          isWithToken: false,
          clientFactory: clientFactory,
        ).isApiTokenValid(secretApiKey, apiKey);
        expect(result.success, isTrue, reason: result.message);
        expect(result.data, isTrue, reason: result.message);
      },
    );

    _providerSmokeTest(
      name: 'Backblaze validates credentials',
      cassetteDirectory: 'test/cassettes/backups_providers/backblaze',
      mode: mode,
      environment: environment,
      credentialNames: const <String>[
        'BACKBLAZE_APPLICATION_KEY_ID',
        'BACKBLAZE_APPLICATION_KEY',
      ],
      censorPolicy: _withJsonBodyKeys(backblazeCensorPolicy, const <String>[
        'accountId',
        'apiUrl',
        'downloadUrl',
        's3ApiUrl',
      ]),
      request: (final clientFactory, final credential) async {
        final keyId = credential('BACKBLAZE_APPLICATION_KEY_ID');
        final key = credential('BACKBLAZE_APPLICATION_KEY');
        final result = await BackblazeApi(
          isWithToken: false,
          clientFactory: clientFactory,
        ).isApiTokenValid(encodedBackblazeKey(keyId, key));
        expect(result.success, isTrue, reason: result.message);
        expect(result.data, isTrue, reason: result.message);
      },
    );
  });
}

CensorPolicy _withJsonBodyKeys(
  final CensorPolicy policy,
  final List<String> jsonBodyKeys,
) => CensorPolicy(
  headerKeys: policy.headerKeys,
  jsonBodyKeys: <String>[...policy.jsonBodyKeys, ...jsonBodyKeys],
  queryKeys: policy.queryKeys,
  formBodyKeys: policy.formBodyKeys,
  urlPathPatterns: policy.urlPathPatterns,
);

void _providerSmokeTest({
  required final String name,
  required final String cassetteDirectory,
  required final Mode mode,
  required final Map<String, String> environment,
  required final List<String> credentialNames,
  required final CensorPolicy censorPolicy,
  required final Future<void> Function(
    RestApiClientFactory clientFactory,
    String Function(String name) credential,
  )
  request,
}) {
  const cassetteName = 'token_validation';
  final cassetteFile = File('$cassetteDirectory/$cassetteName.json');
  final hasCredentials = credentialNames.every(
    (final name) => environment[name]?.isNotEmpty ?? false,
  );
  final needsLiveRequest = switch (mode) {
    Mode.record || Mode.bypass => true,
    Mode.auto => !cassetteFile.existsSync(),
    Mode.replay => false,
  };
  final String? skipReason;
  if (mode == Mode.replay && !cassetteFile.existsSync()) {
    skipReason =
        'Record $cassetteFile before running this test in replay mode.';
  } else if (needsLiveRequest && !hasCredentials) {
    skipReason =
        'Set ${credentialNames.join(' and ')} to make the live request.';
  } else {
    skipReason = null;
  }

  test(name, () async {
    final cassette = Cassette(cassetteDirectory, cassetteName);
    if (mode == Mode.record) {
      cassette.erase();
    }
    final clientFactory = vcrRestApiClientFactory(
      cassette: cassette,
      mode: mode,
      censorPolicy: censorPolicy,
    );
    String credential(final String name) =>
        needsLiveRequest ? environment[name]! : 'vcr-replay-placeholder';

    await request(clientFactory, credential);
  }, skip: skipReason ?? false);
}
