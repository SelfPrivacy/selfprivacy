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
      (json['droplet_ids'] as List<dynamic>).map((e) => e as int).toList(),
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
