// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hetzner_server_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HetznerServerInfo _$HetznerServerInfoFromJson(Map<String, dynamic> json) {
  return HetznerServerInfo(
    json['id'] as int,
    json['name'] as String,
    _$enumDecode(_$ServerStatusEnumMap, json['status']),
    DateTime.parse(json['created'] as String),
    HetznerServerTypeInfo.fromJson(json['server_type'] as Map<String, dynamic>),
    HetznerServerInfo.locationFromJson(json['datacenter'] as Map),
  );
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

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

HetznerServerTypeInfo _$HetznerServerTypeInfoFromJson(
    Map<String, dynamic> json) {
  return HetznerServerTypeInfo(
    json['cores'] as int,
    json['memory'] as num,
    json['disk'] as int,
    (json['prices'] as List<dynamic>)
        .map((e) => HetznerPriceInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

HetznerPriceInfo _$HetznerPriceInfoFromJson(Map<String, dynamic> json) {
  return HetznerPriceInfo(
    HetznerPriceInfo.getPrice(json['price_hourly'] as Map),
    HetznerPriceInfo.getPrice(json['price_monthly'] as Map),
  );
}

HetznerLocation _$HetznerLocationFromJson(Map<String, dynamic> json) {
  return HetznerLocation(
    json['country'] as String,
    json['city'] as String,
    json['description'] as String,
    json['network_zone'] as String,
  );
}
