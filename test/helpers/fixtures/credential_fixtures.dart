import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';

ServerProviderCredential aServerProviderCredential({
  final String uuid = 'server-credential-uuid',
  final String token = 'srv-token',
  final ServerProviderType provider = ServerProviderType.hetzner,
  final String? tokenId,
  final List<String> associatedServerUuids = const [],
  final List<int> legacyAssociatedServerIds = const [],
}) => ServerProviderCredential(
  uuid: uuid,
  tokenId: tokenId,
  credentials: BearerTokenCredential(token: token),
  provider: provider,
  associatedServerUuids: [...associatedServerUuids],
  legacyAssociatedServerIds: [...legacyAssociatedServerIds],
);

DnsProviderCredential aDnsProviderCredential({
  final String uuid = 'dns-credential-uuid',
  final String token = 'dns-token',
  final DnsProviderType provider = DnsProviderType.cloudflare,
  final String? tokenId,
  final List<String> associatedDomainNames = const [],
}) => DnsProviderCredential(
  uuid: uuid,
  token: token,
  provider: provider,
  tokenId: tokenId,
  associatedDomainNames: [...associatedDomainNames],
);

BackupsCredential aBackupsCredential({
  final String uuid = 'backups-credential-uuid',
  final String keyId = 'key-id',
  final String applicationKey = 'application-key',
  final BackupsProviderType provider = BackupsProviderType.backblaze,
}) => BackupsCredential(
  uuid: uuid,
  keyId: keyId,
  applicationKey: applicationKey,
  provider: provider,
);
