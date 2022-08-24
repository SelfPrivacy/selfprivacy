// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Input$AutoUpgradeSettingsInput _$Input$AutoUpgradeSettingsInputFromJson(
        Map<String, dynamic> json) =>
    Input$AutoUpgradeSettingsInput(
      enableAutoUpgrade: json['enableAutoUpgrade'] as bool?,
      allowReboot: json['allowReboot'] as bool?,
    );

Map<String, dynamic> _$Input$AutoUpgradeSettingsInputToJson(
        Input$AutoUpgradeSettingsInput instance) =>
    <String, dynamic>{
      'enableAutoUpgrade': instance.enableAutoUpgrade,
      'allowReboot': instance.allowReboot,
    };

Input$MigrateToBindsInput _$Input$MigrateToBindsInputFromJson(
        Map<String, dynamic> json) =>
    Input$MigrateToBindsInput(
      emailBlockDevice: json['emailBlockDevice'] as String,
      bitwardenBlockDevice: json['bitwardenBlockDevice'] as String,
      giteaBlockDevice: json['giteaBlockDevice'] as String,
      nextcloudBlockDevice: json['nextcloudBlockDevice'] as String,
      pleromaBlockDevice: json['pleromaBlockDevice'] as String,
    );

Map<String, dynamic> _$Input$MigrateToBindsInputToJson(
        Input$MigrateToBindsInput instance) =>
    <String, dynamic>{
      'emailBlockDevice': instance.emailBlockDevice,
      'bitwardenBlockDevice': instance.bitwardenBlockDevice,
      'giteaBlockDevice': instance.giteaBlockDevice,
      'nextcloudBlockDevice': instance.nextcloudBlockDevice,
      'pleromaBlockDevice': instance.pleromaBlockDevice,
    };

Input$MoveServiceInput _$Input$MoveServiceInputFromJson(
        Map<String, dynamic> json) =>
    Input$MoveServiceInput(
      serviceId: json['serviceId'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$Input$MoveServiceInputToJson(
        Input$MoveServiceInput instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'location': instance.location,
    };

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

Input$SshMutationInput _$Input$SshMutationInputFromJson(
        Map<String, dynamic> json) =>
    Input$SshMutationInput(
      username: json['username'] as String,
      sshKey: json['sshKey'] as String,
    );

Map<String, dynamic> _$Input$SshMutationInputToJson(
        Input$SshMutationInput instance) =>
    <String, dynamic>{
      'username': instance.username,
      'sshKey': instance.sshKey,
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

Input$UserMutationInput _$Input$UserMutationInputFromJson(
        Map<String, dynamic> json) =>
    Input$UserMutationInput(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$Input$UserMutationInputToJson(
        Input$UserMutationInput instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
