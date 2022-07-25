// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Input$RecoveryKeyLimitsInput _$Input$RecoveryKeyLimitsInputFromJson(
        Map<String, dynamic> json) =>
    Input$RecoveryKeyLimitsInput(
      expirationDate: _nullable$dateTimeFromJson(json['expirationDate']),
      uses: json['uses'] as int?,
    );

Map<String, dynamic> _$Input$RecoveryKeyLimitsInputToJson(
        Input$RecoveryKeyLimitsInput instance) =>
    <String, dynamic>{
      'expirationDate': _nullable$dateTimeToJson(instance.expirationDate),
      'uses': instance.uses,
    };

Input$UseNewDeviceKeyInput _$Input$UseNewDeviceKeyInputFromJson(
        Map<String, dynamic> json) =>
    Input$UseNewDeviceKeyInput(
      key: json['key'] as String,
      deviceName: json['deviceName'] as String,
    );

Map<String, dynamic> _$Input$UseNewDeviceKeyInputToJson(
        Input$UseNewDeviceKeyInput instance) =>
    <String, dynamic>{
      'key': instance.key,
      'deviceName': instance.deviceName,
    };

Input$UseRecoveryKeyInput _$Input$UseRecoveryKeyInputFromJson(
        Map<String, dynamic> json) =>
    Input$UseRecoveryKeyInput(
      key: json['key'] as String,
      deviceName: json['deviceName'] as String,
    );

Map<String, dynamic> _$Input$UseRecoveryKeyInputToJson(
        Input$UseRecoveryKeyInput instance) =>
    <String, dynamic>{
      'key': instance.key,
      'deviceName': instance.deviceName,
    };
