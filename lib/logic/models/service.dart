import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

class Service extends Equatable {
  Service.fromGraphQL(final Query$AllServices$services$allServices service)
      : this(
          id: service.id,
          displayName: service.displayName,
          description: service.description,
          isEnabled: service.isEnabled,
          isRequired: service.isRequired,
          isMovable: service.isMovable,
          canBeBackedUp: service.canBeBackedUp,
          backupDescription: service.backupDescription,
          status: ServiceStatus.fromGraphQL(service.status),
          storageUsage: ServiceStorageUsage(
            used: DiskSize(byte: int.parse(service.storageUsage.usedSpace)),
            volume: service.storageUsage.volume?.name,
          ),
          // Decode the base64 encoded svg icon to text.
          svgIcon: utf8.decode(base64.decode(service.svgIcon)),
          dnsRecords: service.dnsRecords
                  ?.map(
                    (
                      final Fragment$fragmentDnsRecords record,
                    ) =>
                        DnsRecord.fromGraphQL(record),
                  )
                  .toList() ??
              [],
          url: service.url,
          configuration: service.configuration
                  ?.map(
                    (
                      final Query$AllServices$services$allServices$configuration
                          configItem,
                    ) =>
                        ServiceConfigItem.fromGraphQL(configItem),
                  )
                  .toList() ??
              [],
        );
  const Service({
    required this.id,
    required this.displayName,
    required this.description,
    required this.isEnabled,
    required this.isRequired,
    required this.isMovable,
    required this.canBeBackedUp,
    required this.backupDescription,
    required this.status,
    required this.storageUsage,
    required this.svgIcon,
    required this.dnsRecords,
    required this.configuration,
    this.url,
  });

  /// TODO Turn loginInfo into dynamic data, not static!
  String get loginInfo {
    switch (id) {
      case 'simple-nixos-mailserver':
        return 'mail.login_info'.tr();
      case 'bitwarden':
        return 'password_manager.login_info'.tr();
      case 'jitsi-meet':
        return 'video.login_info'.tr();
      case 'nextcloud':
        return 'cloud.login_info'.tr();
      case 'pleroma':
        return 'social_network.login_info'.tr();
      case 'gitea':
        return 'git.login_info'.tr();
    }
    return '';
  }

  static Service empty = const Service(
    id: 'empty',
    displayName: '',
    description: '',
    isEnabled: false,
    isRequired: false,
    isMovable: false,
    canBeBackedUp: false,
    backupDescription: '',
    status: ServiceStatus.off,
    storageUsage: ServiceStorageUsage(
      used: DiskSize(byte: 0),
      volume: '',
    ),
    svgIcon: '',
    dnsRecords: [],
    url: '',
    configuration: [],
  );

  final String id;
  final String displayName;
  final String description;
  final bool isEnabled;
  final bool isRequired;
  final bool isMovable;
  final bool canBeBackedUp;
  final String backupDescription;
  final ServiceStatus status;
  final ServiceStorageUsage storageUsage;
  final String svgIcon;
  final String? url;
  final List<DnsRecord> dnsRecords;
  final List<ServiceConfigItem> configuration;

  @override
  List<Object?> get props => [
        id,
        displayName,
        description,
        isEnabled,
        isRequired,
        isMovable,
        canBeBackedUp,
        backupDescription,
        status,
        storageUsage,
        svgIcon,
        dnsRecords,
        url,
        configuration,
      ];
}

class ServiceStorageUsage extends Equatable {
  const ServiceStorageUsage({
    required this.used,
    required this.volume,
  });

  final DiskSize used;
  final String? volume;

  @override
  List<Object?> get props => [used, volume];
}

enum ServiceStatus {
  failed,
  reloading,
  activating,
  active,
  deactivating,
  inactive,
  off;

  factory ServiceStatus.fromGraphQL(final Enum$ServiceStatusEnum graphQL) {
    switch (graphQL) {
      case Enum$ServiceStatusEnum.ACTIVATING:
        return activating;
      case Enum$ServiceStatusEnum.ACTIVE:
        return active;
      case Enum$ServiceStatusEnum.DEACTIVATING:
        return deactivating;
      case Enum$ServiceStatusEnum.FAILED:
        return failed;
      case Enum$ServiceStatusEnum.INACTIVE:
        return inactive;
      case Enum$ServiceStatusEnum.OFF:
        return off;
      case Enum$ServiceStatusEnum.RELOADING:
        return reloading;
      case Enum$ServiceStatusEnum.$unknown:
        return inactive;
    }
  }
}

sealed class ServiceConfigItem extends Equatable {
  const ServiceConfigItem({
    required this.id,
    required this.description,
    required this.widget,
    required this.type,
  });

  factory ServiceConfigItem.fromGraphQL(
    final Query$AllServices$services$allServices$configuration configItem,
  ) =>
      configItem.when<ServiceConfigItem>(
        boolConfigItem: (final boolConfigItem) => BoolServiceConfigItem(
          id: boolConfigItem.fieldId,
          description: boolConfigItem.description,
          widget: boolConfigItem.widget,
          type: boolConfigItem.type,
          value: boolConfigItem.boolValue,
          defaultValue: boolConfigItem.defaultBoolValue,
        ),
        enumConfigItem: (final enumConfigItem) => EnumServiceConfigItem(
          id: enumConfigItem.fieldId,
          description: enumConfigItem.description,
          widget: enumConfigItem.widget,
          type: enumConfigItem.type,
          value: enumConfigItem.stringValue,
          defaultValue: enumConfigItem.defaultStringValue,
          options: enumConfigItem.options,
        ),
        stringConfigItem: (final stringConfigItem) => StringServiceConfigItem(
          id: stringConfigItem.fieldId,
          description: stringConfigItem.description,
          widget: stringConfigItem.widget,
          type: stringConfigItem.type,
          value: stringConfigItem.stringValue,
          defaultValue: stringConfigItem.defaultStringValue,
          regex: stringConfigItem.regex,
        ),
        orElse: () => FallbackServiceConfigItem(
          id: configItem.fieldId,
          description: configItem.description,
          type: configItem.type,
        ),
      );

  final String id;
  final String description;
  final String widget;
  final String type;
}

class StringServiceConfigItem extends ServiceConfigItem {
  const StringServiceConfigItem({
    required super.id,
    required super.description,
    required super.widget,
    required super.type,
    required this.value,
    required this.defaultValue,
    this.regex,
  });

  final String value;
  final String defaultValue;
  final String? regex;

  @override
  List<Object?> get props =>
      [id, description, widget, type, value, defaultValue, regex];
}

class BoolServiceConfigItem extends ServiceConfigItem {
  const BoolServiceConfigItem({
    required super.id,
    required super.description,
    required super.widget,
    required super.type,
    required this.value,
    required this.defaultValue,
  });

  final bool value;
  final bool defaultValue;

  @override
  List<Object?> get props =>
      [id, description, widget, type, value, defaultValue];
}

class EnumServiceConfigItem extends ServiceConfigItem {
  const EnumServiceConfigItem({
    required super.id,
    required super.description,
    required super.widget,
    required super.type,
    required this.value,
    required this.defaultValue,
    required this.options,
  });

  final String value;
  final String defaultValue;
  final List<String> options;

  @override
  List<Object?> get props =>
      [id, description, widget, type, value, defaultValue, options];
}

class FallbackServiceConfigItem extends ServiceConfigItem {
  const FallbackServiceConfigItem({
    required super.id,
    required super.description,
    required super.type,
  }) : super(widget: 'fallback');

  @override
  List<Object?> get props => [id, description, widget, type];
}

// TODO: Not used yet by the API
class IntServiceConfigItem extends ServiceConfigItem {
  const IntServiceConfigItem({
    required super.id,
    required super.description,
    required super.widget,
    required super.type,
    required this.value,
    required this.defaultValue,
    required this.min,
    required this.max,
  });

  final int value;
  final int defaultValue;
  final int min;
  final int max;

  @override
  List<Object?> get props =>
      [id, description, widget, type, value, defaultValue, min, max];
}
