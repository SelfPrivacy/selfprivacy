// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_upgrade_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoUpgradeSettings _$AutoUpgradeSettingsFromJson(Map<String, dynamic> json) =>
    AutoUpgradeSettings(
      enable: json['enable'] as bool,
      allowReboot: json['allowReboot'] as bool,
    );

Map<String, dynamic> _$AutoUpgradeSettingsToJson(
        AutoUpgradeSettings instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'allowReboot': instance.allowReboot,
    };
