import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _MockServerApi extends Mock implements ServerApi {}

class _ReloadTestRepository extends ApiConnectionRepository {
  _ReloadTestRepository({required super.resourcesModel, required super.api});

  int refreshCount = 0;

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
    repository = _ReloadTestRepository(
      resourcesModel: resourcesModel,
      api: api,
    );

    getIt
      ..registerSingleton<ApiConfigModel>(ApiConfigModel())
      ..registerSingleton<ConsoleModel>(ConsoleModel())
      ..registerSingleton<DeveloperSettingsModel>(settings)
      ..registerSingleton<TlsContext>(TlsContext(settings));
  });

  tearDown(() async {
    repository.dispose();
    await resourcesModel.dispose();
    getIt<TlsContext>().reset();
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

  test(
    'initialization does not call the API without a selected server',
    () async {
      final noServerRepository = ApiConnectionRepository(
        resourcesModel: resourcesModel,
        serverSelector: () => null,
        api: api,
      );
      addTearDown(noServerRepository.dispose);

      await noServerRepository.init();

      verifyNever(api.getApiVersion);
    },
  );

  test('an overdue token refreshes when the setting is enabled', () async {
    await repository.reload(null);

    expect(repository.refreshCount, 1);
  });

  test('an updated user is published to data listeners', () async {
    const originalUser = User.fake(login: 'user', displayName: 'Alex');
    const updatedUser = User.fake(login: 'user', displayName: 'Luna');
    repository.apiData.users.data = [originalUser];
    when(
      () => api.updateUser('user', 'Luna', const ['sp.full_users']),
    ).thenAnswer(
      (_) async => GenericResult<User?>(success: true, data: updatedUser),
    );
    final emittedData = repository.dataStream.first;

    final result = await repository.updateUser(
      const User.fake(
        login: 'user',
        displayName: 'Luna',
        directmemberof: ['sp.full_users'],
      ),
    );

    expect(result.$1, isTrue);
    expect((await emittedData).users.data, [updatedUser]);
  });

  test('the server selector scopes connection values', () async {
    await resourcesModel.addServer(
      aServer(
        uuid: 'second-server',
        domain: aServerDomain(domainName: 'second.example'),
        hostingDetails: aServerHostingDetails(apiToken: 'second-token'),
      ),
    );
    final selectedRepository = ApiConnectionRepository(
      resourcesModel: resourcesModel,
      serverSelector: () => resourcesModel.servers.firstWhere(
        (final server) => server.uuid == 'second-server',
      ),
    );
    addTearDown(selectedRepository.dispose);

    expect(selectedRepository.serverDomain?.domainName, 'second.example');
    expect(selectedRepository.serverDetails?.apiToken, 'second-token');
    expect(selectedRepository.api.rootAddress, 'second.example');
    expect(selectedRepository.api.apiToken, 'second-token');

    await resourcesModel.updateServerByUuid(
      aServer(
        uuid: 'second-server',
        domain: aServerDomain(domainName: 'second.example'),
        hostingDetails: aServerHostingDetails(apiToken: 'rotated-token'),
      ),
    );

    expect(selectedRepository.api.apiToken, 'rotated-token');
  });

  test('token rotation updates only the selected server', () async {
    await resourcesModel.addServer(
      aServer(
        uuid: 'second-server',
        domain: aServerDomain(domainName: 'second.example'),
        hostingDetails: aServerHostingDetails(apiToken: 'second-token'),
      ),
    );
    final selectedApi = _MockServerApi();
    when(selectedApi.refreshDeviceApiToken).thenAnswer(
      (_) async => GenericResult(success: true, data: 'rotated-token'),
    );
    final selectedRepository = ApiConnectionRepository(
      resourcesModel: resourcesModel,
      serverSelector: () => resourcesModel.servers.firstWhere(
        (final server) => server.uuid == 'second-server',
      ),
      api: selectedApi,
    );
    addTearDown(selectedRepository.dispose);

    final result = await selectedRepository.refreshDeviceToken();

    expect(result.$1, isTrue);
    expect(resourcesModel.servers.first.hostingDetails.apiToken, 'api-token');
    expect(
      resourcesModel.servers
          .firstWhere((final server) => server.uuid == 'second-server')
          .hostingDetails
          .apiToken,
      'rotated-token',
    );
  });
}
