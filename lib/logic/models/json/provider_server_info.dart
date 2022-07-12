import 'package:json_annotation/json_annotation.dart';

part 'provider_server_info.g.dart';

@JsonSerializable()
class ProviderServerInfo {
  ProviderServerInfo(
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
  final ProviderServerTypeInfo serverType;

  @JsonKey(name: 'datacenter', fromJson: ProviderServerInfo.locationFromJson)
  final ProviderLocation location;

  @JsonKey(name: 'public_net')
  final ProviderPublicNetInfo publicNet;

  static ProviderLocation locationFromJson(final Map json) =>
      ProviderLocation.fromJson(json['location']);

  static ProviderServerInfo fromJson(final Map<String, dynamic> json) =>
      _$ProviderServerInfoFromJson(json);
}

@JsonSerializable()
class ProviderPublicNetInfo {
  ProviderPublicNetInfo(this.ipv4);
  final ProviderIp4 ipv4;

  static ProviderPublicNetInfo fromJson(final Map<String, dynamic> json) =>
      _$ProviderPublicNetInfoFromJson(json);
}

@JsonSerializable()
class ProviderIp4 {
  ProviderIp4(this.id, this.ip, this.blocked, this.reverseDns);
  final bool blocked;
  @JsonKey(name: 'dns_ptr')
  final String reverseDns;
  final int id;
  final String ip;

  static ProviderIp4 fromJson(final Map<String, dynamic> json) =>
      _$ProviderIp4FromJson(json);
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
class ProviderServerTypeInfo {
  ProviderServerTypeInfo(this.cores, this.memory, this.disk, this.prices);
  final int cores;
  final num memory;
  final int disk;

  final List<ProviderPriceInfo> prices;

  static ProviderServerTypeInfo fromJson(final Map<String, dynamic> json) =>
      _$ProviderServerTypeInfoFromJson(json);
}

@JsonSerializable()
class ProviderPriceInfo {
  ProviderPriceInfo(this.hourly, this.monthly);

  @JsonKey(name: 'price_hourly', fromJson: ProviderPriceInfo.getPrice)
  final double hourly;

  @JsonKey(name: 'price_monthly', fromJson: ProviderPriceInfo.getPrice)
  final double monthly;

  static ProviderPriceInfo fromJson(final Map<String, dynamic> json) =>
      _$ProviderPriceInfoFromJson(json);

  static double getPrice(final Map json) =>
      double.parse(json['gross'] as String);
}

@JsonSerializable()
class ProviderLocation {
  ProviderLocation(this.country, this.city, this.description, this.zone);
  final String country;
  final String city;
  final String description;

  @JsonKey(name: 'network_zone')
  final String zone;

  static ProviderLocation fromJson(final Map<String, dynamic> json) =>
      _$ProviderLocationFromJson(json);
}
