// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_ocean_server_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitalOceanVolume _$DigitalOceanVolumeFromJson(Map<String, dynamic> json) =>
    DigitalOceanVolume(
      json['id'] as String,
      json['name'] as String,
      json['size_gigabytes'] as int,
      (json['droplet_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$DigitalOceanVolumeToJson(DigitalOceanVolume instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'droplet_ids': instance.dropletIds,
      'size_gigabytes': instance.sizeGigabytes,
    };

DigitalOceanLocation _$DigitalOceanLocationFromJson(
        Map<String, dynamic> json) =>
    DigitalOceanLocation(
      json['slug'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$DigitalOceanLocationToJson(
        DigitalOceanLocation instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
    };

DigitalOceanServerType _$DigitalOceanServerTypeFromJson(
        Map<String, dynamic> json) =>
    DigitalOceanServerType(
      (json['regions'] as List<dynamic>).map((e) => e as String).toList(),
      (json['memory'] as num).toDouble(),
      json['description'] as String,
      json['disk'] as int,
      (json['price_monthly'] as num).toDouble(),
      json['slug'] as String,
      json['vcpus'] as int,
    );

Map<String, dynamic> _$DigitalOceanServerTypeToJson(
        DigitalOceanServerType instance) =>
    <String, dynamic>{
      'regions': instance.regions,
      'memory': instance.memory,
      'slug': instance.slug,
      'description': instance.description,
      'vcpus': instance.vcpus,
      'disk': instance.disk,
      'price_monthly': instance.priceMonthly,
    };
