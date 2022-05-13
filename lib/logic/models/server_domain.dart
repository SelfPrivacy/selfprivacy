import 'package:hive/hive.dart';

part 'server_domain.g.dart';

enum DnsProvider {
  Unknown,
  Cloudflare,
}

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

  @HiveField(2, defaultValue: DnsProvider.Cloudflare)
  final DnsProvider provider;

  @override
  String toString() {
    return '$domainName: $zoneId';
  }
}
