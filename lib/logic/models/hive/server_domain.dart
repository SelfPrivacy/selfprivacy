import 'package:hive/hive.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';

part 'server_domain.g.dart';

@HiveType(typeId: 3)
class ServerDomain {
  ServerDomain({
    required this.domainName,
    required this.provider,
  });

  @HiveField(0)
  final String domainName;

  // @HiveField(1)

  @HiveField(2, defaultValue: DnsProviderType.cloudflare)
  final DnsProviderType provider;
}

@HiveType(typeId: 100)
enum DnsProviderType {
  @HiveField(0)
  unknown,
  @HiveField(1)
  cloudflare,
  @HiveField(2)
  desec,
  @HiveField(3)
  digitalOcean;

  factory DnsProviderType.fromGraphQL(final Enum$DnsProvider provider) {
    switch (provider) {
      case Enum$DnsProvider.CLOUDFLARE:
        return cloudflare;
      case Enum$DnsProvider.DESEC:
        return desec;
      case Enum$DnsProvider.DIGITALOCEAN:
        return digitalOcean;
      default:
        return unknown;
    }
  }

  String toInfectName() => switch (this) {
        digitalOcean => 'DIGITALOCEAN',
        cloudflare => 'CLOUDFLARE',
        desec => 'DESEC',
        unknown => 'UNKNOWN',
      };
}
