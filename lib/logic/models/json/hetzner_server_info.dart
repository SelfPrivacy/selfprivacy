import 'package:json_annotation/json_annotation.dart';

part 'hetzner_server_info.g.dart';

@JsonSerializable()
class HetznerServerInfo {
  HetznerServerInfo(
    this.id,
    this.name,
    this.status,
    this.created,
    this.serverType,
    this.location,
    this.publicNet,
    this.volumes,
  );
  final int id;
  final String name;
  final ServerStatus status;
  final DateTime created;
  final List<int> volumes;

  @JsonKey(name: 'server_type')
  final HetznerServerTypeInfo serverType;

  @JsonKey(name: 'datacenter', fromJson: HetznerServerInfo.locationFromJson)
  final HetznerLocation location;

  @JsonKey(name: 'public_net')
  final HetznerPublicNetInfo publicNet;

  static HetznerLocation locationFromJson(final Map json) =>
      HetznerLocation.fromJson(json['location']);

  static HetznerServerInfo fromJson(final Map<String, dynamic> json) =>
      _$HetznerServerInfoFromJson(json);
}

@JsonSerializable()
class HetznerPublicNetInfo {
  HetznerPublicNetInfo(this.ipv4);
  final HetznerIp4? ipv4;

  static HetznerPublicNetInfo fromJson(final Map<String, dynamic> json) =>
      _$HetznerPublicNetInfoFromJson(json);
}

@JsonSerializable()
class HetznerIp4 {
  HetznerIp4(this.id, this.ip, this.blocked, this.reverseDns);
  final bool blocked;
  @JsonKey(name: 'dns_ptr')
  final String reverseDns;
  final int id;
  final String ip;

  static HetznerIp4 fromJson(final Map<String, dynamic> json) =>
      _$HetznerIp4FromJson(json);
}

enum ServerStatus {
  running,
  initializing,
  starting,
  stopping,
  off,
  deleting,
  migrating,
  rebuilding,
  unknown,
}

@JsonSerializable()
class HetznerServerTypeInfo {
  HetznerServerTypeInfo(this.cores, this.memory, this.disk, this.prices);
  final int cores;
  final num memory;
  final int disk;

  final List<HetznerPriceInfo> prices;

  static HetznerServerTypeInfo fromJson(final Map<String, dynamic> json) =>
      _$HetznerServerTypeInfoFromJson(json);
}

@JsonSerializable()
class HetznerPriceInfo {
  HetznerPriceInfo(this.hourly, this.monthly);

  @JsonKey(name: 'price_hourly', fromJson: HetznerPriceInfo.getPrice)
  final double hourly;

  @JsonKey(name: 'price_monthly', fromJson: HetznerPriceInfo.getPrice)
  final double monthly;

  static HetznerPriceInfo fromJson(final Map<String, dynamic> json) =>
      _$HetznerPriceInfoFromJson(json);

  static double getPrice(final Map json) =>
      double.parse(json['gross'] as String);
}

@JsonSerializable()
class HetznerLocation {
  HetznerLocation(this.country, this.city, this.description, this.zone);
  final String country;
  final String city;
  final String description;

  @JsonKey(name: 'network_zone')
  final String zone;

  static HetznerLocation fromJson(final Map<String, dynamic> json) =>
      _$HetznerLocationFromJson(json);
}
