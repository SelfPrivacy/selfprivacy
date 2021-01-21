import 'package:hive/hive.dart';

part 'cloudflare_domain.g.dart';

@HiveType(typeId: 3)
class CloudFlareDomain {
  CloudFlareDomain({this.domainName, this.zoneId});

  @HiveField(0)
  final String domainName;

  @HiveField(1)
  final String zoneId;

  @override
  String toString() {
    return '$domainName: $zoneId';
  }
}
