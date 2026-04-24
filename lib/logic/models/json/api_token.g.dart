// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiToken _$ApiTokenFromJson(Map<String, dynamic> json) => ApiToken(
  name: json['name'] as String,
  date: DateTime.parse(json['date'] as String),
  isCaller: json['is_caller'] as bool,
);

Map<String, dynamic> _$ApiTokenToJson(ApiToken instance) => <String, dynamic>{
  'name': instance.name,
  'date': instance.date.toIso8601String(),
  'is_caller': instance.isCaller,
};
