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
  HetznerIp4({
    required this.id,
    required this.ip,
    required this.blocked,
    required this.reverseDns,
  });
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
  HetznerServerTypeInfo(
    this.cores,
    this.memory,
    this.disk,
    this.prices,
    this.name,
    this.description,
    this.architecture,
  );
  final int cores;
  final num memory;
  final int disk;

  final String name;
  final String description;
  final String architecture;

  final List<HetznerPriceInfo> prices;

  static HetznerServerTypeInfo fromJson(final Map<String, dynamic> json) =>
      _$HetznerServerTypeInfoFromJson(json);
}

@JsonSerializable()
class HetznerPriceInfo {
  HetznerPriceInfo(this.hourly, this.monthly, this.location);

  @JsonKey(name: 'price_hourly', fromJson: HetznerPriceInfo.getPrice)
  final double hourly;

  @JsonKey(name: 'price_monthly', fromJson: HetznerPriceInfo.getPrice)
  final double monthly;

  final String location;

  static HetznerPriceInfo fromJson(final Map<String, dynamic> json) =>
      _$HetznerPriceInfoFromJson(json);

  static double getPrice(final Map json) =>
      double.parse(json['gross'] as String);
}

@JsonSerializable()
class HetznerLocation {
  HetznerLocation(
    this.country,
    this.city,
    this.description,
    this.zone,
    this.name,
  );

  HetznerLocation.empty() : this('', '', '', '', '');

  final String name;
  final String country;
  final String city;
  final String description;

  @JsonKey(name: 'network_zone')
  final String zone;

  static HetznerLocation fromJson(final Map<String, dynamic> json) =>
      _$HetznerLocationFromJson(json);

  String get flag {
    String emoji = '';
    switch (country.substring(0, 2)) {
      case 'DE':
        emoji = '🇩🇪';

      case 'FI':
        emoji = '🇫🇮';

      case 'US':
        emoji = '🇺🇸';
    }
    return emoji;
  }

  String get countryDisplayKey {
    String displayKey = 'countries.';
    switch (country.substring(0, 2)) {
      case 'DE':
        displayKey += 'germany';

      case 'FI':
        displayKey += 'finland';

      case 'US':
        displayKey += 'united_states';

      default:
        displayKey = country;
    }
    return displayKey;
  }
}

/// A Volume is a highly-available, scalable, and SSD-based block storage for Servers.
///
/// Pricing for Volumes depends on the Volume size and Location, not the actual used storage.
///
/// Please see Hetzner Docs for more details about Volumes.
/// https://docs.hetzner.cloud/#volumes
@JsonSerializable()
class HetznerVolume {
  HetznerVolume(
    this.id,
    this.size,
    this.serverId,
    this.name,
    this.linuxDevice,
    this.location,
  );

  /// ID of the Resource
  final int id;

  /// Size in GB of the Volume
  final int size;

  /// ID of the Server the Volume is attached to, null if it is not attached at all
  final int? serverId;

  /// Name of the Resource. Is unique per Project.
  final String name;

  /// Device path on the file system for the Volume
  @JsonKey(name: 'linux_device')
  final String? linuxDevice;

  final HetznerLocation location;

  static HetznerVolume fromJson(final Map<String, dynamic> json) =>
      _$HetznerVolumeFromJson(json);
}

/// Prices for Hetzner resources in Euro (monthly).
/// https://docs.hetzner.cloud/#pricing
class HetznerPricing {
  HetznerPricing(this.region, this.perVolumeGb, this.perPublicIpv4);

  /// Region name to which current price listing applies
  final String region;

  /// The cost of Volume per GB/month
  final double perVolumeGb;

  /// Costs of Primary IP type
  final double perPublicIpv4;
}
