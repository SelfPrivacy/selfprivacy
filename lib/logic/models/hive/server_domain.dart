import 'package:hive/hive.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';

part 'server_domain.g.dart';

@HiveType(typeId: 3)
class ServerDomain {
  ServerDomain({
    required this.domainName,
    required this.zoneId,
    required this.provider,
  });

  @HiveField(0)
  final String domainName;

  @HiveField(1)
  final String zoneId;

  @HiveField(2, defaultValue: DnsProvider.cloudflare)
  final DnsProvider provider;

  @override
  String toString() => '$domainName: $zoneId';
}

@HiveType(typeId: 100)
enum DnsProvider {
  @HiveField(0)
  unknown,
  @HiveField(1)
  cloudflare,
  @HiveField(2)
  digitalOcean;

  factory DnsProvider.fromGraphQL(final Enum$DnsProvider provider) {
    switch (provider) {
      case Enum$DnsProvider.CLOUDFLARE:
        return cloudflare;
      case Enum$DnsProvider.DIGITALOCEAN:
        return digitalOcean;
      default:
        return unknown;
    }
  }
}
