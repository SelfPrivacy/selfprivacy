import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/repositories/devices_repository.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

import '../../../../helpers/fixtures/json_fixture.dart';
import '../../../../helpers/operation_fixture.dart';
import '../../../../helpers/widget_harness.dart';

class _MockApi extends Mock implements ServerApi {}

class _MockNavigation extends Mock implements NavigationService {}

void main() {
  late _MockApi api;
  late _MockNavigation navigation;
  late DevicesRepository devices;
  late ServerConnection connection;
  late DevicesBloc bloc;
  late ApiToken device;

  setUpAll(setUpWidgetTestHarness);

  setUp(() async {
    await getIt.reset();
    api = _MockApi();
    navigation = _MockNavigation();
    final data =
        loadJsonFixture('graphql/domain_reads.json')['GetApiTokens']
            as Map<String, dynamic>;
    final tokens = Query$GetApiTokens.fromJson(
      data,
    ).api.devices.map(ApiToken.fromGraphQL).toList();
    device = tokens.firstWhere((final token) => !token.isCaller);
    when(api.getApiTokens).thenAnswer((_) async => tokens);
    final hub = fixtureHub(api);
    connection = hub.active!;
    devices = connection.devices;
    await devices.refresh();
    bloc = createDevicesBloc(hub.active!, showMessage: navigation.showSnackBar);
    await bloc.stream.firstWhere((final state) => state.isLoaded);
  });

  tearDown(() async {
    await bloc.close();
    connection.dispose();
    await getIt.reset();
  });

  for (final closeScope in [false, true]) {
    test(
      'rotation drops duplicates and late feedback: close=$closeScope',
      () async {
        final source = StreamController<CachedValue<List<ApiToken>>?>(
          sync: true,
        );
        final pending = Completer<RotationOutcome>();
        final feedback = <String>[];
        var rotations = 0;
        final scoped = DevicesBloc(
          devices: source.stream,
          refresh: () async {},
          revoke: (_) async => null,
          generateKey: (_) async => null,
          showMessage: feedback.add,
          rotationChanges: const Stream.empty(),
          cancelRotation: () => false,
          rotateToken: () {
            rotations++;
            return pending.future;
          },
        );
        source.add(CachedValue(data: [device]));
        scoped
          ..add(const RotateDeviceToken())
          ..add(const RotateDeviceToken());
        await pumpEventQueue();
        expect(rotations, 1);
        final closing = closeScope ? scoped.close() : null;
        if (!closeScope) {
          source.add(null);
        }
        pending.complete(RotationOutcome.rejected);
        await pumpEventQueue();
        await closing;
        expect(feedback, isEmpty);
        await scoped.close();
        await source.close();
      },
    );
  }

  test('seeds immutable state from the current snapshot', () {
    expect(bloc.state.devices, devices.value.data);
    expect(bloc.state.isLoaded, isTrue);
    expect(() => bloc.state.devices.clear(), throwsUnsupportedError);
    expect(() => bloc.state.otherDevices.clear(), throwsUnsupportedError);
  });

  test('refresh failure retains the last valid list', () async {
    final before = bloc.state;
    when(api.getApiTokens).thenAnswer((_) async => []);
    final failed = bloc.stream.firstWhere((final state) => state.hasError);
    await bloc.refresh();
    expect((await failed).devices, before.devices);
    expect(bloc.state.isLoaded, isTrue);
    expect(before.hasError, isFalse);
  });

  test('duplicate revoke events are dropped while pending', () async {
    final pending = Completer<ServerMutationResult<void>>();
    when(
      () => api.deleteApiToken(device.name),
    ).thenAnswer((_) => pending.future);
    final deleting = bloc.stream.firstWhere(
      (final state) => state is DevicesDeleting,
    );
    bloc
      ..add(DeleteDevice(device))
      ..add(DeleteDevice(device));
    await deleting;
    await pumpEventQueue();
    verify(() => api.deleteApiToken(device.name)).called(1);
    final loaded = bloc.stream.firstWhere(
      (final state) => state is DevicesLoaded,
    );
    pending.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    await loaded;
    expect(bloc.state.otherDevices, isEmpty);
    expect(bloc.state.isLoaded, isTrue);
  });

  test('closing the BLoC does not cancel a confirmed domain effect', () async {
    final pending = Completer<ServerMutationResult<void>>();
    when(
      () => api.deleteApiToken(device.name),
    ).thenAnswer((_) => pending.future);
    final deleting = bloc.stream.firstWhere(
      (final state) => state is DevicesDeleting,
    );
    bloc.add(DeleteDevice(device));
    await deleting;
    final closing = bloc.close();
    await pumpEventQueue();
    pending.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    await closing;
    await pumpEventQueue();
    expect(
      devices.value.data!.any((final token) => token.name == device.name),
      isFalse,
    );
    verifyNever(() => navigation.showSnackBar(any()));
  });

  test(
    'detaching a pending command produces no old-session feedback',
    () async {
      final pending = Completer<ServerMutationResult<void>>();
      when(
        () => api.deleteApiToken(device.name),
      ).thenAnswer((_) => pending.future);
      final deleting = bloc.stream.firstWhere(
        (final state) => state is DevicesDeleting,
      );
      bloc.add(DeleteDevice(device));
      await deleting;
      connection.dispose();
      pending.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.rejected,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await pumpEventQueue();
      verifyNever(() => navigation.showSnackBar(any()));
    },
  );

  for (final outcome in ServerMutationOutcome.values) {
    testWidgets('device deletion handles ${outcome.name}', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      await tester.runAsync(() async {
        final originalData = List<ApiToken>.of(devices.value.data!);
        final originalState = bloc.state;
        final pending = Completer<ServerMutationResult<void>>();
        when(
          () => api.deleteApiToken(device.name),
        ).thenAnswer((_) => pending.future);
        final deleting = bloc.stream.firstWhere(
          (final state) => state is DevicesDeleting,
        );
        bloc.add(DeleteDevice(device));
        await deleting;
        expect(bloc.state.devices, originalData);
        expect(bloc.state.pendingDeviceName, device.name);

        final loaded = bloc.stream.firstWhere(
          (final state) => state is DevicesLoaded,
        );
        pending.complete(
          ServerMutationResult(
            outcome: outcome,
            payload: const ServerMutationPayload.notExpected(),
            message: outcome == ServerMutationOutcome.rejected
                ? 'Deletion rejected'
                : null,
          ),
        );
        await loaded;

        final expectedDevices = outcome == ServerMutationOutcome.confirmed
            ? originalData
                  .where((final token) => token.name != device.name)
                  .toList()
            : originalData;
        expect(devices.value.data, expectedDevices);
        expect(bloc.state.devices, expectedDevices);
        expect(originalState.devices, originalData);
        if (outcome == ServerMutationOutcome.confirmed) {
          verifyNever(() => navigation.showSnackBar(any()));
        } else {
          final expected = outcome == ServerMutationOutcome.indeterminate
              ? 'server_mutation.outcome_unknown'.tr()
              : 'Deletion rejected';
          expect(expected, isNot('server_mutation.outcome_unknown'));
          verify(() => navigation.showSnackBar(expected)).called(1);
        }
        verify(() => api.deleteApiToken(device.name)).called(1);
      });
    });
  }

  testWidgets('device rejection without a message uses translated fallback', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    await tester.runAsync(() async {
      when(() => api.deleteApiToken(device.name)).thenAnswer(
        (_) async => ServerMutationResult<void>(
          outcome: ServerMutationOutcome.rejected,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      final loaded = bloc.stream.firstWhere(
        (final state) => state is DevicesLoaded,
      );
      bloc.add(DeleteDevice(device));
      await loaded;
      final message = 'server_mutation.rejected'.tr();
      expect(message, isNot('server_mutation.rejected'));
      verify(() => navigation.showSnackBar(message)).called(1);
    });
  });
  for (final outcome in ServerMutationOutcome.values) {
    for (final secret in ['fixture-secret', '', null]) {
      testWidgets('device key ${outcome.name}/$secret', (final tester) async {
        await pumpForTest(tester, const SizedBox.shrink());
        await tester.runAsync(() async {
          final result = ServerMutationResult<String>(
            outcome: outcome,
            payload: secret == null
                ? const ServerMutationPayload.missing()
                : ServerMutationPayload.available(secret),
            message: 'secret-sentinel',
          );
          when(api.createDeviceToken).thenAnswer((_) async => result);
          final key = await bloc.getNewDeviceKey();
          if (outcome == ServerMutationOutcome.confirmed &&
              secret == 'fixture-secret') {
            expect(key, secret);
            verifyNever(() => navigation.showSnackBar(any()));
          } else {
            expect(key, isNull);
            final failureKey = switch (outcome) {
              ServerMutationOutcome.confirmed =>
                'server_mutation.payload_unavailable',
              ServerMutationOutcome.rejected => 'server_mutation.rejected',
              ServerMutationOutcome.indeterminate =>
                'server_mutation.outcome_unknown',
            };
            final message = failureKey.tr();
            expect(message, isNot(failureKey));
            verify(() => navigation.showSnackBar(message)).called(1);
          }
        });
      });
    }
  }
}
