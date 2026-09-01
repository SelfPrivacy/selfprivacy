import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

const int v1ServerId = 42;
const String v1ServerToken = 'server-provider-token';
const String v1DnsToken = 'dns-provider-token';
const String v1DomainName = 'migration.example.org';
const String v1ServerLocation = 'fsn1';
const String v1ServerType = 'cx22';

Future<void> seedV1Layout() async {
  final Box<dynamic> serverInstallationBox = await Hive.openBox(
    BNames.serverInstallationBox,
  );
  final Box<dynamic> appSettingsBox = await Hive.openBox(BNames.appSettingsBox);

  final ServerProviderVolume volume = ServerProviderVolume(
    id: 84,
    name: 'migration-volume',
    sizeByte: 10 * 1024 * 1024 * 1024,
    serverId: null,
    legacyServerId: v1ServerId,
    linuxDevice: '/dev/disk/by-id/migration-volume',
    uuid: 'volume-uuid',
    location: v1ServerLocation,
  );
  final ServerHostingDetails serverDetails = ServerHostingDetails(
    ip4: '203.0.113.42',
    providerId: null,
    legacyProviderId: v1ServerId,
    createTime: DateTime.utc(2024, 6, 26),
    startTime: DateTime.utc(2024, 6, 26, 1),
    volume: volume,
    apiToken: 'server-api-token',
    provider: ServerProviderType.hetzner,
  );
  final ServerDomain serverDomain = ServerDomain(
    domainName: v1DomainName,
    provider: DnsProviderType.cloudflare,
  );
  final BackupsCredential backupsCredential = BackupsCredential(
    uuid: '',
    keyId: 'backblaze-key-id',
    applicationKey: 'backblaze-application-key',
    provider: BackupsProviderType.backblaze,
  );
  final BackblazeBucket backblazeBucket = BackblazeBucket(
    bucketId: 'backblaze-bucket-id',
    bucketName: 'migration-bucket',
    applicationKeyId: 'bucket-application-key-id',
    applicationKey: 'bucket-application-key',
    encryptionKey: 'bucket-encryption-key',
  );

  await serverInstallationBox.putAll(<String, dynamic>{
    BNames.serverDetails: serverDetails,
    BNames.hetznerKey: v1ServerToken,
    BNames.serverProvider: ServerProviderType.hetzner,
    BNames.serverLocation: v1ServerLocation,
    BNames.serverTypeIdentifier: v1ServerType,
    BNames.serverDomain: serverDomain,
    BNames.cloudFlareKey: v1DnsToken,
    BNames.dnsProvider: DnsProviderType.cloudflare,
    BNames.backblazeCredential: backupsCredential,
    BNames.backblazeBucket: backblazeBucket,
  });
  await appSettingsBox.put(BNames.databaseVersion, 1);

  await serverInstallationBox.close();
  await appSettingsBox.close();
}
