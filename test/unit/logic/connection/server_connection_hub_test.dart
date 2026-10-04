import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/lifecycle/app_lifecycle.dart';
import 'package:selfprivacy/logic/connection/lifecycle/network_connectivity.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _Api extends Mock implements ServerApi {}

class _Lifecycle extends Mock implements AppLifecycle {}

class _Network extends Mock implements NetworkConnectivitySource {}

class _MockResources extends Mock implements ResourcesModel {}

void main() {
  late ResourcesModel resources;
  late ServerConnectionHub hub;
  late _Api api;
  setUp(() async {
    await setUpInMemoryHive();
    await Hive.openBox(BNames.resourcesBox);
    resources = ResourcesModel()..init();
    await resources.addServer(aServer());
    api = _Api();
    hub = ServerConnectionHub(
      resourcesModel: resources,
      createApi: (_, _, _) => api,
    );
    hub.active!.cache.setVersion(Version(3, 6, 0));
  });
  tearDown(() async {
    hub.dispose();
    await resources.dispose();
    await tearDownInMemoryHive();
  });

  test(
    'a retained command owner cannot dispatch through its replacement',
    () async {
      final original = hub.active!;
      await resources.updateServerByUuid(
        aServer(hostingDetails: aServerHostingDetails(apiToken: 'new-token')),
      );
      await pumpEventQueue();
      var sent = false;
      final result = await original.run(
        OperationKind.manageUsers,
        (_) async => sent = true,
      );
      expect(result, isNull);
      expect(sent, isFalse);
      expect(await original.rotateToken(), RotationOutcome.detached);
      verifyNever(api.refreshDeviceApiToken);
      expect(hub.active, isNot(same(original)));
      expect(
        await hub.active!.run(OperationKind.manageUsers, (_) async => 'new'),
        'new',
      );
    },
  );

  test(
    'manual rotation drains a workflow and preserves its connection',
    () async {
      final active = Completer<void>();
      final first = hub.active!.submit(OperationKind.manageUsers, (
        final owner,
      ) async {
        await active.future;
        await hub.active!.run(OperationKind.manageUsers, (final nested) async {
          expect(nested, same(owner));
          expect(hub.active!.rotation.status, RotationStatus.waiting);
        });
      });
      final old = hub.active!;
      final users = old.users;
      final scheduler = old.scheduler;
      old.cache.groups.push(const ['sp.full_users']);
      final timestamp = old.cache.groups.value.updatedAt;
      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('replacement'),
        ),
      );
      final rotation = hub.active!.rotateToken();
      var sent = false;
      final second = hub.active!.submit(OperationKind.manageServices, (
        final connection,
      ) async {
        sent = true;
        expect(connection, same(old));
        expect(connection.users, same(users));
        expect(connection.scheduler, same(scheduler));
        return 2;
      }, origin: old.origin);
      expect(hub.active!.rotation.status, RotationStatus.waiting);
      expect(sent, isFalse);
      active.complete();
      await first.result.timeout(const Duration(seconds: 1));
      expect(await rotation, RotationOutcome.succeeded);
      expect((await second.result).value, 2);
      expect(resources.servers.single.hostingDetails.apiToken, 'replacement');
      expect(hub.active!.cache.groups.value.data, ['sp.full_users']);
      expect(hub.active!.cache.groups.value.updatedAt, timestamp);
      expect(hub.active!.cache.groups.value.needsReconciliation, isFalse);
      expect(old.isAttached, isTrue);
    },
  );

  test('retained readers and repositories use the rotated API', () async {
    final replacement = _Api();
    final user = aMutationUser('CreateUser');
    when(api.refreshDeviceApiToken).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available('replacement'),
      ),
    );
    when(replacement.getAllGroups).thenAnswer((_) async => ['sp.full_users']);
    when(() => replacement.createUser(any(), any(), any())).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(user),
      ),
    );
    final local = ServerConnectionHub(
      resourcesModel: resources,
      createApi: (final binding, _, _) =>
          binding.token == 'replacement' ? replacement : api,
    );
    addTearDown(local.dispose);
    final connection = local.active!;
    connection.cache.setVersion(Version(3, 6, 0));
    final groups = connection.groups;
    final users = connection.users;

    expect(await local.active!.rotateToken(), RotationOutcome.succeeded);
    await groups.refresh(force: true);
    final result = await users.createUser(user);

    expect(local.active, same(connection));
    expect(groups.value.data, ['sp.full_users']);
    expect(result.outcome, ServerMutationOutcome.confirmed);
    expect(users.knownUsers, [user]);
  });

  test(
    'reading active does not replace a connection before resource notification',
    () async {
      var selected = aServer();
      var creations = 0;
      final local = ServerConnectionHub(
        resourcesModel: resources,
        selectServer: () => selected,
        createApi: (_, _, _) {
          creations++;
          return api;
        },
      );
      addTearDown(local.dispose);
      final previous = local.active!;
      selected = aServer(
        hostingDetails: aServerHostingDetails(apiToken: 'new-token'),
      );
      final updating = resources.updateServerByUuid(selected);
      expect(local.active, isNull);
      expect(creations, 1);
      expect(previous.cache.apiVersion.isDisposed, isFalse);
      await updating;
      await pumpEventQueue();
      await local.active!.run(OperationKind.manageUsers, (final owner) async {
        expect(owner, isNot(same(previous)));
      });
      expect(creations, 2);
      expect(previous.cache.apiVersion.isDisposed, isTrue);
    },
  );

  for (final field in ['server', 'domain', 'credential']) {
    test(
      '$field replacement disposes old stores and rejects old dispatch',
      () async {
        var selected = aServer();
        final dispatch = <void Function()>[];
        final local = ServerConnectionHub(
          resourcesModel: resources,
          selectServer: () => selected,
          createApi: (_, _, final beforeRequest) {
            dispatch.add(beforeRequest);
            return api;
          },
        );
        addTearDown(local.dispose);
        final old = local.active!;
        selected = switch (field) {
          'server' => aServer(uuid: 'replacement'),
          'domain' => aServer(
            domain: aServerDomain(domainName: 'replacement.example.org'),
          ),
          _ => aServer(
            hostingDetails: aServerHostingDetails(
              apiToken: 'replacement-secret',
            ),
          ),
        };
        if (field == 'server') {
          await resources.removeServer(resources.servers.single);
          await resources.addServer(selected);
        } else {
          await resources.updateServerByUuid(selected);
        }
        await pumpEventQueue();
        expect(dispatch.first, throwsA(isA<GraphQLDispatchDeferred>()));
        await local.active!.run(OperationKind.manageUsers, (final owner) async {
          expect(owner.origin.continuity, isNot(same(old.origin.continuity)));
        });
        expect(
          old.cache.stores.every((final store) => store.isDisposed),
          isTrue,
        );
        expect(dispatch.last, returnsNormally);
      },
    );
  }

  test('clear stays detached until resume; disposal cannot resume', () async {
    final old = hub.active!;
    hub.clear();
    await resources.updateServerByUuid(resources.servers.single);
    expect(hub.active, isNull);
    expect(old.cache.stores.every((final store) => store.isDisposed), isTrue);
    hub.resume();
    expect(hub.active!.origin.continuity, isNot(same(old.origin.continuity)));
    hub
      ..dispose()
      ..resume();
    expect(hub.active, isNull);
  });

  test('hosting metadata changes do not replace the connection', () async {
    final old = hub.active!;
    await resources.updateServerByUuid(
      aServer(hostingDetails: aServerHostingDetails(ip4: '203.0.113.20')),
    );
    await pumpEventQueue();
    expect(hub.active, same(old));
  });

  test(
    'run propagates unexpected failures without retaining them in history',
    () async {
      final error = StateError('private failure detail');
      await expectLater(
        hub.active!.run<void>(
          OperationKind.manageUsers,
          (_) async => throw error,
        ),
        throwsA(same(error)),
      );
      expect(
        hub.active!.operations.history.single.status,
        OperationStatus.unknown,
      );
    },
  );

  test(
    'cancelling waiting rotation releases actions without rotating',
    () async {
      final active = Completer<void>();
      final first = hub.active!.submit(
        OperationKind.manageUsers,
        (_) => active.future,
      );
      final rotation = hub.active!.rotateToken();
      final next = hub.active!.submit(
        OperationKind.manageServices,
        (_) async => 2,
      );
      expect(hub.active!.cancelRotation(), isTrue);
      expect(await rotation, RotationOutcome.cancelled);
      expect((await next.result).value, 2);
      verifyNever(api.refreshDeviceApiToken);
      active.complete();
      await first.result;
    },
  );

  test('queued work cannot cross a same-UUID credential replacement', () async {
    var selected = aServer();
    final local = ServerConnectionHub(
      resourcesModel: resources,
      selectServer: () => selected,
      createApi: (_, _, _) => api,
    );
    addTearDown(local.dispose);
    final running = Completer<void>();
    final first = local.active!.submit(
      OperationKind.manageUsers,
      (_) => running.future,
    );
    final rotation = local.active!.rotateToken();
    var dispatched = false;
    final waiting = local.active!.submit(OperationKind.manageServices, (
      _,
    ) async {
      dispatched = true;
    });
    selected = aServer(
      hostingDetails: aServerHostingDetails(apiToken: 'manually-replaced'),
    );
    await resources.updateServerByUuid(selected);
    await pumpEventQueue();
    expect((await waiting.result).status, OperationStatus.notSent);
    expect(dispatched, isFalse);
    running.complete();
    await first.result;
    await rotation;
  });

  test(
    'rotation preserves confirmed users and unfinished job effects before reads',
    () async {
      final user = aMutationUser('CreateUser');
      final job = aServiceMoveJob();
      final old = hub.active!;
      when(() => api.createUser(any(), any(), any())).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(user),
        ),
      );
      await hub.active!.run(
        OperationKind.manageUsers,
        (final owner) => owner.users.createUser(user),
      );
      old.jobs.applyConfirmed(job, affectedDomains: [old.services.store]);
      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('replacement'),
        ),
      );
      expect(await hub.active!.rotateToken(), RotationOutcome.succeeded);
      final current = hub.active!;
      expect(current.users.value.data, isNull);
      expect(current.users.knownUsers, [user]);
      expect(current.jobs.confirmedBeforeLoad.values, [job]);
      final revision = current.services.store.revision;
      current.jobs.receiveSnapshot([
        aServiceMoveJob(
          status: 'FINISHED',
          updatedAt: job.updatedAt.add(const Duration(minutes: 1)),
        ),
      ]);
      expect(current.services.store.revision, greaterThan(revision));
    },
  );

  test(
    'unknown rotation blocks repeat attempts and settles queued actions unsent',
    () async {
      final response = Completer<ServerMutationResult<String>>();
      when(api.refreshDeviceApiToken).thenAnswer((_) => response.future);
      final rotation = hub.active!.rotateToken();
      await Future<void>.delayed(Duration.zero);
      final waiting = hub.active!.submit(
        OperationKind.manageServices,
        (_) async => fail('must not dispatch'),
      );
      response.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.indeterminate,
          payload: const ServerMutationPayload.unreadable(),
        ),
      );
      expect(await rotation, RotationOutcome.unknown);
      expect((await waiting.result).status, OperationStatus.notSent);
      expect(await hub.active!.rotateToken(), RotationOutcome.suppressed);
      verify(api.refreshDeviceApiToken).called(1);
    },
  );

  test('server removal rejects waiting actions without dispatch', () async {
    final active = Completer<void>();
    final first = hub.active!.submit(
      OperationKind.manageUsers,
      (_) => active.future,
    );
    final rotation = hub.active!.rotateToken();
    final next = hub.active!.submit(
      OperationKind.manageServices,
      (_) async => fail('must not dispatch'),
    );
    await resources.removeServer(resources.servers.single);
    expect(hub.active, isNull);
    expect((await next.result).status, OperationStatus.notSent);
    expect(await rotation, RotationOutcome.detached);
    active.complete();
    await first.result;
  });

  test(
    'hub starts its canonical scheduler and pauses passive dispatch hidden',
    () async {
      final visibility = StreamController<bool>.broadcast(sync: true);
      var foreground = false;
      final lifecycle = _Lifecycle();
      when(() => lifecycle.isForeground).thenAnswer((_) => foreground);
      when(
        () => lifecycle.foregroundChanges,
      ).thenAnswer((_) => visibility.stream);
      final network = _Network();
      when(
        network.check,
      ).thenAnswer((_) async => NetworkConnectivity.available);
      when(() => network.changes).thenAnswer((_) => const Stream.empty());
      when(api.getApiVersion).thenAnswer((_) async => '3.6.0');
      when(api.fetchApiVersion).thenAnswer((_) async => '3.6.0');
      when(
        () => api.getServerJobsStream(
          onConnectionState: any(named: 'onConnectionState'),
        ),
      ).thenAnswer((_) => const Stream.empty());
      hub.start(lifecycle: lifecycle, connectivity: network);
      expect(hub.active!.scheduler, isNotNull);
      await Future<void>.delayed(Duration.zero);
      verifyNever(api.getApiVersion);
      foreground = true;
      visibility.add(true);
      await Future<void>.delayed(Duration.zero);
      verify(api.getApiVersion).called(1);
      hub.dispose();
      await visibility.close();
    },
  );
  test('token rotation updates only the selected server', () async {
    await resources.addServer(
      aServer(
        uuid: 'second-server',
        domain: aServerDomain(domainName: 'second.example'),
        hostingDetails: aServerHostingDetails(apiToken: 'second-token'),
      ),
    );
    final selectedApi = _Api();
    when(selectedApi.refreshDeviceApiToken).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available('rotated-token'),
      ),
    );
    final selectedRepository = ServerConnectionHub(
      resourcesModel: resources,
      selectServer: () => resources.servers.firstWhere(
        (final server) => server.uuid == 'second-server',
      ),
      createApi: (_, _, _) => selectedApi,
    );
    addTearDown(selectedRepository.dispose);

    final result = await selectedRepository.active!.rotateToken();

    expect(result, RotationOutcome.succeeded);
    expect(resources.servers.first.hostingDetails.apiToken, 'api-token');
    expect(
      resources.servers
          .firstWhere((final server) => server.uuid == 'second-server')
          .hostingDetails
          .apiToken,
      'rotated-token',
    );
  });
  ServerConnectionHub realHub({final ResourcesModel? resourceOverride}) {
    final result = ServerConnectionHub(
      resourcesModel: resourceOverride ?? resources,
      createApi: (_, _, _) => api,
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

  test('rotation is single-flight and saves the replacement', () async {
    final pending = Completer<ServerMutationResult<String>>();
    when(api.refreshDeviceApiToken).thenAnswer((_) => pending.future);
    final connection = realHub();
    final first = connection.active!.rotateToken();
    final second = connection.active!.rotateToken();
    pending.complete(confirmed('replacement'));
    expect(await first, RotationOutcome.succeeded);
    expect(await second, RotationOutcome.succeeded);
    verify(api.refreshDeviceApiToken).called(1);
    expect(resources.servers.first.hostingDetails.apiToken, 'replacement');
    expect(
      (Hive.box(BNames.resourcesBox).get(BNames.servers) as List<Server>)
          .first
          .hostingDetails
          .apiToken,
      'replacement',
    );
  });

  for (final outcome in ServerMutationOutcome.values) {
    test(
      'unusable ${outcome.name} rotation keeps credentials and gates automatic retry',
      () async {
        final connection = realHub();
        when(api.refreshDeviceApiToken).thenAnswer(
          (_) async => ServerMutationResult<String>(
            outcome: outcome,
            payload: const ServerMutationPayload.missing(),
            message: 'secret-sentinel',
          ),
        );
        final result = await connection.active!.rotateToken();
        expect(result, isNot(RotationOutcome.succeeded));

        expect(resources.servers.first.hostingDetails.apiToken, 'api-token');
        await connection.active!.rotateToken();
        verify(
          api.refreshDeviceApiToken,
        ).called(outcome == ServerMutationOutcome.rejected ? 2 : 1);
      },
    );
  }

  test(
    'recovery with another credential clears rotation suppression',
    () async {
      final connection = realHub();
      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult<String>(
          outcome: ServerMutationOutcome.indeterminate,
          payload: const ServerMutationPayload.unreadable(),
        ),
      );
      await connection.active!.rotateToken();
      await connection.active!.rotateToken();
      verify(api.refreshDeviceApiToken).called(1);

      final original = resources.servers.first;
      await resources.updateServerByUuid(
        aServer(
          uuid: original.uuid,
          hostingDetails: aServerHostingDetails(apiToken: 'recovered'),
        ),
      );
      when(
        api.refreshDeviceApiToken,
      ).thenAnswer((_) async => confirmed('replacement'));
      await connection.active!.rotateToken();
      await pumpEventQueue();
      verify(api.refreshDeviceApiToken).called(1);
      expect(resources.servers.first.hostingDetails.apiToken, 'replacement');
    },
  );

  test('a late rotation does not overwrite a recovered credential', () async {
    final connection = realHub();
    final pending = Completer<ServerMutationResult<String>>();
    when(api.refreshDeviceApiToken).thenAnswer((_) => pending.future);
    final rotation = connection.active!.rotateToken();
    final original = resources.servers.first;
    await resources.updateServerByUuid(
      aServer(
        uuid: original.uuid,
        hostingDetails: aServerHostingDetails(apiToken: 'recovered'),
      ),
    );
    pending.complete(confirmed('obsolete-replacement'));
    expect(await rotation, RotationOutcome.detached);
    expect(resources.servers.first.hostingDetails.apiToken, 'recovered');
  });

  for (final updatesMemory in [false, true]) {
    test(
      'persistence failure suppresses retry, memory updated=$updatesMemory',
      () async {
        registerFallbackValue(aServer());
        final resources = _MockResources();
        when(
          () => resources.statusStream,
        ).thenAnswer((_) => const Stream.empty());
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
        final connection = realHub(resourceOverride: resources);
        connection.active!.cache.setVersion(Version(3, 9, 0));
        final result = await connection.active!.rotateToken();
        expect(result, isNot(RotationOutcome.succeeded));

        verifyNever(
          () => api.getServerJobsStream(
            onConnectionLost: any(named: 'onConnectionLost'),
          ),
        );
        await connection.active!.rotateToken();
        verify(api.refreshDeviceApiToken).called(1);
      },
    );
  }

  for (final outcome in [
    ServerMutationOutcome.rejected,
    ServerMutationOutcome.indeterminate,
  ]) {
    test('a returned token with ${outcome.name} is never saved', () async {
      final connection = realHub();
      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult<String>(
          outcome: outcome,
          payload: const ServerMutationPayload.available('unconfirmed-token'),
        ),
      );
      expect(
        await connection.active!.rotateToken(),
        isNot(RotationOutcome.succeeded),
      );
      expect(resources.servers.first.hostingDetails.apiToken, 'api-token');
    });
  }

  test(
    'an empty confirmed rotation token suppresses automatic retry',
    () async {
      final connection = realHub();
      when(api.refreshDeviceApiToken).thenAnswer((_) async => confirmed(''));
      expect(
        await connection.active!.rotateToken(),
        isNot(RotationOutcome.succeeded),
      );
      await connection.active!.rotateToken();
      verify(api.refreshDeviceApiToken).called(1);
      expect(resources.servers.first.hostingDetails.apiToken, 'api-token');
    },
  );
  test('an unsent rotation is detached when its server is removed', () async {
    Server? selected = resources.servers.first;
    final pending = Completer<ServerMutationResult<String>>();
    when(api.refreshDeviceApiToken).thenAnswer((_) => pending.future);
    final connection = ServerConnectionHub(
      resourcesModel: resources,
      createApi: (_, _, _) => api,
      selectServer: () => selected,
    );
    addTearDown(connection.dispose);
    connection.active!.cache.setVersion(Version(3, 9, 0));
    final rotation = connection.active!.rotateToken();
    final removing = resources.removeServer(selected);
    selected = null;
    await removing;
    pending.complete(confirmed('replacement'));
    expect(await rotation, RotationOutcome.detached);
    expect(resources.servers, isEmpty);
    verifyNever(
      () => api.getServerJobsStream(
        onConnectionLost: any(named: 'onConnectionLost'),
      ),
    );
  });
}
