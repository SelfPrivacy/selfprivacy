// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_configurations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoUpgradeConfigurations _$AutoUpgradeConfigurationsFromJson(
  Map<String, dynamic> json,
) => AutoUpgradeConfigurations(
  enable: json['enable'] as bool,
  allowReboot: json['allowReboot'] as bool,
);

Map<String, dynamic> _$AutoUpgradeConfigurationsToJson(
  AutoUpgradeConfigurations instance,
) => <String, dynamic>{
  'enable': instance.enable,
  'allowReboot': instance.allowReboot,
};
