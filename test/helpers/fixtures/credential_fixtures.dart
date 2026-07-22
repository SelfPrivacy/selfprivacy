import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';

ServerProviderCredential aServerProviderCredential({
  final String token = 'srv-token',
  final ServerProviderType provider = ServerProviderType.hetzner,
  final String? tokenId,
  final List<int> associatedServerIds = const [],
}) => ServerProviderCredential(
  tokenId: tokenId,
  token: token,
  provider: provider,
  associatedServerIds: [...associatedServerIds],
);

DnsProviderCredential aDnsProviderCredential({
  final String token = 'dns-token',
  final DnsProviderType provider = DnsProviderType.cloudflare,
  final String? tokenId,
  final List<String> associatedDomainNames = const [],
}) => DnsProviderCredential(
  token: token,
  provider: provider,
  tokenId: tokenId,
  associatedDomainNames: [...associatedDomainNames],
);
