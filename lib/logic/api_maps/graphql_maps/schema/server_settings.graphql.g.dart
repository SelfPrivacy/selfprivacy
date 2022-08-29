// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_settings.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fragment$basicMutationReturnFields _$Fragment$basicMutationReturnFieldsFromJson(
        Map<String, dynamic> json) =>
    Fragment$basicMutationReturnFields(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Fragment$basicMutationReturnFieldsToJson(
        Fragment$basicMutationReturnFields instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Query$SystemSettings _$Query$SystemSettingsFromJson(
        Map<String, dynamic> json) =>
    Query$SystemSettings(
      system: Query$SystemSettings$system.fromJson(
          json['system'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$SystemSettingsToJson(
        Query$SystemSettings instance) =>
    <String, dynamic>{
      'system': instance.system.toJson(),
      '__typename': instance.$__typename,
    };

Query$SystemSettings$system _$Query$SystemSettings$systemFromJson(
        Map<String, dynamic> json) =>
    Query$SystemSettings$system(
      settings: Query$SystemSettings$system$settings.fromJson(
          json['settings'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$SystemSettings$systemToJson(
        Query$SystemSettings$system instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
      '__typename': instance.$__typename,
    };

Query$SystemSettings$system$settings
    _$Query$SystemSettings$system$settingsFromJson(Map<String, dynamic> json) =>
        Query$SystemSettings$system$settings(
          autoUpgrade:
              Query$SystemSettings$system$settings$autoUpgrade.fromJson(
                  json['autoUpgrade'] as Map<String, dynamic>),
          ssh: Query$SystemSettings$system$settings$ssh.fromJson(
              json['ssh'] as Map<String, dynamic>),
          timezone: json['timezone'] as String,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Query$SystemSettings$system$settingsToJson(
        Query$SystemSettings$system$settings instance) =>
    <String, dynamic>{
      'autoUpgrade': instance.autoUpgrade.toJson(),
      'ssh': instance.ssh.toJson(),
      'timezone': instance.timezone,
      '__typename': instance.$__typename,
    };

Query$SystemSettings$system$settings$autoUpgrade
    _$Query$SystemSettings$system$settings$autoUpgradeFromJson(
            Map<String, dynamic> json) =>
        Query$SystemSettings$system$settings$autoUpgrade(
          allowReboot: json['allowReboot'] as bool,
          enable: json['enable'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Query$SystemSettings$system$settings$autoUpgradeToJson(
        Query$SystemSettings$system$settings$autoUpgrade instance) =>
    <String, dynamic>{
      'allowReboot': instance.allowReboot,
      'enable': instance.enable,
      '__typename': instance.$__typename,
    };

Query$SystemSettings$system$settings$ssh
    _$Query$SystemSettings$system$settings$sshFromJson(
            Map<String, dynamic> json) =>
        Query$SystemSettings$system$settings$ssh(
          enable: json['enable'] as bool,
          passwordAuthentication: json['passwordAuthentication'] as bool,
          rootSshKeys: (json['rootSshKeys'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Query$SystemSettings$system$settings$sshToJson(
        Query$SystemSettings$system$settings$ssh instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'passwordAuthentication': instance.passwordAuthentication,
      'rootSshKeys': instance.rootSshKeys,
      '__typename': instance.$__typename,
    };

Query$DomainInfo _$Query$DomainInfoFromJson(Map<String, dynamic> json) =>
    Query$DomainInfo(
      system: Query$DomainInfo$system.fromJson(
          json['system'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$DomainInfoToJson(Query$DomainInfo instance) =>
    <String, dynamic>{
      'system': instance.system.toJson(),
      '__typename': instance.$__typename,
    };

Query$DomainInfo$system _$Query$DomainInfo$systemFromJson(
        Map<String, dynamic> json) =>
    Query$DomainInfo$system(
      domainInfo: Query$DomainInfo$system$domainInfo.fromJson(
          json['domainInfo'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$DomainInfo$systemToJson(
        Query$DomainInfo$system instance) =>
    <String, dynamic>{
      'domainInfo': instance.domainInfo.toJson(),
      '__typename': instance.$__typename,
    };

Query$DomainInfo$system$domainInfo _$Query$DomainInfo$system$domainInfoFromJson(
        Map<String, dynamic> json) =>
    Query$DomainInfo$system$domainInfo(
      domain: json['domain'] as String,
      hostname: json['hostname'] as String,
      provider: $enumDecode(_$Enum$DnsProviderEnumMap, json['provider'],
          unknownValue: Enum$DnsProvider.$unknown),
      requiredDnsRecords: (json['requiredDnsRecords'] as List<dynamic>)
          .map((e) =>
              Query$DomainInfo$system$domainInfo$requiredDnsRecords.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$DomainInfo$system$domainInfoToJson(
        Query$DomainInfo$system$domainInfo instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'hostname': instance.hostname,
      'provider': _$Enum$DnsProviderEnumMap[instance.provider]!,
      'requiredDnsRecords':
          instance.requiredDnsRecords.map((e) => e.toJson()).toList(),
      '__typename': instance.$__typename,
    };

const _$Enum$DnsProviderEnumMap = {
  Enum$DnsProvider.CLOUDFLARE: 'CLOUDFLARE',
  Enum$DnsProvider.$unknown: r'$unknown',
};

Query$DomainInfo$system$domainInfo$requiredDnsRecords
    _$Query$DomainInfo$system$domainInfo$requiredDnsRecordsFromJson(
            Map<String, dynamic> json) =>
        Query$DomainInfo$system$domainInfo$requiredDnsRecords(
          content: json['content'] as String,
          name: json['name'] as String,
          priority: json['priority'] as int?,
          recordType: json['recordType'] as String,
          ttl: json['ttl'] as int,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic>
    _$Query$DomainInfo$system$domainInfo$requiredDnsRecordsToJson(
            Query$DomainInfo$system$domainInfo$requiredDnsRecords instance) =>
        <String, dynamic>{
          'content': instance.content,
          'name': instance.name,
          'priority': instance.priority,
          'recordType': instance.recordType,
          'ttl': instance.ttl,
          '__typename': instance.$__typename,
        };

Variables$Mutation$ChangeTimezone _$Variables$Mutation$ChangeTimezoneFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$ChangeTimezone(
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$Variables$Mutation$ChangeTimezoneToJson(
        Variables$Mutation$ChangeTimezone instance) =>
    <String, dynamic>{
      'timezone': instance.timezone,
    };

Mutation$ChangeTimezone _$Mutation$ChangeTimezoneFromJson(
        Map<String, dynamic> json) =>
    Mutation$ChangeTimezone(
      changeTimezone: Mutation$ChangeTimezone$changeTimezone.fromJson(
          json['changeTimezone'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$ChangeTimezoneToJson(
        Mutation$ChangeTimezone instance) =>
    <String, dynamic>{
      'changeTimezone': instance.changeTimezone.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$ChangeTimezone$changeTimezone
    _$Mutation$ChangeTimezone$changeTimezoneFromJson(
            Map<String, dynamic> json) =>
        Mutation$ChangeTimezone$changeTimezone(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
          timezone: json['timezone'] as String?,
        );

Map<String, dynamic> _$Mutation$ChangeTimezone$changeTimezoneToJson(
        Mutation$ChangeTimezone$changeTimezone instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
      'timezone': instance.timezone,
    };

Variables$Mutation$ChangeAutoUpgradeSettings
    _$Variables$Mutation$ChangeAutoUpgradeSettingsFromJson(
            Map<String, dynamic> json) =>
        Variables$Mutation$ChangeAutoUpgradeSettings(
          settings: Input$AutoUpgradeSettingsInput.fromJson(
              json['settings'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$Variables$Mutation$ChangeAutoUpgradeSettingsToJson(
        Variables$Mutation$ChangeAutoUpgradeSettings instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

Mutation$ChangeAutoUpgradeSettings _$Mutation$ChangeAutoUpgradeSettingsFromJson(
        Map<String, dynamic> json) =>
    Mutation$ChangeAutoUpgradeSettings(
      changeAutoUpgradeSettings:
          Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings.fromJson(
              json['changeAutoUpgradeSettings'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$ChangeAutoUpgradeSettingsToJson(
        Mutation$ChangeAutoUpgradeSettings instance) =>
    <String, dynamic>{
      'changeAutoUpgradeSettings': instance.changeAutoUpgradeSettings.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings
    _$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettingsFromJson(
            Map<String, dynamic> json) =>
        Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
          allowReboot: json['allowReboot'] as bool,
          enableAutoUpgrade: json['enableAutoUpgrade'] as bool,
        );

Map<String, dynamic>
    _$Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettingsToJson(
            Mutation$ChangeAutoUpgradeSettings$changeAutoUpgradeSettings
                instance) =>
        <String, dynamic>{
          'code': instance.code,
          'message': instance.message,
          'success': instance.success,
          '__typename': instance.$__typename,
          'allowReboot': instance.allowReboot,
          'enableAutoUpgrade': instance.enableAutoUpgrade,
        };
