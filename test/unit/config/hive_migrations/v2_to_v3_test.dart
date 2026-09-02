import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/wizards_data/server_installation_wizard_data.dart';
import 'package:uuid/uuid.dart';

import '../../../fakes/hive/in_memory_hive.dart';

const int v2ProviderId = 42;
const String v2ServerToken = 'v2-server-provider-token';

void main() {
  setUpAll(() => setUpHiveFromFixture('test/fixtures/hive/v2'));
  tearDownAll(tearDownInMemoryHive);

  test('v2 to v3 migrates identities and preserves wizard data', () async {
    await Hive.openBox(BNames.resourcesBox);
    await Hive.openBox(BNames.wizardDataBox);
    await Hive.openBox(BNames.wizardRunsBox);

    await HiveConfig.performMigrations();

    await Hive.box(BNames.resourcesBox).close();
    await Hive.box(BNames.wizardDataBox).close();
    await Hive.box(BNames.wizardRunsBox).close();
    await Hive.box(BNames.appSettingsBox).close();
    final resourcesBox = await Hive.openBox(BNames.resourcesBox);
    await Hive.openBox(BNames.wizardDataBox);
    await Hive.openBox(BNames.wizardRunsBox);
    final appSettingsBox = await Hive.openBox(BNames.appSettingsBox);
    final server =
        (resourcesBox.get(BNames.servers) as List<dynamic>).single as Server;
    final serverCredential =
        (resourcesBox.get(BNames.serverProviderTokens) as List<dynamic>).single
            as ServerProviderCredential;
    final dnsCredential =
        (resourcesBox.get(BNames.dnsProviderTokens) as List<dynamic>).single
            as DnsProviderCredential;
    final backupsCredential =
        (resourcesBox.get(BNames.backupsProviderTokens) as List<dynamic>).single
            as BackupsCredential;

    expect(appSettingsBox.get(BNames.databaseVersion), HiveConfig.version);
    expect(Uuid.isValidUUID(fromString: server.uuid), isTrue);
    expect(server.uuid[14], '4');
    expect(server.hostingDetails.providerId, '$v2ProviderId');
    expect(server.hostingDetails.legacyProviderId, isNull);
    expect(server.hostingDetails.volume.serverId, '$v2ProviderId');
    expect(server.hostingDetails.volume.legacyServerId, isNull);
    expect(Uuid.isValidUUID(fromString: serverCredential.uuid), isTrue);
    expect(serverCredential.uuid[14], '4');
    expect(
      serverCredential.credentials,
      isA<BearerTokenCredential>().having(
        (final credential) => credential.token,
        'token',
        v2ServerToken,
      ),
    );
    expect(serverCredential.legacyToken, isNull);
    expect(serverCredential.legacyAssociatedServerIds, isEmpty);
    expect(serverCredential.associatedServerUuids, <String>[server.uuid]);
    expect(Uuid.isValidUUID(fromString: dnsCredential.uuid), isTrue);
    expect(Uuid.isValidUUID(fromString: backupsCredential.uuid), isTrue);
    expect(appSettingsBox.get(BNames.activeServerUuid), server.uuid);
    expect(
      Hive.box(BNames.wizardDataBox).get(BNames.serverInstallationWizardData),
      isA<ServerInstallationWizardData>(),
    );
    expect(Hive.box(BNames.wizardRunsBox), isEmpty);

    final migratedIds = <String>[
      server.uuid,
      serverCredential.uuid,
      dnsCredential.uuid,
      backupsCredential.uuid,
    ];
    await HiveConfig.migrateFrom2To3(appSettingsBox);
    await resourcesBox.close();
    final reopenedResourcesBox = await Hive.openBox(BNames.resourcesBox);
    final storedIds = <String>[
      ((reopenedResourcesBox.get(BNames.servers) as List<dynamic>).single
              as Server)
          .uuid,
      ((reopenedResourcesBox.get(BNames.serverProviderTokens) as List<dynamic>)
                  .single
              as ServerProviderCredential)
          .uuid,
      ((reopenedResourcesBox.get(BNames.dnsProviderTokens) as List<dynamic>)
                  .single
              as DnsProviderCredential)
          .uuid,
      ((reopenedResourcesBox.get(BNames.backupsProviderTokens) as List<dynamic>)
                  .single
              as BackupsCredential)
          .uuid,
    ];
    expect(storedIds, migratedIds);
  });
}
