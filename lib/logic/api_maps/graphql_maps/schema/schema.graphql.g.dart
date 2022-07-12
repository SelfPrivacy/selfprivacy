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

Input$UseNewDeviceKeyInput _$Input$UseNewDeviceKeyInputFromJson(
        Map<String, dynamic> json) =>
    Input$UseNewDeviceKeyInput(
      key: json['key'] as String,
      deviceName: json['deviceName'] as String,
    );

Input$UseRecoveryKeyInput _$Input$UseRecoveryKeyInputFromJson(
        Map<String, dynamic> json) =>
    Input$UseRecoveryKeyInput(
      key: json['key'] as String,
      deviceName: json['deviceName'] as String,
    );
