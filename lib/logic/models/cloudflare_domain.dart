import 'package:hive/hive.dart';

part 'cloudflare_domain.g.dart';

@HiveType(typeId: 3)
class CloudFlareDomain {
  CloudFlareDomain({this.name, this.zoneId});

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String zoneId;

  @override
  String toString() {
    return '$name: $zoneId';
  }
}
