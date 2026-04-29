import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

part 'dns_provider_credential.g.dart';

// TODO(inex): Make a constant type.
@HiveType(typeId: 8)
class DnsProviderCredential {
  DnsProviderCredential({
    required this.token,
    required this.provider,
    required this.associatedDomainNames,
    this.tokenId,
    this.url,
    this.tenant,
    this.secondaryToken,
  });

  @HiveField(0)
  final String? tokenId;

  @HiveField(1)
  final String token;

  @HiveField(4)
  final String? url;

  @HiveField(5)
  final String? tenant;

  @HiveField(6)
  final String? secondaryToken;

  @HiveField(2)
  final DnsProviderType provider;

  @HiveField(3)
  final List<String> associatedDomainNames;
}
