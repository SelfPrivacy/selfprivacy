import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('credential factories assign unique UUID v4 values', () {
    final credentials = <String>[
      ServerProviderCredential.create(
        tokenId: null,
        token: 'server-token',
        provider: ServerProviderType.hetzner,
        associatedServerIds: [],
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
}
