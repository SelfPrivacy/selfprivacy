import 'dart:convert';

import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

class Service {
  Service({
    required this.id,
    required this.displayName,
    required this.description,
    required this.isEnabled,
    required this.isRequired,
    required this.status,
    required this.storageUsage,
    required this.svgIcon,
    required this.dnsRecords,
    this.url,
  });

  Service.fromGraphQL(final Query$AllServices$services$allServices service)
      : this(
          id: service.id,
          displayName: service.displayName,
          description: service.description,
          isEnabled: service.isEnabled,
          isRequired: service.isRequired,
          status: ServiceStatus.fromGraphQL(service.status),
          storageUsage: ServiceStorageUsage(
            used: DiskSize(byte: int.parse(service.storageUsage.usedSpace)),
            volume: service.storageUsage.volume?.name,
          ),
          // Decode the base64 encoded svg icon to text.
          svgIcon: utf8.decode(base64.decode(service.svgIcon)),
          dnsRecords: service.dnsRecords
                  ?.map((final record) => DnsRecord.fromGraphQL(record))
                  .toList() ??
              [],
          url: service.url,
        );

  final String id;
  final String displayName;
  final String description;
  final bool isEnabled;
  final bool isRequired;
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
  activating,
  active,
  deactivating,
  failed,
  inactive,
  off,
  reloading;

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
