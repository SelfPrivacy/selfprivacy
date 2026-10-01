import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/lifecycle/app_lifecycle.dart';
import 'package:selfprivacy/logic/connection/lifecycle/network_connectivity.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _Api extends Mock implements ServerApi {}

class _Lifecycle extends Mock implements AppLifecycle {}

class _Network extends Mock implements NetworkConnectivitySource {}

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
    hub.active!.setVersion(Version(3, 6, 0));
  });
  tearDown(() async {
    hub.dispose();
    await resources.dispose();
    await tearDownInMemoryHive();
  });

  test(
    'manual rotation drains a workflow and admits queued work on its replacement',
    () async {
      final active = Completer<void>();
      final first = hub.submit(OperationKind.manageUsers, (final owner) async {
        await active.future;
        await hub.run(OperationKind.manageUsers, (final nested) async {
          expect(nested, same(owner));
          expect(hub.rotation.status, RotationStatus.waiting);
        });
      });
      final old = hub.active!;
      old.cache.groups.push(const ['sp.full_users']);
      final timestamp = old.cache.groups.value.updatedAt;
      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('replacement'),
        ),
      );
      final rotation = hub.rotateToken();
      var sent = false;
      final second = hub.submit(OperationKind.manageServices, (
        final connection,
      ) async {
        sent = true;
        expect(connection, isNot(same(old)));
        return 2;
      });
      expect(hub.rotation.status, RotationStatus.waiting);
      expect(sent, isFalse);
      active.complete();
      await first.completion.timeout(const Duration(seconds: 1));
      expect(await rotation, RotationOutcome.succeeded);
      expect((await second.completion).value, 2);
      expect(resources.servers.single.hostingDetails.apiToken, 'replacement');
      expect(hub.active!.cache.groups.value.data, ['sp.full_users']);
      expect(hub.active!.cache.groups.value.updatedAt, timestamp);
      expect(hub.active!.cache.groups.value.needsReconciliation, isTrue);
      expect(old.isAttached, isFalse);
    },
  );

  test(
    'reading active does not replace a session before an admission boundary',
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
      expect(local.active, isNull);
      expect(creations, 1);
      expect(previous.cache.apiVersion.isDisposed, isFalse);
      await local.run(OperationKind.manageUsers, (final owner) async {
        expect(owner, isNot(same(previous)));
      });
      expect(creations, 2);
      expect(previous.cache.apiVersion.isDisposed, isTrue);
    },
  );

  test(
    'run propagates unexpected failures without retaining them in history',
    () async {
      final error = StateError('private failure detail');
      await expectLater(
        hub.run<void>(OperationKind.manageUsers, (_) async => throw error),
        throwsA(same(error)),
      );
      expect(
        hub.operationsFor(resources.servers.single.uuid).history.single.status,
        OperationStatus.unknown,
      );
    },
  );

  test(
    'cancelling waiting rotation releases actions without rotating',
    () async {
      final active = Completer<void>();
      final first = hub.submit(OperationKind.manageUsers, (_) => active.future);
      final rotation = hub.rotateToken();
      final next = hub.submit(OperationKind.manageServices, (_) async => 2);
      expect(hub.cancelRotation(), isTrue);
      expect(await rotation, RotationOutcome.cancelled);
      expect((await next.completion).value, 2);
      verifyNever(api.refreshDeviceApiToken);
      active.complete();
      await first.completion;
    },
  );

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
      await hub.run(
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
      expect(await hub.rotateToken(), RotationOutcome.succeeded);
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
      final rotation = hub.rotateToken();
      await Future<void>.delayed(Duration.zero);
      final waiting = hub.submit(
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
      expect((await waiting.completion).status, OperationStatus.notSent);
      expect(await hub.rotateToken(), RotationOutcome.suppressed);
      verify(api.refreshDeviceApiToken).called(1);
    },
  );

  test('server removal rejects waiting actions without dispatch', () async {
    final active = Completer<void>();
    final first = hub.submit(OperationKind.manageUsers, (_) => active.future);
    final rotation = hub.rotateToken();
    final next = hub.submit(
      OperationKind.manageServices,
      (_) async => fail('must not dispatch'),
    );
    await resources.removeServer(resources.servers.single);
    expect(hub.active, isNull);
    expect((await next.completion).status, OperationStatus.notSent);
    expect(await rotation, RotationOutcome.detached);
    active.complete();
    await first.completion;
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
}
