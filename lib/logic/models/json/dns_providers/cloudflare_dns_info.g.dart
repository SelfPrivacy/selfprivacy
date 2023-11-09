// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloudflare_dns_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloudflareZone _$CloudflareZoneFromJson(Map<String, dynamic> json) =>
    CloudflareZone(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CloudflareZoneToJson(CloudflareZone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CloudflareDnsRecord _$CloudflareDnsRecordFromJson(Map<String, dynamic> json) =>
    CloudflareDnsRecord(
      type: json['type'] as String,
      name: json['name'] as String?,
      content: json['content'] as String?,
      zoneName: json['zone_name'] as String,
      ttl: json['ttl'] as int? ?? 3600,
      priority: json['priority'] as int? ?? 10,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$CloudflareDnsRecordToJson(
        CloudflareDnsRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'content': instance.content,
      'zone_name': instance.zoneName,
      'ttl': instance.ttl,
      'priority': instance.priority,
    };
