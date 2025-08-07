import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';

part 'server_domain.g.dart';

@HiveType(typeId: 3)
class ServerDomain {
  ServerDomain({required this.domainName, required this.provider});

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
      case Enum$DnsProvider.$unknown:
        return unknown;
    }
  }

  String toInfectName() => switch (this) {
    digitalOcean => 'DIGITALOCEAN',
    cloudflare => 'CLOUDFLARE',
    desec => 'DESEC',
    unknown => 'UNKNOWN',
  };

  String get displayName => switch (this) {
    digitalOcean => 'Digital Ocean DNS',
    cloudflare => 'Cloudflare',
    desec => 'deSEC',
    unknown => 'Unknown',
  };

  String get supportArticle => switch (this) {
    digitalOcean => 'how_digital_ocean',
    cloudflare => 'how_cloudflare',
    desec => 'how_desec',
    unknown => '',
  };
}

extension DnsProviderTypeIsSpecified on DnsProviderType? {
  bool get isSpecified => this != null && this != DnsProviderType.unknown;
}
