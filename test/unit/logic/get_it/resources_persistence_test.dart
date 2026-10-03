import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _Box extends Mock implements Box {}

class _Api extends Mock implements ServerApi {}

void main() {
  late Box realBox;
  late _Box box;
  late ResourcesModel resources;
  Completer<void>? held;
  setUp(() async {
    await setUpInMemoryHive();
    realBox = await Hive.openBox(BNames.resourcesBox);
    box = _Box();
    held = null;
    when(
      () => box.get(any(), defaultValue: any(named: 'defaultValue')),
    ).thenAnswer(
      (final call) => realBox.get(
        call.positionalArguments.single,
        defaultValue: call.namedArguments[#defaultValue],
      ),
    );
    when(() => box.put(any(), any())).thenAnswer((final call) async {
      await held?.future;
      await realBox.put(
        call.positionalArguments[0],
        call.positionalArguments[1],
      );
    });
    when(box.flush).thenAnswer((_) => realBox.flush());
    when(box.clear).thenAnswer((_) => realBox.clear());
    when(box.compact).thenAnswer((_) => realBox.compact());
    resources = ResourcesModel(box: box)..init();
    await resources.addServer(aServer());
  });
  tearDown(() async {
    if (held != null && !held!.isCompleted) {
      held!.complete();
    }
    await resources.dispose();
    await tearDownInMemoryHive();
  });

  test('reset waits for owned writes before clearing storage', () async {
    held = Completer<void>();
    final saving = resources.updateServerByUuid(
      aServer(hostingDetails: aServerHostingDetails(apiToken: 'replacement')),
    );
    await pumpEventQueue();
    final clearing = resources.clear();
    await pumpEventQueue();
    expect(resources.servers, isEmpty);
    verifyNever(box.clear);
    held!.complete();
    await Future.wait([saving, clearing]);
    expect(realBox.get(BNames.servers), isNull);
  });

  test('disposal waits for persistence before closing notifications', () async {
    held = Completer<void>();
    final saving = resources.updateServerByUuid(
      aServer(hostingDetails: aServerHostingDetails(apiToken: 'replacement')),
    );
    await pumpEventQueue();
    var disposed = false;
    final disposing = resources.dispose().then((_) => disposed = true);
    await pumpEventQueue();
    expect(disposed, isFalse);
    held!.complete();
    await saving;
    await disposing;
    expect(disposed, isTrue);
  });

  test(
    'reset during a failed token save keeps the replacement quarantined',
    () async {
      final api = _Api();
      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('replacement'),
        ),
      );
      final hub = ServerConnectionHub(
        resourcesModel: resources,
        createApi: (_, _, _) => api,
      );
      addTearDown(hub.dispose);
      held = Completer<void>();
      final rotation = hub.rotateToken();
      await pumpEventQueue();
      expect(resources.servers.single.hostingDetails.apiToken, 'replacement');
      hub.clear();
      expect(await rotation, RotationOutcome.detached);
      held!.completeError(StateError('storage unavailable'));
      await pumpEventQueue();
      hub.resume();
      var dispatched = false;
      await hub.run(OperationKind.manageUsers, (_) async => dispatched = true);
      expect(dispatched, isFalse);
      expect(hub.canRead, isFalse);
      expect(hub.rotation.status, RotationStatus.suppressed);
      held = null;
      await resources.updateServerByUuid(
        aServer(
          hostingDetails: aServerHostingDetails(apiToken: 'manually-replaced'),
        ),
      );
      await hub.run(OperationKind.manageUsers, (_) async => dispatched = true);
      expect(dispatched, isTrue);
      expect(hub.canRead, isTrue);
    },
  );

  test('a completed token save cannot resume a reset session', () async {
    final api = _Api();
    when(api.refreshDeviceApiToken).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available('replacement'),
      ),
    );
    final hub = ServerConnectionHub(
      resourcesModel: resources,
      createApi: (_, _, _) => api,
    );
    addTearDown(hub.dispose);
    held = Completer<void>();
    final saved = resources.statusStream.firstWhere(
      (final event) => event is ChangedServers,
    );
    final rotation = hub.rotateToken();
    await pumpEventQueue();
    hub.clear();
    expect(await rotation, RotationOutcome.detached);
    held!.complete();
    await saved;
    await pumpEventQueue();
    expect(hub.active, isNull);
    expect(resources.servers.single.hostingDetails.apiToken, 'replacement');
    hub.resume();
    expect(hub.active, isNotNull);
  });

  for (final remove in [true, false]) {
    test(
      'a held rotation save cannot overwrite ${remove ? 'removal' : 'a newer binding'}',
      () async {
        final api = _Api();
        when(api.refreshDeviceApiToken).thenAnswer(
          (_) async => ServerMutationResult(
            outcome: ServerMutationOutcome.confirmed,
            payload: const ServerMutationPayload.available('replacement'),
          ),
        );
        final hub = ServerConnectionHub(
          resourcesModel: resources,
          createApi: (_, _, _) => api,
        );
        addTearDown(hub.dispose);
        held = Completer<void>();
        final rotation = hub.rotateToken();
        await pumpEventQueue();
        final newer = remove
            ? resources.removeServer(resources.servers.single)
            : resources.updateServerByUuid(
                aServer(
                  hostingDetails: aServerHostingDetails(
                    apiToken: 'newer-token',
                  ),
                ),
              );
        held!.complete();
        await newer;
        await rotation;
        final persisted = realBox.get(BNames.servers) as List;
        if (remove) {
          expect(persisted, isEmpty);
          expect(hub.active, isNull);
        } else {
          expect(
            resources.servers.single.hostingDetails.apiToken,
            'newer-token',
          );
          final reloaded = ResourcesModel(box: realBox)..init();
          expect(
            reloaded.servers.single.hostingDetails.apiToken,
            'newer-token',
          );
          await reloaded.dispose();
        }
      },
    );
  }
}
