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

Query$GetApiVersionQuery$api _$Query$GetApiVersionQuery$apiFromJson(
        Map<String, dynamic> json) =>
    Query$GetApiVersionQuery$api(
      version: json['version'] as String,
      $__typename: json['__typename'] as String,
    );
