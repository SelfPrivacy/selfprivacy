// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_api_tokens.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Query$GetApiTokensQuery _$Query$GetApiTokensQueryFromJson(
        Map<String, dynamic> json) =>
    Query$GetApiTokensQuery(
      api: Query$GetApiTokensQuery$api.fromJson(
          json['api'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Query$GetApiTokensQuery$api _$Query$GetApiTokensQuery$apiFromJson(
        Map<String, dynamic> json) =>
    Query$GetApiTokensQuery$api(
      devices: (json['devices'] as List<dynamic>)
          .map((e) => Query$GetApiTokensQuery$api$devices.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      $__typename: json['__typename'] as String,
    );

Query$GetApiTokensQuery$api$devices
    _$Query$GetApiTokensQuery$api$devicesFromJson(Map<String, dynamic> json) =>
        Query$GetApiTokensQuery$api$devices(
          creationDate: dateTimeFromJson(json['creationDate']),
          isCaller: json['isCaller'] as bool,
          name: json['name'] as String,
          $__typename: json['__typename'] as String,
        );
