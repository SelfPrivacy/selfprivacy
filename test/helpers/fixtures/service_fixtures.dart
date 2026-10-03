import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/service.dart';

Service aService({
  final String id = 'gitea',
  final String displayName = 'Gitea',
  final ServiceStatus status = ServiceStatus.active,
}) => Service(
  id: id,
  displayName: displayName,
  description: 'Git hosting',
  isEnabled: true,
  isInstalled: true,
  isRequired: false,
  isSystemService: false,
  isMovable: true,
  canBeBackedUp: true,
  backupDescription: 'Repositories and settings',
  status: status,
  storageUsage: const ServiceStorageUsage(
    used: DiskSize(byte: 1024),
    volume: 'sda1',
  ),
  svgIcon: '',
  license: const [],
  supportLevel: SupportLevel.unknown,
  dnsRecords: const [],
  configuration: const [],
);
