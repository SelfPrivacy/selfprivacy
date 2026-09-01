import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';

import '../../../../fakes/hive/in_memory_hive.dart';
import 'seed.dart';

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  test('v1 to v2 moves installation resources into resourcesBox', () async {
    await seedV1Layout();
    await Hive.openBox(BNames.serverInstallationBox);
    await Hive.openBox(BNames.resourcesBox);

    await HiveConfig.performMigrations();

    expect(
      Hive.box(BNames.appSettingsBox).get(BNames.databaseVersion),
      HiveConfig.version,
    );

    await Hive.box(BNames.resourcesBox).close();
    final Box<dynamic> resourcesBox = await Hive.openBox(BNames.resourcesBox);

    final List<ServerProviderCredential> serverCredentials =
        List<ServerProviderCredential>.from(
          resourcesBox.get(BNames.serverProviderTokens) as List<dynamic>,
        );
    expect(serverCredentials, hasLength(1));
    expect(serverCredentials.single.tokenId, isNull);
    expect(
      serverCredentials.single.credentials,
      isA<BearerTokenCredential>().having(
        (final credential) => credential.token,
        'token',
        v1ServerToken,
      ),
    );
    expect(serverCredentials.single.provider, ServerProviderType.hetzner);
    expect(serverCredentials.single.legacyAssociatedServerIds, <int>[
      v1ServerId,
    ]);
    expect(serverCredentials.single.associatedServerUuids, isEmpty);

    final List<Server> servers = List<Server>.from(
      resourcesBox.get(BNames.servers) as List<dynamic>,
    );
    expect(servers, hasLength(1));
    expect(servers.single.domain.domainName, v1DomainName);
    expect(servers.single.domain.provider, DnsProviderType.cloudflare);
    expect(servers.single.hostingDetails.legacyProviderId, v1ServerId);
    expect(servers.single.hostingDetails.providerId, isNull);
    expect(servers.single.hostingDetails.ip4, '203.0.113.42');
    expect(servers.single.hostingDetails.apiToken, 'server-api-token');
    expect(servers.single.hostingDetails.provider, ServerProviderType.hetzner);
    expect(servers.single.hostingDetails.serverLocation, v1ServerLocation);
    expect(servers.single.hostingDetails.serverType, v1ServerType);
    expect(servers.single.hostingDetails.volume.id, 84);
    expect(servers.single.hostingDetails.volume.uuid, 'volume-uuid');
    expect(servers.single.hostingDetails.volume.legacyServerId, v1ServerId);
    expect(servers.single.hostingDetails.volume.serverId, isNull);

    final List<DnsProviderCredential> dnsCredentials =
        List<DnsProviderCredential>.from(
          resourcesBox.get(BNames.dnsProviderTokens) as List<dynamic>,
        );
    expect(dnsCredentials, hasLength(1));
    expect(dnsCredentials.single.tokenId, isNull);
    expect(dnsCredentials.single.token, v1DnsToken);
    expect(dnsCredentials.single.provider, DnsProviderType.cloudflare);
    expect(dnsCredentials.single.associatedDomainNames, <String>[v1DomainName]);

    final List<BackupsCredential> backupsCredentials =
        List<BackupsCredential>.from(
          resourcesBox.get(BNames.backupsProviderTokens) as List<dynamic>,
        );
    expect(backupsCredentials, hasLength(1));
    expect(backupsCredentials.single.keyId, 'backblaze-key-id');
    expect(
      backupsCredentials.single.applicationKey,
      'backblaze-application-key',
    );
    expect(backupsCredentials.single.provider, BackupsProviderType.backblaze);

    final BackblazeBucket bucket = resourcesBox.get(BNames.backblazeBucket);
    expect(bucket.bucketId, 'backblaze-bucket-id');
    expect(bucket.bucketName, 'migration-bucket');
    expect(bucket.applicationKeyId, 'bucket-application-key-id');
    expect(bucket.applicationKey, 'bucket-application-key');
    expect(bucket.encryptionKey, 'bucket-encryption-key');

    final Box<dynamic> serverInstallationBox = Hive.box(
      BNames.serverInstallationBox,
    );
    expect(serverInstallationBox.get(BNames.hetznerKey), v1ServerToken);
    expect(serverInstallationBox.get(BNames.cloudFlareKey), v1DnsToken);
  });
}
