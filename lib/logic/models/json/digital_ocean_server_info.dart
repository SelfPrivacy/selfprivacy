import 'package:json_annotation/json_annotation.dart';

part 'digital_ocean_server_info.g.dart';

@JsonSerializable()
class DigitalOceanVolume {
  DigitalOceanVolume(
    this.id,
    this.name,
    this.sizeGigabytes,
    this.dropletIds,
    this.region,
  );

  final String id;
  final String name;

  @JsonKey(name: 'droplet_ids')
  final List<int>? dropletIds;

  @JsonKey(name: 'size_gigabytes')
  final int sizeGigabytes;

  final DigitalOceanLocation region;

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

  String get flag {
    String emoji = '';

    switch (slug.substring(0, 3)) {
      case 'fra':
        emoji = '🇩🇪';
        break;

      case 'ams':
        emoji = '🇳🇱';
        break;

      case 'sgp':
        emoji = '🇸🇬';
        break;

      case 'lon':
        emoji = '🇬🇧';
        break;

      case 'tor':
        emoji = '🇨🇦';
        break;

      case 'blr':
        emoji = '🇮🇳';
        break;

      case 'syd':
        emoji = '🇦🇺';
        break;

      case 'nyc':
      case 'sfo':
        emoji = '🇺🇸';
        break;
    }
    return emoji;
  }

  static const _townPrefixToCountryMap = {
    'fra': 'germany',
    'ams': 'netherlands',
    'sgp': 'singapore',
    'lon': 'united_kingdom',
    'tor': 'canada',
    'blr': 'india',
    'syd': 'australia',
    'nyc': 'united_states',
    'sfo': 'united_states',
  };

  String get countryDisplayKey {
    final countryName = _townPrefixToCountryMap[slug.substring(0, 3)] ?? slug;
    return 'countries.$countryName';
  }
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
