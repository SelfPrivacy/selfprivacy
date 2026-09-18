import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _MockServerApi extends Mock implements ServerApi {}

class _MockResources extends Mock implements ResourcesModel {}

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

  test('an authentication failure publishes unauthorized once', () async {
    final connectedRepository = ApiConnectionRepository(
      resourcesModel: resourcesModel,
    );
    addTearDown(connectedRepository.dispose);
    final statuses = <ConnectionStatus>[];
    final subscription = connectedRepository.connectionStatusStream.listen(
      statuses.add,
    );
    addTearDown(subscription.cancel);

    connectedRepository.api.transport.onAuthFailure?.call();
    connectedRepository.api.transport.onAuthFailure?.call();
    await pumpEventQueue();

    expect(
      connectedRepository.currentConnectionStatus,
      ConnectionStatus.unauthorized,
    );
    expect(statuses, [ConnectionStatus.unauthorized]);
  });

  test('reload does not overwrite an unauthorized status', () async {
    repository.connectionStatus = ConnectionStatus.unauthorized;

    await repository.reload(null);

    expect(repository.currentConnectionStatus, ConnectionStatus.unauthorized);
  });

  test('initialization can reconnect after token recovery', () async {
    repository.connectionStatus = ConnectionStatus.unauthorized;

    await repository.init();

    expect(repository.currentConnectionStatus, ConnectionStatus.connected);
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
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available('rotated-token'),
      ),
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
  ApiConnectionRepository realRepository({final ResourcesModel? resources}) {
    final result = ApiConnectionRepository(
      resourcesModel: resources ?? resourcesModel,
      api: api,
    );
    addTearDown(result.dispose);
    return result;
  }

  ServerMutationResult<String> confirmed(final String token) =>
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(token),
        message: 'secret-sentinel',
      );

  test(
    'rotation is single-flight and persists before reconnecting jobs',
    () async {
      final pending = Completer<ServerMutationResult<String>>();
      final jobs = StreamController<List<ServerJob>>();
      when(api.refreshDeviceApiToken).thenAnswer((_) => pending.future);
      when(
        () => api.getServerJobsStream(
          onConnectionLost: any(named: 'onConnectionLost'),
        ),
      ).thenAnswer((_) {
        expect(
          resourcesModel.servers.first.hostingDetails.apiToken,
          'replacement',
        );
        expect(
          (Hive.box(BNames.resourcesBox).get(BNames.servers) as List<Server>)
              .first
              .hostingDetails
              .apiToken,
          'replacement',
        );
        return jobs.stream;
      });
      final connection = realRepository();
      addTearDown(() async {
        await connection.clear();
        await jobs.close();
      });
      connection.apiData.apiVersion.data = '3.9.0';
      final first = connection.refreshDeviceToken();
      final second = connection.refreshDeviceToken();
      expect(identical(first, second), isTrue);
      pending.complete(confirmed('replacement'));
      expect((await first).$1, isTrue);
      expect((await second).$1, isTrue);
      verify(api.refreshDeviceApiToken).called(1);
      verify(
        () => api.getServerJobsStream(
          onConnectionLost: any(named: 'onConnectionLost'),
        ),
      ).called(1);
    },
  );

  for (final outcome in ServerMutationOutcome.values) {
    test(
      'unusable ${outcome.name} rotation keeps credentials and gates automatic retry',
      () async {
        final connection = realRepository();
        when(api.refreshDeviceApiToken).thenAnswer(
          (_) async => ServerMutationResult<String>(
            outcome: outcome,
            payload: const ServerMutationPayload.missing(),
            message: 'secret-sentinel',
          ),
        );
        final result = await connection.refreshDeviceToken();
        expect(result.$1, isFalse);
        expect(result.$2, isNot(contains('secret-sentinel')));
        expect(
          resourcesModel.servers.first.hostingDetails.apiToken,
          'api-token',
        );
        await connection.reload(null);
        await connection.reload(null);
        verify(
          api.refreshDeviceApiToken,
        ).called(outcome == ServerMutationOutcome.rejected ? 2 : 1);
      },
    );
  }

  test(
    'recovery with another credential clears rotation suppression',
    () async {
      final connection = realRepository();
      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult<String>(
          outcome: ServerMutationOutcome.indeterminate,
          payload: const ServerMutationPayload.unreadable(),
        ),
      );
      await connection.refreshDeviceToken();
      await connection.reload(null);
      verify(api.refreshDeviceApiToken).called(1);

      final original = resourcesModel.servers.first;
      await resourcesModel.updateServerByUuid(
        aServer(
          uuid: original.uuid,
          hostingDetails: aServerHostingDetails(apiToken: 'recovered'),
        ),
      );
      when(
        api.refreshDeviceApiToken,
      ).thenAnswer((_) async => confirmed('replacement'));
      await connection.reload(null);
      await pumpEventQueue();
      verify(api.refreshDeviceApiToken).called(1);
      expect(
        resourcesModel.servers.first.hostingDetails.apiToken,
        'replacement',
      );
    },
  );

  test('a late rotation does not overwrite a recovered credential', () async {
    final connection = realRepository();
    final pending = Completer<ServerMutationResult<String>>();
    when(api.refreshDeviceApiToken).thenAnswer((_) => pending.future);
    final rotation = connection.refreshDeviceToken();
    final original = resourcesModel.servers.first;
    await resourcesModel.updateServerByUuid(
      aServer(
        uuid: original.uuid,
        hostingDetails: aServerHostingDetails(apiToken: 'recovered'),
      ),
    );
    pending.complete(confirmed('obsolete-replacement'));
    expect((await rotation).$1, isFalse);
    expect(resourcesModel.servers.first.hostingDetails.apiToken, 'recovered');
  });

  for (final updatesMemory in [false, true]) {
    test(
      'persistence failure suppresses retry, memory updated=$updatesMemory',
      () async {
        registerFallbackValue(aServer());
        final resources = _MockResources();
        var stored = aServer();
        when(() => resources.servers).thenAnswer((_) => [stored]);
        when(() => resources.updateServerByUuid(any())).thenAnswer((
          final invocation,
        ) {
          if (updatesMemory) {
            final replacement = invocation.positionalArguments.single as Server;
            stored = aServer(
              uuid: replacement.uuid,
              hostingDetails: aServerHostingDetails(
                apiToken: replacement.hostingDetails.apiToken,
              ),
            );
          }
          throw StateError('secret-sentinel');
        });
        when(
          api.refreshDeviceApiToken,
        ).thenAnswer((_) async => confirmed('replacement'));
        final connection = realRepository(resources: resources);
        connection.apiData.apiVersion.data = '3.9.0';
        final result = await connection.refreshDeviceToken();
        expect(result.$1, isFalse);
        expect(result.$2, isNot(contains('secret-sentinel')));
        verifyNever(
          () => api.getServerJobsStream(
            onConnectionLost: any(named: 'onConnectionLost'),
          ),
        );
        await connection.reload(null);
        verify(api.refreshDeviceApiToken).called(1);
      },
    );
  }

  for (final outcome in ServerMutationOutcome.values) {
    for (final value in [
      null,
      '',
      'relative/path',
      'https://auth.example.org/ui/reset?token=abcd-0123-abcd-0123',
    ]) {
      test(
        'password-reset link needs confirmation and URI: ${outcome.name}/$value',
        () async {
          final connection = realRepository();
          when(() => api.generatePasswordResetLink('alex')).thenAnswer(
            (_) async => ServerMutationResult<String>(
              outcome: outcome,
              payload: value == null
                  ? const ServerMutationPayload.missing()
                  : ServerMutationPayload.available(value),
              message: 'secret-sentinel',
            ),
          );
          final result = await connection.generatePasswordResetLink(
            const User.fake(login: 'alex'),
          );
          expect(
            result.$1,
            outcome == ServerMutationOutcome.confirmed &&
                    value != null &&
                    value.startsWith('https:')
                ? Uri.parse(value)
                : null,
          );
          expect(result.$2, isNot(contains('secret-sentinel')));
        },
      );
    }
  }
  for (final outcome in [
    ServerMutationOutcome.rejected,
    ServerMutationOutcome.indeterminate,
  ]) {
    test('a returned token with ${outcome.name} is never saved', () async {
      final connection = realRepository();
      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult<String>(
          outcome: outcome,
          payload: const ServerMutationPayload.available('unconfirmed-token'),
        ),
      );
      expect((await connection.refreshDeviceToken()).$1, isFalse);
      expect(resourcesModel.servers.first.hostingDetails.apiToken, 'api-token');
    });
  }

  test(
    'an empty confirmed rotation token suppresses automatic retry',
    () async {
      final connection = realRepository();
      when(api.refreshDeviceApiToken).thenAnswer((_) async => confirmed(''));
      expect((await connection.refreshDeviceToken()).$1, isFalse);
      await connection.reload(null);
      verify(api.refreshDeviceApiToken).called(1);
      expect(resourcesModel.servers.first.hostingDetails.apiToken, 'api-token');
    },
  );
  test(
    'rotation saves its origin without reconnecting a different selection',
    () async {
      Server? selected = resourcesModel.servers.first;
      final pending = Completer<ServerMutationResult<String>>();
      when(api.refreshDeviceApiToken).thenAnswer((_) => pending.future);
      final connection = ApiConnectionRepository(
        resourcesModel: resourcesModel,
        api: api,
        serverSelector: () => selected,
      );
      addTearDown(connection.dispose);
      connection.apiData.apiVersion.data = '3.9.0';
      final rotation = connection.refreshDeviceToken();
      selected = null;
      pending.complete(confirmed('replacement'));
      expect((await rotation).$1, isTrue);
      expect(
        resourcesModel.servers.first.hostingDetails.apiToken,
        'replacement',
      );
      verifyNever(
        () => api.getServerJobsStream(
          onConnectionLost: any(named: 'onConnectionLost'),
        ),
      );
    },
  );
}
