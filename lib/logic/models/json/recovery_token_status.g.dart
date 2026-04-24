// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recovery_token_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecoveryKeyStatus _$RecoveryKeyStatusFromJson(Map<String, dynamic> json) =>
    RecoveryKeyStatus(
      exists: json['exists'] as bool,
      valid: json['valid'] as bool,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      expiration:
          json['expiration'] == null
              ? null
              : DateTime.parse(json['expiration'] as String),
      usesLeft: (json['uses_left'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecoveryKeyStatusToJson(RecoveryKeyStatus instance) =>
    <String, dynamic>{
      'exists': instance.exists,
      'date': instance.date?.toIso8601String(),
      'expiration': instance.expiration?.toIso8601String(),
      'uses_left': instance.usesLeft,
      'valid': instance.valid,
    };
