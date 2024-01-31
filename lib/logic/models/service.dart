import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

class Service {
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
        );
  Service({
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

  static Service empty = Service(
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
      used: const DiskSize(byte: 0),
      volume: '',
    ),
    svgIcon: '',
    dnsRecords: [],
    url: '',
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
}

class ServiceStorageUsage {
  ServiceStorageUsage({
    required this.used,
    required this.volume,
  });

  final DiskSize used;
  final String? volume;
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
