import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/wizards_data/server_installation_wizard_data.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _V4VolumeAdapter extends ServerProviderVolumeAdapter {
  @override
  void write(final BinaryWriter writer, final ServerProviderVolume volume) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(volume.legacyId)
      ..writeByte(2)
      ..write(volume.name)
      ..writeByte(3)
      ..write(volume.sizeByte)
      ..writeByte(4)
      ..write(volume.legacyServerId)
      ..writeByte(5)
      ..write(volume.linuxDevice)
      ..writeByte(6)
      ..write(volume.legacyUuid)
      ..writeByte(7)
      ..write(volume.location)
      ..writeByte(8)
      ..write(volume.serverId);
  }
}

void main() {
  setUp(setUpInMemoryHive);
  tearDown(tearDownInMemoryHive);

  test(
    'resuming migration preserves an already written canonical ID',
    () async {
      final settings = await Hive.openBox(BNames.appSettingsBox);
      final resources = await Hive.openBox(BNames.resourcesBox);
      await settings.put(BNames.databaseVersion, 4);
      await resources.put(BNames.servers, [
        aServer(
          hostingDetails: aServerHostingDetails(
            provider: ServerProviderType.digitalOcean,
            volume: aServerProviderVolume(
              id: 'confirmed-volume-id',
              legacyId: 0,
              legacyUuid: 'old-volume-id',
            ),
          ),
        ),
      ]);
      await HiveConfig.performMigrations();
      await resources.close();
      final reopened = await Hive.openBox(BNames.resourcesBox);
      final server = (reopened.get(BNames.servers) as List).single as Server;
      expect(server.hostingDetails.volume.id, 'confirmed-volume-id');
      expect(settings.get(BNames.databaseVersion), 5);
    },
  );

  test('v4 volume IDs migrate in resources and wizard', () async {
    final servers = [
      for (final scenario in const [
        (
          name: 'hetzner',
          provider: ServerProviderType.hetzner,
          legacyId: 41,
          legacyUuid: 'not-the-hetzner-id',
        ),
        (
          name: 'digital-ocean',
          provider: ServerProviderType.digitalOcean,
          legacyId: 3,
          legacyUuid: 'volume-uuid',
        ),
        (
          name: 'digital-ocean-without-uuid',
          provider: ServerProviderType.digitalOcean,
          legacyId: 3,
          legacyUuid: null,
        ),
        (
          name: 'recovered-hetzner',
          provider: ServerProviderType.hetzner,
          legacyId: 0,
          legacyUuid: null,
        ),
        (
          name: 'unknown-provider',
          provider: ServerProviderType.unknown,
          legacyId: 41,
          legacyUuid: 'untrusted-uuid',
        ),
      ])
        aServer(
          uuid: scenario.name,
          hostingDetails: aServerHostingDetails(
            provider: scenario.provider,
            volume: aServerProviderVolume(
              id: null,
              legacyId: scenario.legacyId,
              legacyUuid: scenario.legacyUuid,
              name: 'data',
              sizeByte: 10737418240,
              linuxDevice: '/dev/disk/by-id/data',
            ),
          ),
        ),
    ];
    Hive.registerAdapter<ServerProviderVolume>(
      _V4VolumeAdapter(),
      override: true,
    );
    final resources = await Hive.openBox(BNames.resourcesBox);
    final wizard = await Hive.openBox(BNames.wizardDataBox);
    final settings = await Hive.openBox(BNames.appSettingsBox);
    await settings.put(BNames.databaseVersion, 4);
    await settings.put(BNames.activeServerUuid, 'digital-ocean');
    await resources.put(BNames.servers, servers);
    await wizard.put(
      BNames.serverInstallationWizardData,
      ServerInstallationWizardData.empty().copyWith(
        isCertificateVerified: true,
        serverDetails: () => servers[1].hostingDetails,
      ),
    );
    await Hive.close();
    Hive.registerAdapter<ServerProviderVolume>(
      ServerProviderVolumeAdapter(),
      override: true,
    );
    await Hive.openBox(BNames.resourcesBox);
    await Hive.openBox(BNames.wizardDataBox);

    await HiveConfig.performMigrations();
    await Hive.close();

    final reopened = await Hive.openBox(BNames.resourcesBox);
    final migrated = List<Server>.from(reopened.get(BNames.servers) as List);
    final expected = {
      'hetzner': '41',
      'digital-ocean': 'volume-uuid',
      'digital-ocean-without-uuid': null,
      'recovered-hetzner': null,
      'unknown-provider': null,
    };
    expect({
      for (final server in migrated)
        server.uuid: server.hostingDetails.volume.id,
    }, expected);
    for (final server in migrated) {
      expect(server.hostingDetails.apiToken, 'api-token');
      expect(server.hostingDetails.volume.name, 'data');
      expect(server.hostingDetails.volume.sizeByte, 10737418240);
      expect(server.hostingDetails.volume.linuxDevice, '/dev/disk/by-id/data');
    }
    final reopenedWizard = await Hive.openBox(BNames.wizardDataBox);
    final draft =
        reopenedWizard.get(BNames.serverInstallationWizardData)
            as ServerInstallationWizardData;
    expect(draft.serverDetails!.volume.id, 'volume-uuid');
    expect(draft.isCertificateVerified, isTrue);
    final reopenedSettings = await Hive.openBox(BNames.appSettingsBox);
    expect(reopenedSettings.get(BNames.databaseVersion), 5);
    expect(reopenedSettings.get(BNames.activeServerUuid), 'digital-ocean');

    await reopenedSettings.put(BNames.databaseVersion, 4);
    await HiveConfig.performMigrations();
    await reopened.close();
    final repeated = await Hive.openBox(BNames.resourcesBox);
    expect({
      for (final server in List<Server>.from(
        repeated.get(BNames.servers) as List,
      ))
        server.uuid: server.hostingDetails.volume.id,
    }, expected);
  });
}
