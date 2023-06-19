import 'package:json_annotation/json_annotation.dart';

part 'digital_ocean_server_info.g.dart';

@JsonSerializable()
class DigitalOceanVolume {
  DigitalOceanVolume(
    this.id,
    this.name,
    this.sizeGigabytes,
    this.dropletIds,
  );

  final String id;
  final String name;

  @JsonKey(name: 'droplet_ids')
  final List<int>? dropletIds;

  @JsonKey(name: 'size_gigabytes')
  final int sizeGigabytes;

  static DigitalOceanVolume fromJson(final Map<String, dynamic> json) =>
      _$DigitalOceanVolumeFromJson(json);
}

@JsonSerializable()
class DigitalOceanLocation {
  DigitalOceanLocation(
    this.slug,
    this.name,
  );

  final String slug;
  final String name;

  static DigitalOceanLocation fromJson(final Map<String, dynamic> json) =>
      _$DigitalOceanLocationFromJson(json);
}

@JsonSerializable()
class DigitalOceanServerType {
  DigitalOceanServerType(
    this.regions,
    this.memory,
    this.description,
    this.disk,
    this.priceMonthly,
    this.slug,
    this.vcpus,
  );

  final List<String> regions;
  final double memory;
  final String slug;
  final String description;
  final int vcpus;
  final int disk;

  @JsonKey(name: 'price_monthly')
  final double priceMonthly;

  static DigitalOceanServerType fromJson(final Map<String, dynamic> json) =>
      _$DigitalOceanServerTypeFromJson(json);
}
