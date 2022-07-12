// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_server_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderServerInfo _$ProviderServerInfoFromJson(Map<String, dynamic> json) =>
    ProviderServerInfo(
      json['id'] as int,
      json['name'] as String,
      $enumDecode(_$ServerStatusEnumMap, json['status']),
      DateTime.parse(json['created'] as String),
      ProviderServerTypeInfo.fromJson(
          json['server_type'] as Map<String, dynamic>),
      ProviderServerInfo.locationFromJson(json['datacenter'] as Map),
      ProviderPublicNetInfo.fromJson(
          json['public_net'] as Map<String, dynamic>),
      (json['volumes'] as List<dynamic>).map((e) => e as int).toList(),
    );

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

ProviderPublicNetInfo _$ProviderPublicNetInfoFromJson(
        Map<String, dynamic> json) =>
    ProviderPublicNetInfo(
      ProviderIp4.fromJson(json['ipv4'] as Map<String, dynamic>),
    );

ProviderIp4 _$ProviderIp4FromJson(Map<String, dynamic> json) => ProviderIp4(
      json['id'] as int,
      json['ip'] as String,
      json['blocked'] as bool,
      json['dns_ptr'] as String,
    );

ProviderServerTypeInfo _$ProviderServerTypeInfoFromJson(
        Map<String, dynamic> json) =>
    ProviderServerTypeInfo(
      json['cores'] as int,
      json['memory'] as num,
      json['disk'] as int,
      (json['prices'] as List<dynamic>)
          .map((e) => ProviderPriceInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ProviderPriceInfo _$ProviderPriceInfoFromJson(Map<String, dynamic> json) =>
    ProviderPriceInfo(
      ProviderPriceInfo.getPrice(json['price_hourly'] as Map),
      ProviderPriceInfo.getPrice(json['price_monthly'] as Map),
    );

ProviderLocation _$ProviderLocationFromJson(Map<String, dynamic> json) =>
    ProviderLocation(
      json['country'] as String,
      json['city'] as String,
      json['description'] as String,
      json['network_zone'] as String,
    );
