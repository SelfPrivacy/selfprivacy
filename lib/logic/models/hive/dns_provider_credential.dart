import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

part 'dns_provider_credential.g.dart';

// TODO(inex): Make a constant type.
@HiveType(typeId: 8)
class DnsProviderCredential {
  DnsProviderCredential({
    required this.tokenId,
    required this.token,
    required this.provider,
    required this.associatedDomainNames,
  });

  @HiveField(0)
  final String? tokenId;

  @HiveField(1)
  final String token;

  @HiveField(2)
  final DnsProviderType provider;

  @HiveField(3)
  final List<String> associatedDomainNames;
}
