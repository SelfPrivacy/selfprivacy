import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:uuid/uuid.dart';

import '../../../fakes/hive/in_memory_hive.dart';

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  test('credential factories assign unique UUID v4 values', () {
    final credentials = <String>[
      ServerProviderCredential.create(
        tokenId: null,
        credentials: const BearerTokenCredential(token: 'server-token'),
        provider: ServerProviderType.hetzner,
        associatedServerUuids: [],
      ).uuid,
      DnsProviderCredential.create(
        token: 'dns-token',
        provider: DnsProviderType.cloudflare,
        associatedDomainNames: [],
      ).uuid,
      BackupsCredential.create(
        keyId: 'key-id',
        applicationKey: 'application-key',
        provider: BackupsProviderType.backblaze,
      ).uuid,
    ];

    expect(credentials.toSet(), hasLength(credentials.length));
    for (final uuid in credentials) {
      expect(Uuid.isValidUUID(fromString: uuid), isTrue);
      expect(uuid[14], '4');
    }
  });

  test('server provider credentials survive a Hive round trip', () async {
    final credentials = <ProviderCredentials>[
      const BearerTokenCredential(token: 'bearer-token'),
    ];
    final box = await Hive.openBox('provider_credentials_round_trip');
    for (var index = 0; index < credentials.length; index++) {
      await box.put(
        index,
        ServerProviderCredential(
          uuid: 'credential-$index',
          tokenId: null,
          credentials: credentials[index],
          provider: ServerProviderType.hetzner,
          associatedServerUuids: const [],
        ),
      );
    }
    await box.close();

    final reopened = await Hive.openBox('provider_credentials_round_trip');
    addTearDown(() async {
      await reopened.clear();
      await reopened.close();
    });
    final stored = List<ServerProviderCredential>.generate(
      credentials.length,
      (final index) => reopened.get(index) as ServerProviderCredential,
    );

    expect(
      stored[0].credentials,
      isA<BearerTokenCredential>().having(
        (final credential) => credential.token,
        'token',
        'bearer-token',
      ),
    );
  });
}
