// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desec_dns_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DesecDomain _$DesecDomainFromJson(Map<String, dynamic> json) => DesecDomain(
  name: json['name'] as String,
  minimumTtl: (json['minimum_ttl'] as num?)?.toInt(),
);

Map<String, dynamic> _$DesecDomainToJson(DesecDomain instance) =>
    <String, dynamic>{
      'name': instance.name,
      'minimum_ttl': instance.minimumTtl,
    };

DesecDnsRecord _$DesecDnsRecordFromJson(Map<String, dynamic> json) =>
    DesecDnsRecord(
      subname: json['subname'] as String,
      type: json['type'] as String,
      ttl: (json['ttl'] as num).toInt(),
      records:
          (json['records'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DesecDnsRecordToJson(DesecDnsRecord instance) =>
    <String, dynamic>{
      'subname': instance.subname,
      'type': instance.type,
      'ttl': instance.ttl,
      'records': instance.records,
    };
