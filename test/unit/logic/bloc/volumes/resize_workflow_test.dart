import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/volumes/volumes_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/logic/operations/volumes/resize_volume_operation.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';

import '../../../../helpers/fixtures/json_fixture.dart';
import '../../../../helpers/fixtures/server_fixtures.dart';
import '../../../../helpers/operation_fixture.dart';
import '../../../../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

class _Provider extends Mock implements ServerProvider {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late _Api api;
  late _Provider provider;
  late ServerConnectionHub hub;
  late List<String> messages;
  setUp(() {
    api = _Api();
    provider = _Provider();
    messages = [];
    hub = fixtureHub(api);
    hub.active!.cache.volumes.push(
      Query$GetServerDiskVolumes.fromJson(
        loadJsonFixture('graphql/domain_reads.json')['GetServerDiskVolumes']
            as Map<String, dynamic>,
      ).storage.volumes.map(ServerDiskVolume.fromGraphQL).toList(),
    );
    when(() => provider.isAuthorized).thenReturn(true);
    when(
      () => provider.getVolumes(),
    ).thenAnswer((_) async => GenericResult(success: true, data: []));
  });

  VolumesBloc createBloc({final bool withoutProvider = false}) =>
      createVolumesBloc(
        hub.active!,
        providerChanges: const Stream.empty(),
        serverProvider: () => withoutProvider ? null : provider,
        showMessage: messages.add,
      );

  for (final unsupported in [false, true]) {
    test('initial volume read settles: unsupported=$unsupported', () async {
      hub
        ..clear()
        ..resume();
      hub.active!.cache.setVersion(
        unsupported ? Version(1, 0, 0) : Version(3, 6, 0),
      );
      when(api.getServerDiskVolumes).thenThrow(StateError('unavailable'));
      final bloc = createBloc(withoutProvider: true);
      addTearDown(bloc.close);
      await hub.active!.volumes.refresh(force: true);
      await pumpEventQueue();
      expect(bloc.state, isNot(isA<VolumesLoading>()));
      expect(bloc.state, isNot(isA<VolumesLoaded>()));
      expect((bloc.state as VolumesUnavailable).isUnsupported, unsupported);
    });
  }

  test('provider reads cannot repopulate state after reset', () async {
    final pending = Completer<GenericResult<List<ServerProviderVolume>>>();
    when(() => provider.getVolumes()).thenAnswer((_) => pending.future);
    final bloc = createBloc();
    await Future<void>.delayed(Duration.zero);
    hub.clear();
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state, isA<VolumesInitial>());
    pending.complete(
      GenericResult(success: true, data: [aServerProviderVolume()]),
    );
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state, isA<VolumesInitial>());
    await bloc.close();
  });

  test('a retained resize choice cannot cross a reset', () async {
    final bloc = createBloc();
    addTearDown(bloc.close);
    await pumpEventQueue();
    final volume = aServerProviderVolume();
    const size = DiskSize(byte: 20000000000);
    final choice = VolumeResize(
      origin: bloc.state.origin,
      DiskVolume(name: 'sdb', providerVolume: volume),
      size,
    );
    final volumes = hub.active!.cache.volumes.value.data!;
    hub
      ..clear()
      ..resume();
    hub.active!.cache.setVersion(Version(3, 6, 0));
    hub.active!.cache.volumes.push(volumes);
    await pumpEventQueue();
    when(
      () => provider.resizeVolume(volume, size),
    ).thenAnswer((_) async => GenericResult(success: false, data: false));
    bloc.add(choice);
    await pumpEventQueue();
    verifyNever(() => provider.resizeVolume(volume, size));
  });

  test('missing provider credentials have no price', () async {
    final bloc = createBloc(withoutProvider: true);
    await Future<void>.delayed(Duration.zero);
    expect(await bloc.getPricePerGb(), isNull);
    await bloc.close();
  });

  testWidgets(
    'unexpected provider failure settles resize without leaking its error',
    (final tester) async {
      await pumpForTest(tester, const SizedBox.shrink());
      final providerVolume = aServerProviderVolume();
      const size = DiskSize(byte: 20000000000);
      when(
        () => provider.resizeVolume(providerVolume, size),
      ).thenThrow(Exception('secret-sentinel'));
      final bloc = createBloc();
      await tester.pump();
      bloc.add(
        VolumeResize(
          origin: bloc.state.origin,
          DiskVolume(name: 'sdb', providerVolume: providerVolume),
          size,
        ),
      );
      await tester.pump();
      expect(bloc.state, isA<VolumesLoaded>());
      expect(messages, contains('server_mutation.outcome_unknown'.tr()));
      expect(messages, isNot(contains('secret-sentinel')));
      await tester.runAsync(() async {
        final closing = bloc.close();
        await Future<void>.delayed(Duration.zero);
        await tester.pump();
        await closing;
      });
      hub.dispose();
    },
  );

  testWidgets('provider resize failure is not a successful operation', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    final providerVolume = aServerProviderVolume();
    const size = DiskSize(byte: 20000000000);
    when(
      () => provider.resizeVolume(providerVolume, size),
    ).thenAnswer((_) async => GenericResult(success: false, data: false));
    final bloc = createBloc();
    await tester.pump();
    bloc.add(
      VolumeResize(
        origin: bloc.state.origin,
        DiskVolume(name: 'sdb', providerVolume: providerVolume),
        size,
      ),
    );
    await tester.pump();
    expect(
      hub.active!.operations.history.single.status,
      OperationStatus.failed,
    );
    expect(messages, contains('storage.extending_volume_error'.tr()));
    verifyNever(() => api.resizeVolume('sdb'));
    await tester.runAsync(() async {
      final closing = bloc.close();
      await Future<void>.delayed(Duration.zero);
      await tester.pump();
      await closing;
    });
    hub.dispose();
  });

  for (final outcome in ServerMutationOutcome.values) {
    testWidgets('resize workflow continues only after $outcome', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      final providerVolume = aServerProviderVolume();
      final volume = DiskVolume(name: 'sdb', providerVolume: providerVolume);
      const size = DiskSize(byte: 20000000000);
      when(
        () => provider.resizeVolume(providerVolume, size),
      ).thenAnswer((_) async => GenericResult(success: true, data: true));
      when(() => api.resizeVolume('sdb')).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      when(api.reboot).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.indeterminate,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      final bloc = createBloc();
      await tester.pump();
      expect(bloc.state, isA<VolumesLoaded>());
      bloc.add(VolumeResize(origin: bloc.state.origin, volume, size));
      await tester.pump();
      expect(bloc.state, isA<VolumesResizing>());
      await tester.pump(const Duration(seconds: 10));
      if (outcome == ServerMutationOutcome.confirmed) {
        expect(hub.active!.volumes.value.needsReconciliation, isTrue);
        await tester.pump(const Duration(seconds: 20));
        verify(api.reboot).called(1);
        expect(messages, contains('server_mutation.outcome_unknown'.tr()));
      } else {
        await tester.pump(const Duration(seconds: 60));
        verifyNever(api.reboot);
        final key = outcome == ServerMutationOutcome.rejected
            ? 'server_mutation.rejected'
            : 'server_mutation.outcome_unknown';
        expect(messages, contains(key.tr()));
      }
      expect(bloc.state, isA<VolumesLoaded>());
      verify(() => api.resizeVolume('sdb')).called(1);
      expect(hub.active!.operations.history, hasLength(1));
      final steps = hub.active!.operations.history.single.steps;
      expect(steps.map((final step) => step.id), [
        'provider',
        'providerWait',
        'filesystem',
        if (outcome == ServerMutationOutcome.confirmed) ...[
          'serverWait',
          'reboot',
        ],
      ]);
      expect(
        steps.firstWhere((final step) => step.id == 'filesystem').status,
        switch (outcome) {
          ServerMutationOutcome.confirmed => OperationStatus.succeeded,
          ServerMutationOutcome.rejected => OperationStatus.rejected,
          ServerMutationOutcome.indeterminate => OperationStatus.unknown,
        },
      );
      await tester.runAsync(() async {
        final closing = bloc.close();
        await Future<void>.delayed(Duration.zero);
        await tester.pump();
        await closing;
      });
      hub.dispose();
    });
  }

  testWidgets(
    'reset during provider wait prevents filesystem resize and reboot',
    (final tester) async {
      await pumpForTest(tester, const SizedBox.shrink());
      await tester.runAsync(pumpEventQueue);
      final providerVolume = aServerProviderVolume();
      const size = DiskSize(byte: 20000000000);
      when(
        () => provider.resizeVolume(providerVolume, size),
      ).thenAnswer((_) async => GenericResult(success: true, data: true));
      final stages = <VolumeResizeStage>[];
      final operation = hub.active!.submit(
        OperationKind.manageVolumes,
        (final connection) =>
            ResizeVolumeOperation(
              volumes: connection.volumes,
              provider: provider,
            ).resize(
              name: 'sdb',
              providerVolume: providerVolume,
              size: size,
              onProgress: stages.add,
            ),
      );
      await tester.pump();
      expect(stages, [
        VolumeResizeStage.started,
        VolumeResizeStage.providerWaiting,
      ]);
      hub.clear();
      await tester.pump();
      await tester.pump(const Duration(seconds: 30));
      expect((await operation.result).status, OperationStatus.unknown);
      expect(stages, [
        VolumeResizeStage.started,
        VolumeResizeStage.providerWaiting,
      ]);
      verifyNever(() => api.resizeVolume('sdb'));
      verifyNever(api.reboot);
      hub.dispose();
    },
  );
}
