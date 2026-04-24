// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_ocean_dns_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitalOceanDomain _$DigitalOceanDomainFromJson(Map<String, dynamic> json) =>
    DigitalOceanDomain(
      name: json['name'] as String,
      ttl: (json['ttl'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DigitalOceanDomainToJson(DigitalOceanDomain instance) =>
    <String, dynamic>{'name': instance.name, 'ttl': instance.ttl};

DigitalOceanDnsRecord _$DigitalOceanDnsRecordFromJson(
  Map<String, dynamic> json,
) => DigitalOceanDnsRecord(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  type: json['type'] as String,
  ttl: (json['ttl'] as num).toInt(),
  data: json['data'] as String,
  priority: (json['priority'] as num?)?.toInt(),
  flags: (json['flags'] as num?)?.toInt(),
  tag: json['tag'] as String?,
);

Map<String, dynamic> _$DigitalOceanDnsRecordToJson(
  DigitalOceanDnsRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': instance.type,
  'ttl': instance.ttl,
  'data': instance.data,
  'priority': instance.priority,
  'flags': instance.flags,
  'tag': instance.tag,
};
