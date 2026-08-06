import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _MockServerApi extends Mock implements ServerApi {}

class _ReloadTestRepository extends ApiConnectionRepository {
  _ReloadTestRepository(this.testApi);

  final ServerApi testApi;
  int refreshCount = 0;

  @override
  ServerApi get api => testApi;

  @override
  Future<(bool, String)> refreshDeviceToken() async {
    refreshCount++;
    return (true, 'done');
  }
}

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  late DeveloperSettingsModel settings;
  late ResourcesModel resourcesModel;
  late _MockServerApi api;
  late _ReloadTestRepository repository;

  setUp(() async {
    await Hive.openBox(BNames.appSettingsBox);
    await Hive.openBox(BNames.resourcesBox);
    await Hive.openBox(BNames.serverInstallationBox);

    settings = DeveloperSettingsModel();
    resourcesModel = ResourcesModel()..init();
    await resourcesModel.addServer(aServer());
    api = _MockServerApi();
    when(() => api.getApiVersion()).thenAnswer((_) async => '0.0.0');
    repository = _ReloadTestRepository(api);

    getIt
      ..registerSingleton<DeveloperSettingsModel>(settings)
      ..registerSingleton<ResourcesModel>(resourcesModel);
  });

  tearDown(() async {
    repository.dispose();
    await resourcesModel.dispose();
    await getIt.reset();
    for (final name in [
      BNames.appSettingsBox,
      BNames.resourcesBox,
      BNames.serverInstallationBox,
    ]) {
      final box = Hive.box(name);
      await box.clear();
      await box.close();
    }
  });

  test('the developer setting stops an automatic token refresh', () async {
    await settings.setAutomaticGraphqlTokenRefresh(enabled: false);

    await repository.reload(null);

    expect(repository.refreshCount, 0);
  });

  test('an overdue token refreshes when the setting is enabled', () async {
    await repository.reload(null);

    expect(repository.refreshCount, 1);
  });
}
