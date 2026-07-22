import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/credential_fixtures.dart';

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  late WizardDataModel wizard;

  setUp(() async {
    await Hive.openBox(BNames.wizardDataBox);
    wizard = WizardDataModel()..init();
  });

  tearDown(() async {
    final Box box = Hive.box(BNames.wizardDataBox);
    await box.clear();
    await box.close();
  });

  test('setServerProviderKey stores and persists the key', () async {
    await wizard.setServerProviderKey('my-key');

    expect(wizard.serverInstallation?.serverProviderKey, 'my-key');

    final reloaded = WizardDataModel()..init();
    expect(reloaded.serverInstallation?.serverProviderKey, 'my-key');
  });

  test('clearServerProviderKey nulls the key and persists', () async {
    await wizard.setServerProviderKey('my-key');

    await wizard.clearServerProviderKey();

    expect(wizard.serverInstallation?.serverProviderKey, isNull);
    // The wizard row still exists — only the key was cleared.
    expect(wizard.serverInstallation, isNotNull);

    final reloaded = WizardDataModel()..init();
    expect(reloaded.serverInstallation?.serverProviderKey, isNull);
    expect(reloaded.serverInstallation, isNotNull);
  });

  test(
    'clearServerProviderKey leaves stored server-provider credentials intact',
    () async {
      await Hive.openBox(BNames.resourcesBox);
      final resources = ResourcesModel()..init();
      addTearDown(() async {
        await resources.dispose();
        final Box box = Hive.box(BNames.resourcesBox);
        await box.clear();
        await box.close();
      });

      await resources.addServerProviderToken(
        aServerProviderCredential(token: 'keep-me'),
      );
      await wizard.setServerProviderKey('keep-me');

      await wizard.clearServerProviderKey();

      expect(wizard.serverInstallation?.serverProviderKey, isNull);
      expect(
        resources.serverProviderCredentials.map((final c) => c.token),
        contains('keep-me'),
      );
    },
  );
}
