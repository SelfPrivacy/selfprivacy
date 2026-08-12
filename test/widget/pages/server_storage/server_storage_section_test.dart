import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/pages/server_storage/server_storage.dart';

import '../../../helpers/widget_harness.dart';

void main() {
  setUpAll(setUpWidgetTestHarness);

  final volume = DiskVolume(
    name: 'root',
    sizeTotal: const DiskSize(byte: 1000),
    sizeUsed: const DiskSize(byte: 300),
    root: true,
  );

  Service service({
    required final String id,
    required final bool isInstalled,
    final bool isSystemService = false,
  }) => Service(
    id: id,
    displayName: id,
    description: '',
    isEnabled: true,
    isInstalled: isInstalled,
    isRequired: false,
    isSystemService: isSystemService,
    isMovable: false,
    canBeBackedUp: false,
    backupDescription: '',
    status: ServiceStatus.active,
    storageUsage: const ServiceStorageUsage(
      used: DiskSize(byte: 100),
      volume: 'root',
    ),
    svgIcon: '<svg viewBox="0 0 1 1"></svg>',
    license: const [],
    supportLevel: SupportLevel.normal,
    dnsRecords: const [],
    configuration: const [],
  );

  testWidgets('shows only installed services', (final tester) async {
    await pumpForTest(
      tester,
      ServerStorageSection(
        volume: volume,
        diskStatus: DiskStatus(),
        services: [
          service(id: 'Installed service', isInstalled: true),
          service(
            id: 'Installed system service',
            isInstalled: true,
            isSystemService: true,
          ),
          service(id: 'Uninstalled service', isInstalled: false),
        ],
      ),
    );

    expect(find.text('Installed service'), findsOneWidget);
    expect(find.text('Installed system service'), findsOneWidget);
    expect(find.text('Uninstalled service'), findsNothing);
    expect(find.textContaining('System disk'), findsOneWidget);
  });
}
