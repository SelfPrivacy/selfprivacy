import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/operations/operation.dart';

import 'constants.dart';

Service demoService({
  final ServiceStatus status = ServiceStatus.active,
  final String id = 'nextcloud',
  final bool system = false,
  final String? name,
  final bool noIcon = false,
}) => Service(
  id: id,
  displayName: name ?? 'Nextcloud',
  description: 'Files, calendars and contacts',
  isEnabled: status != ServiceStatus.off,
  isInstalled: true,
  isRequired: system,
  isSystemService: system,
  isMovable: true,
  canBeBackedUp: true,
  backupDescription: 'Files and database',
  status: status,
  storageUsage: const ServiceStorageUsage(
    used: DiskSize(byte: 4294967296),
    volume: 'sda1',
  ),
  svgIcon: noIcon ? '' : demoSvg,
  license: const [],
  supportLevel: SupportLevel.normal,
  dnsRecords: const [],
  configuration: const [],
  url: 'https://cloud.example.org',
);
DiskVolume demoVolume({final bool full = false, final bool root = true}) =>
    DiskVolume(
      name: root ? 'sda1' : 'data',
      root: root,
      sizeTotal: const DiskSize(byte: 42949672960),
      sizeUsed: DiskSize(byte: full ? 40802189312 : 12884901888),
    );
DiskStatus demoDisks({final bool full = false, final bool empty = false}) =>
    DiskStatus()
      ..diskVolumes = empty
          ? []
          : [demoVolume(full: full), demoVolume(root: false)];
Server demoServer({
  final DateTime? rotatedAt,
  final String token = 'catalog-token',
}) => Server(
  uuid: 'catalog-server',
  domain: ServerDomain(
    domainName: 'example.org',
    provider: DnsProviderType.cloudflare,
  ),
  hostingDetails: ServerHostingDetails(
    providerId: '1',
    ip4: '192.0.2.10',
    apiToken: token,
    provider: ServerProviderType.hetzner,
    createTime: referenceTime,
    apiTokenRotatedAt: rotatedAt,
    volume: ServerProviderVolume(
      id: 1,
      name: 'data',
      sizeByte: 42949672960,
      serverId: '1',
      linuxDevice: '/dev/sdb',
    ),
  ),
);
Backup demoBackup({
  final String serviceId = 'nextcloud',
  final Enum$BackupReason reason = Enum$BackupReason.EXPLICIT,
}) => Backup(
  time: referenceTime,
  id: 'a1b2c3d4',
  serviceId: serviceId,
  fallbackServiceName: 'Archived service',
  reason: reason,
);
ServerJob demoJob(final JobStatusEnum status) => ServerJob(
  name: 'Create backup',
  description: 'Back up Nextcloud files and database',
  status: status,
  uid: 'catalog-job',
  typeId: 'service.nextcloud.backup',
  updatedAt: referenceTime,
  createdAt: referenceTime,
  progress: status == JobStatusEnum.finished ? 100 : 45,
  error: status == JobStatusEnum.error ? 'Backup storage is unavailable' : null,
  result: status == JobStatusEnum.finished ? 'Backup created' : null,
  statusText: status == JobStatusEnum.running ? 'Uploading files' : null,
);

OperationSnapshot demoOperation(final String variant) {
  final status = switch (variant) {
    'Finished' || 'Resize' => OperationStatus.succeeded,
    'Failed' || 'Partial failure' => OperationStatus.failed,
    'Unknown' => OperationStatus.unknown,
    'Queued' => OperationStatus.queued,
    'Waiting' => OperationStatus.accepted,
    'Cancelled' => OperationStatus.cancelled,
    _ => OperationStatus.running,
  };
  return OperationSnapshot(
    id: 1,
    serverId: 'catalog-server',
    kind: variant == 'Resize'
        ? OperationKind.resizeVolume
        : variant == 'Waiting'
        ? OperationKind.createBackups
        : OperationKind.applyChanges,
    events: [OperationEvent(referenceTime, status)],
    jobIds: variant == 'Waiting' ? ['catalog-job'] : const [],
    steps: [
      if (variant == 'Resize') ...[
        const OperationStep(
          id: 'resize',
          titleKey: 'storage.extending_volume_title',
          status: OperationStatus.succeeded,
        ),
        const OperationStep(
          id: 'reboot',
          titleKey: 'storage.extending_volume_rebooting',
          status: OperationStatus.succeeded,
        ),
      ] else if (variant != 'Waiting') ...[
        OperationStep(
          id: 'timezone',
          titleKey: 'jobs.change_server_timezone',
          status: variant == 'Queued' || variant == 'Cancelled'
              ? status
              : OperationStatus.succeeded,
        ),
        OperationStep(
          id: 'dns',
          titleKey: 'jobs.update_dns_records',
          status: variant == 'Partial failure'
              ? OperationStatus.failed
              : status,
        ),
      ],
    ],
  );
}
