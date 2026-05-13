// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'porkbun_dns_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PorkbunDomain _$PorkbunDomainFromJson(Map<String, dynamic> json) =>
    PorkbunDomain(
      domain: json['domain'] as String,
      createDate: json['createDate'] as String,
      expireDate: json['expireDate'] as String,
      status: json['status'] as String,
      tld: json['tld'] as String,
    );

Map<String, dynamic> _$PorkbunDomainToJson(PorkbunDomain instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'createDate': instance.createDate,
      'expireDate': instance.expireDate,
      'status': instance.status,
      'tld': instance.tld,
    };

PorkbunDnsRecord _$PorkbunDnsRecordFromJson(Map<String, dynamic> json) =>
    PorkbunDnsRecord(
      content: json['content'] as String,
      name: json['name'] as String,
      ttl: json['ttl'] as String,
      type: json['type'] as String,
      id: json['id'] as String?,
      notes: json['notes'] as String?,
      prio: json['prio'] as String?,
    );

Map<String, dynamic> _$PorkbunDnsRecordToJson(PorkbunDnsRecord instance) =>
    <String, dynamic>{
      'content': instance.content,
      'id': instance.id,
      'name': instance.name,
      'notes': instance.notes,
      'prio': instance.prio,
      'ttl': instance.ttl,
      'type': instance.type,
    };
