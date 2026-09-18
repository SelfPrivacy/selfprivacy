import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

import '../../../../helpers/fixtures/json_fixture.dart';
import '../../../../helpers/widget_harness.dart';

class _MockRepository extends Mock implements ApiConnectionRepository {}

class _MockApi extends Mock implements ServerApi {}

class _MockNavigation extends Mock implements NavigationService {}

void main() {
  late _MockRepository repository;
  late _MockApi api;
  late _MockNavigation navigation;
  late ApiData apiData;
  late StreamController<ApiData> controller;
  late DevicesBloc bloc;
  late ApiToken device;

  setUpAll(setUpWidgetTestHarness);

  setUp(() async {
    await getIt.reset();
    repository = _MockRepository();
    api = _MockApi();
    navigation = _MockNavigation();
    apiData = ApiData(api);
    final data =
        loadJsonFixture('graphql/domain_reads.json')['GetApiTokens']
            as Map<String, dynamic>;
    apiData.devices.data = Query$GetApiTokens.fromJson(
      data,
    ).api.devices.map(ApiToken.fromGraphQL).toList();
    device = apiData.devices.data!.firstWhere((final token) => !token.isCaller);
    controller = StreamController<ApiData>.broadcast();
    when(() => repository.api).thenReturn(api);
    when(() => repository.apiData).thenReturn(apiData);
    when(() => repository.dataStream).thenAnswer((_) => controller.stream);
    getIt
      ..registerSingleton<ApiConnectionRepository>(repository)
      ..registerSingleton<NavigationService>(navigation);
    bloc = DevicesBloc();
  });

  tearDown(() async {
    await bloc.close();
    await controller.close();
    await getIt.reset();
  });

  for (final outcome in ServerMutationOutcome.values) {
    testWidgets('device deletion handles ${outcome.name}', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      await tester.runAsync(() async {
        final originalData = List<ApiToken>.of(apiData.devices.data!);
        final pending = Completer<ServerMutationResult<void>>();
        when(
          () => api.deleteApiToken(device.name),
        ).thenAnswer((_) => pending.future);
        final deleting = bloc.stream.firstWhere(
          (final state) => state is DevicesDeleting,
        );
        bloc.add(DeleteDevice(device));
        await deleting;
        expect(apiData.devices.isExpired, isFalse);

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

        expect(apiData.devices.data, originalData);
        expect(
          apiData.devices.isExpired,
          outcome == ServerMutationOutcome.confirmed,
        );
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
        verifyNever(() => repository.reload(any()));
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
            final message = result.secretFailureKey.tr();
            expect(message, isNot(result.secretFailureKey));
            verify(() => navigation.showSnackBar(message)).called(1);
          }
        });
      });
    }
  }
}
