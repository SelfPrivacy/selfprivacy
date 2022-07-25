// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_api_version.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Query$GetApiVersionQuery _$Query$GetApiVersionQueryFromJson(
        Map<String, dynamic> json) =>
    Query$GetApiVersionQuery(
      api: Query$GetApiVersionQuery$api.fromJson(
          json['api'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetApiVersionQueryToJson(
        Query$GetApiVersionQuery instance) =>
    <String, dynamic>{
      'api': instance.api.toJson(),
      '__typename': instance.$__typename,
    };

Query$GetApiVersionQuery$api _$Query$GetApiVersionQuery$apiFromJson(
        Map<String, dynamic> json) =>
    Query$GetApiVersionQuery$api(
      version: json['version'] as String,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetApiVersionQuery$apiToJson(
        Query$GetApiVersionQuery$api instance) =>
    <String, dynamic>{
      'version': instance.version,
      '__typename': instance.$__typename,
    };
