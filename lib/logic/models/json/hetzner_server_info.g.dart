// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hetzner_server_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HetznerServerInfo _$HetznerServerInfoFromJson(
  Map<String, dynamic> json,
) => HetznerServerInfo(
  (json['id'] as num).toInt(),
  json['name'] as String,
  $enumDecode(_$ServerStatusEnumMap, json['status']),
  DateTime.parse(json['created'] as String),
  HetznerServerTypeInfo.fromJson(json['server_type'] as Map<String, dynamic>),
  HetznerServerInfo.locationFromJson(json['datacenter'] as Map),
  HetznerPublicNetInfo.fromJson(json['public_net'] as Map<String, dynamic>),
  (json['volumes'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
);

Map<String, dynamic> _$HetznerServerInfoToJson(HetznerServerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': _$ServerStatusEnumMap[instance.status]!,
      'created': instance.created.toIso8601String(),
      'volumes': instance.volumes,
      'server_type': instance.serverType,
      'datacenter': instance.location,
      'public_net': instance.publicNet,
    };

const _$ServerStatusEnumMap = {
  ServerStatus.running: 'running',
  ServerStatus.initializing: 'initializing',
  ServerStatus.starting: 'starting',
  ServerStatus.stopping: 'stopping',
  ServerStatus.off: 'off',
  ServerStatus.deleting: 'deleting',
  ServerStatus.migrating: 'migrating',
  ServerStatus.rebuilding: 'rebuilding',
  ServerStatus.unknown: 'unknown',
};

HetznerPublicNetInfo _$HetznerPublicNetInfoFromJson(
  Map<String, dynamic> json,
) => HetznerPublicNetInfo(
  json['ipv4'] == null
      ? null
      : HetznerIp4.fromJson(json['ipv4'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HetznerPublicNetInfoToJson(
  HetznerPublicNetInfo instance,
) => <String, dynamic>{'ipv4': instance.ipv4};

HetznerIp4 _$HetznerIp4FromJson(Map<String, dynamic> json) => HetznerIp4(
  id: (json['id'] as num).toInt(),
  ip: json['ip'] as String,
  blocked: json['blocked'] as bool,
  reverseDns: json['dns_ptr'] as String,
);

Map<String, dynamic> _$HetznerIp4ToJson(HetznerIp4 instance) =>
    <String, dynamic>{
      'blocked': instance.blocked,
      'dns_ptr': instance.reverseDns,
      'id': instance.id,
      'ip': instance.ip,
    };

HetznerServerTypeInfo _$HetznerServerTypeInfoFromJson(
  Map<String, dynamic> json,
) => HetznerServerTypeInfo(
  (json['cores'] as num).toInt(),
  json['memory'] as num,
  (json['disk'] as num).toInt(),
  (json['prices'] as List<dynamic>)
      .map((e) => HetznerPriceInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['name'] as String,
  json['description'] as String,
  json['architecture'] as String,
);

Map<String, dynamic> _$HetznerServerTypeInfoToJson(
  HetznerServerTypeInfo instance,
) => <String, dynamic>{
  'cores': instance.cores,
  'memory': instance.memory,
  'disk': instance.disk,
  'name': instance.name,
  'description': instance.description,
  'architecture': instance.architecture,
  'prices': instance.prices,
};

HetznerPriceInfo _$HetznerPriceInfoFromJson(Map<String, dynamic> json) =>
    HetznerPriceInfo(
      HetznerPriceInfo.getPrice(json['price_hourly'] as Map),
      HetznerPriceInfo.getPrice(json['price_monthly'] as Map),
      json['location'] as String,
    );

Map<String, dynamic> _$HetznerPriceInfoToJson(HetznerPriceInfo instance) =>
    <String, dynamic>{
      'price_hourly': instance.hourly,
      'price_monthly': instance.monthly,
      'location': instance.location,
    };

HetznerLocation _$HetznerLocationFromJson(Map<String, dynamic> json) =>
    HetznerLocation(
      json['country'] as String,
      json['city'] as String,
      json['description'] as String,
      json['network_zone'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$HetznerLocationToJson(HetznerLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'city': instance.city,
      'description': instance.description,
      'network_zone': instance.zone,
    };

HetznerVolume _$HetznerVolumeFromJson(Map<String, dynamic> json) =>
    HetznerVolume(
      (json['id'] as num).toInt(),
      (json['size'] as num).toInt(),
      (json['serverId'] as num?)?.toInt(),
      json['name'] as String,
      json['linux_device'] as String?,
      HetznerLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HetznerVolumeToJson(HetznerVolume instance) =>
    <String, dynamic>{
      'id': instance.id,
      'size': instance.size,
      'serverId': instance.serverId,
      'name': instance.name,
      'linux_device': instance.linuxDevice,
      'location': instance.location,
    };
