import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../../helpers/fixtures/json_fixture.dart';
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
  setUpAll(() async {
    await setUpInMemoryHive();
    registerFallbackValue(SshSettings(enable: false));
    registerFallbackValue(
      AutoUpgradeSettings(enable: false, allowReboot: false),
    );
  });
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

  final userCalls = <String, Future<(bool, String)> Function(User)>{
    'CreateUser': (final user) => repository.createUser(user),
    'UpdateUser': (final user) => repository.updateUser(user),
    'AddSshKey': (final user) => repository.addSshKey(user, 'fixture-key'),
    'RemoveSshKey': (final user) =>
        repository.deleteSshKey(user, 'fixture-key'),
  };
  for (final call in userCalls.entries) {
    group(call.key, () {
      late User returned;
      late Completer<ServerMutationResult<User>> response;
      setUp(() {
        returned = aMutationUser(call.key);
        response = Completer<ServerMutationResult<User>>();
        when(
          () => api.createUser(any(), any(), any()),
        ).thenAnswer((_) => response.future);
        when(
          () => api.updateUser(any(), any(), any()),
        ).thenAnswer((_) => response.future);
        when(
          () => api.addSshKey(any(), any()),
        ).thenAnswer((_) => response.future);
        when(
          () => api.removeSshKey(any(), any()),
        ).thenAnswer((_) => response.future);
        repository.apiData.users.data = [];
      });
      test(
        'applies the returned user and publishes without aging other entries',
        () async {
          final timestamp = repository.apiData.users.lastUpdated;
          final pending = call.value(returned);
          final published = repository.dataStream.first;
          response.complete(
            ServerMutationResult(
              outcome: ServerMutationOutcome.confirmed,
              payload: ServerMutationPayload.available(returned),
            ),
          );
          expect((await pending).$1, isTrue);
          expect((await published).users.data, [returned]);
          expect(repository.apiData.users.lastUpdated, timestamp);
        },
      );
      test('upserts a user added while the mutation was in flight', () async {
        final pending = call.value(returned);
        repository.apiData.users.data!.add(aMutationUser('CreateUser'));
        response.complete(
          ServerMutationResult(
            outcome: ServerMutationOutcome.confirmed,
            payload: ServerMutationPayload.available(returned),
          ),
        );
        expect((await pending).$1, isTrue);
        expect(repository.apiData.users.data, [returned]);
      });
      for (final outcome in [
        ServerMutationOutcome.rejected,
        ServerMutationOutcome.indeterminate,
      ]) {
        test('$outcome never applies the returned user', () async {
          response.complete(
            ServerMutationResult(
              outcome: outcome,
              payload: ServerMutationPayload.available(returned),
            ),
          );
          expect((await call.value(returned)).$1, isFalse);
          expect(repository.apiData.users.data, isEmpty);
          expect(repository.apiData.users.isExpired, isFalse);
        });
      }
      test(
        'missing confirmed user invalidates without reporting usable data',
        () async {
          response.complete(
            ServerMutationResult(
              outcome: ServerMutationOutcome.confirmed,
              payload: const ServerMutationPayload.missing(),
            ),
          );
          expect((await call.value(returned)).$1, isFalse);
          expect(repository.apiData.users.data, isEmpty);
          expect(repository.apiData.users.isExpired, isTrue);
        },
      );
      test(
        'a list lost during the request is seeded but remains incomplete',
        () async {
          final pending = call.value(returned);
          repository.apiData.users.data = null;
          response.complete(
            ServerMutationResult(
              outcome: ServerMutationOutcome.confirmed,
              payload: ServerMutationPayload.available(returned),
            ),
          );
          expect((await pending).$1, isTrue);
          expect(repository.apiData.users.data, [returned]);
          expect(repository.apiData.users.isExpired, isTrue);
        },
      );
      test('unloaded users prevent a request', () async {
        repository.apiData.users.data = null;
        expect((await call.value(returned)).$1, isFalse);
        verifyZeroInteractions(api);
      });
    });
  }

  test('create refuses a user already found on the server', () async {
    final user = aMutationUser('CreateUser');
    repository.apiData.users.data = [user];
    expect((await repository.createUser(user)).$1, isFalse);
    verifyNever(() => api.createUser(any(), any(), any()));
  });

  for (final outcome in ServerMutationOutcome.values) {
    test('deleteUser only removes on confirmation: $outcome', () async {
      final user = aMutationUser('CreateUser');
      repository.apiData.users.data = [user];
      when(() => api.deleteUser(user.login)).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      expect(
        (await repository.deleteUser(user)).$1,
        outcome == ServerMutationOutcome.confirmed,
      );
      expect(
        repository.apiData.users.data,
        outcome == ServerMutationOutcome.confirmed ? isEmpty : [user],
      );
    });
    test(
      'deleteEmailPassword only removes on confirmation: $outcome',
      () async {
        final user = aUserWithEmailPasswords();
        repository.apiData.users.data = [user];
        when(() => api.deleteEmailPassword(user.login, 'remove')).thenAnswer(
          (_) async => ServerMutationResult(
            outcome: outcome,
            payload: const ServerMutationPayload.notExpected(),
          ),
        );
        expect(
          (await repository.deleteEmailPassword(user, 'remove')).$1,
          outcome == ServerMutationOutcome.confirmed,
        );
        expect(
          repository.apiData.users.data!.single.emailPasswordMetadata!.map(
            (final entry) => entry.uuid,
          ),
          outcome == ServerMutationOutcome.confirmed
              ? ['keep']
              : ['remove', 'keep'],
        );
      },
    );
    test('job removal waits for confirmation: $outcome', () async {
      final job = aServiceMoveJob();
      repository.apiData.serverJobs.data = [job];
      final response = Completer<ServerMutationResult<void>>();
      when(() => api.removeApiJob(job.uid)).thenAnswer((_) => response.future);
      final pending = repository.removeServerJob(job.uid);
      expect(repository.apiData.serverJobs.data, [job]);
      response.complete(
        ServerMutationResult(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      expect((await pending).outcome, outcome);
      expect(
        repository.apiData.serverJobs.data,
        outcome == ServerMutationOutcome.confirmed ? isEmpty : [job],
      );
    });
    test('service configuration feedback is secret safe: $outcome', () async {
      repository.apiData.services.data = [];
      when(() => api.setServiceConfiguration('outline', any())).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
          message: 'SECRET_SENTINEL',
        ),
      );
      final result = await repository.setServiceConfiguration('outline', {
        'setting': true,
      });
      expect(result.$1, outcome == ServerMutationOutcome.confirmed);
      expect(result.$2, isNot(contains('SECRET_SENTINEL')));
      expect(
        repository.apiData.services.isExpired,
        outcome == ServerMutationOutcome.confirmed,
      );
    });
  }

  test('email password deletion tolerates missing user data', () async {
    final user = aMutationUser('CreateUser');
    repository.apiData.users.data = [];
    when(() => api.deleteEmailPassword(user.login, 'password-id')).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    expect(
      (await repository.deleteEmailPassword(user, 'password-id')).$1,
      isTrue,
    );
    expect(repository.apiData.users.isExpired, isTrue);
  });

  test(
    'bulk job deletion retains failed entries and skips running jobs',
    () async {
      final removed = aServiceMoveJob(uid: 'removed', status: 'FINISHED');
      final rejected = aServiceMoveJob(uid: 'rejected', status: 'ERROR');
      final uncertain = aServiceMoveJob(uid: 'uncertain', status: 'FINISHED');
      final running = aServiceMoveJob();
      repository.apiData.serverJobs.data = [
        removed,
        rejected,
        uncertain,
        running,
      ];
      for (final (job, outcome) in [
        (removed, ServerMutationOutcome.confirmed),
        (rejected, ServerMutationOutcome.rejected),
        (uncertain, ServerMutationOutcome.indeterminate),
      ]) {
        when(() => api.removeApiJob(job.uid)).thenAnswer(
          (_) async => ServerMutationResult(
            outcome: outcome,
            payload: const ServerMutationPayload.notExpected(),
          ),
        );
      }
      final results = await repository.removeAllFinishedServerJobs();
      expect(results.keys, ['removed', 'rejected', 'uncertain']);
      expect(results['rejected']!.outcome, ServerMutationOutcome.rejected);
      expect(
        results['uncertain']!.outcome,
        ServerMutationOutcome.indeterminate,
      );
      expect(repository.apiData.serverJobs.data, [
        rejected,
        uncertain,
        running,
      ]);
      verifyNever(() => api.removeApiJob(running.uid));
    },
  );

  test('bulk removal with no loaded jobs sends no mutations', () async {
    expect(await repository.removeAllFinishedServerJobs(), isEmpty);
    verifyNever(() => api.removeApiJob(any()));
  });

  group('returned system settings', () {
    late SystemSettings original;
    setUp(() {
      original = SystemSettings.fromGraphQL(
        Query$SystemSettings.fromJson(
          loadJsonFixture('graphql/domain_reads.json')['SystemSettings']
              as Map<String, dynamic>,
        ).system,
      );
      repository.apiData.settings.data = original;
    });
    test('timezone updates preserve other settings and snapshot age', () async {
      repository.apiData.settings.invalidate();
      final age = repository.apiData.settings.lastUpdated;
      when(() => api.setTimezone('requested')).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('UTC'),
        ),
      );
      expect((await repository.setServerTimezone('requested')).$1, isTrue);
      final updated = repository.apiData.settings.data!;
      expect(updated.timezone, 'UTC');
      expect(updated.autoUpgradeSettings, same(original.autoUpgradeSettings));
      expect(updated.sshSettings, same(original.sshSettings));
      expect(repository.apiData.settings.lastUpdated, age);
    });
    test('SSH and auto-upgrade use returned values, not the input', () async {
      final age = repository.apiData.settings.lastUpdated;
      when(() => api.setSshSettings(any())).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(SshSettings(enable: false)),
        ),
      );
      when(() => api.setAutoUpgradeSettings(any())).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(
            AutoUpgradeSettings(enable: false, allowReboot: false),
          ),
        ),
      );
      expect((await repository.setSshSettings(enable: true)).$1, isTrue);
      expect(
        (await repository.setAutoUpgradeSettings(
          enable: true,
          allowReboot: true,
        )).$1,
        isTrue,
      );
      final updated = repository.apiData.settings.data!;
      expect(updated.sshSettings.enable, isFalse);
      expect(updated.autoUpgradeSettings.enable, isFalse);
      expect(updated.autoUpgradeSettings.allowReboot, isFalse);
      expect(updated.timezone, original.timezone);
      expect(repository.apiData.settings.lastUpdated, age);
    });
    for (final outcome in [
      ServerMutationOutcome.rejected,
      ServerMutationOutcome.indeterminate,
    ]) {
      test('$outcome never applies returned settings', () async {
        when(() => api.setTimezone(any())).thenAnswer(
          (_) async => ServerMutationResult(
            outcome: outcome,
            payload: const ServerMutationPayload.available('UTC'),
          ),
        );
        expect((await repository.setServerTimezone('UTC')).$1, isFalse);
        expect(repository.apiData.settings.data, same(original));
        expect(repository.apiData.settings.isExpired, isFalse);
      });
    }
    test(
      'missing confirmed timezone invalidates without inventing settings',
      () async {
        when(() => api.setTimezone(any())).thenAnswer(
          (_) async => ServerMutationResult(
            outcome: ServerMutationOutcome.confirmed,
            payload: const ServerMutationPayload.missing(),
          ),
        );
        expect((await repository.setServerTimezone('UTC')).$1, isTrue);
        expect(repository.apiData.settings.data, same(original));
        expect(repository.apiData.settings.isExpired, isTrue);
      },
    );
    test(
      'partial returned settings do not fabricate an unloaded snapshot',
      () async {
        repository.apiData.settings.data = null;
        when(() => api.setTimezone(any())).thenAnswer(
          (_) async => ServerMutationResult(
            outcome: ServerMutationOutcome.confirmed,
            payload: const ServerMutationPayload.available('UTC'),
          ),
        );
        expect((await repository.setServerTimezone('UTC')).$1, isTrue);
        expect(repository.apiData.settings.data, isNull);
        expect(repository.apiData.settings.isExpired, isTrue);
      },
    );
  });

  for (final outcome in ServerMutationOutcome.values) {
    test('server-job payload application requires $outcome confirmation', () {
      final job = aServiceMoveJob();
      repository.apiData.serverJobs.data = [];
      repository.applyServerJobMutation(
        ServerMutationResult(
          outcome: outcome,
          payload: ServerMutationPayload.available(job),
        ),
      );
      expect(
        repository.apiData.serverJobs.data,
        outcome == ServerMutationOutcome.confirmed ? [job] : isEmpty,
      );
    });
  }
  test(
    'server-job payload replaces duplicate IDs without refreshing the list',
    () {
      repository.apiData.serverJobs
        ..data = [aServiceMoveJob(status: 'CREATED')]
        ..invalidate();
      final job = aServiceMoveJob();
      repository.applyServerJobMutation(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(job),
        ),
      );
      expect(repository.apiData.serverJobs.data, [job]);
      expect(repository.apiData.serverJobs.isExpired, isTrue);
    },
  );
  test('server-job payload seeds an unloaded list as incomplete', () {
    final job = aServiceMoveJob();
    repository.applyServerJobMutation(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(job),
      ),
    );
    expect(repository.apiData.serverJobs.data, [job]);
    expect(repository.apiData.serverJobs.isExpired, isTrue);
  });
  test('missing confirmed server-job payload invalidates the list', () {
    repository.apiData.serverJobs.data = [];
    repository.applyServerJobMutation(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.missing(),
      ),
    );
    expect(repository.apiData.serverJobs.data, isEmpty);
    expect(repository.apiData.serverJobs.isExpired, isTrue);
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
      (_) async => ServerMutationResult<User>(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available(updatedUser),
      ),
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
