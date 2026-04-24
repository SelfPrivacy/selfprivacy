// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dns_records.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DnsRecord _$DnsRecordFromJson(Map<String, dynamic> json) => DnsRecord(
  type: json['type'] as String,
  name: json['name'] as String?,
  content: json['content'] as String?,
  displayName: json['displayName'] as String?,
  ttl: (json['ttl'] as num?)?.toInt() ?? 3600,
  priority: (json['priority'] as num?)?.toInt() ?? 10,
  proxied: json['proxied'] as bool? ?? false,
);

Map<String, dynamic> _$DnsRecordToJson(DnsRecord instance) => <String, dynamic>{
  'type': instance.type,
  'displayName': instance.displayName,
  'name': instance.name,
  'content': instance.content,
  'ttl': instance.ttl,
  'priority': instance.priority,
  'proxied': instance.proxied,
};
