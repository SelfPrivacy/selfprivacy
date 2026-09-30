import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';

import '../../../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../../../helpers/fixtures/json_fixture.dart';
import '../../../../helpers/widget_harness.dart';

class _Repository extends Mock implements ApiConnectionRepository {}

class _Api extends Mock implements ServerApi {}

class _Navigation extends Mock implements NavigationService {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late _Repository repository;
  late _Api api;
  late _Navigation navigation;
  late ApiData data;
  late Service service;
  late ServicesBloc services;
  late ServerJobsBloc jobs;
  late ServerConnection connection;

  setUp(() {
    repository = _Repository();
    api = _Api();
    navigation = _Navigation();
    final origin = ServerStateOrigin('server');
    connection = ServerConnection(
      api: api,
      origin: origin,
      currentOrigin: () => origin,
    )..setVersion(Version(3, 0, 0));
    when(() => repository.connection).thenReturn(connection);
    data = ApiData(api, connection: () => connection);
    connection.services.store.push(
      Query$AllServices.fromJson(
        loadJsonFixture('graphql/domain_reads.json')['AllServices']
            as Map<String, dynamic>,
      ).services.allServices.map(Service.fromGraphQL).toList(),
    );
    service = data.services.data!.first;
    when(() => repository.api).thenReturn(api);
    when(() => repository.apiData).thenReturn(data);
    when(() => repository.dataStream).thenAnswer((_) => const Stream.empty());
    when(
      () => repository.connectionStatus,
    ).thenReturn(ConnectionStatus.connected);
    getIt
      ..registerSingleton<ApiConnectionRepository>(repository)
      ..registerSingleton<NavigationService>(navigation);
    services = ServicesBloc();
    jobs = ServerJobsBloc();
  });
  tearDown(() async {
    await services.close();
    await jobs.close();
    connection.dispose();
    await getIt.reset();
  });

  for (final outcome in ServerMutationOutcome.values) {
    testWidgets('restart handles $outcome with translated feedback', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      when(() => api.restartService(service.id)).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await tester.runAsync(() async {
        services.add(ServiceRestart(service));
        await pumpEventQueue();
      });
      expect(data.services.isExpired, isTrue);
      expect(
        services.state.isServiceLocked(service.id),
        outcome == ServerMutationOutcome.confirmed,
      );
      if (outcome == ServerMutationOutcome.confirmed) {
        verifyNever(() => navigation.showSnackBar(any()));
      } else {
        final key = outcome == ServerMutationOutcome.rejected
            ? 'server_mutation.rejected'
            : 'server_mutation.outcome_unknown';
        expect(key.tr(), isNot(key));
        verify(() => navigation.showSnackBar(key.tr())).called(1);
      }
    });
    testWidgets('move applies a returned job only for $outcome', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      final job = aServiceMoveJob();
      await tester.runAsync(() async => connection.jobs.store.push([]));
      when(() => api.moveService(service.id, 'sdb')).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: outcome,
          payload: ServerMutationPayload.available(job),
        ),
      );
      await tester.runAsync(() async {
        services.add(ServiceMove(service, 'sdb'));
        await pumpEventQueue();
      });
      expect(
        data.serverJobs.data,
        outcome == ServerMutationOutcome.confirmed ? [job] : isEmpty,
      );
      if (outcome != ServerMutationOutcome.confirmed) {
        verify(() => navigation.showSnackBar(any())).called(1);
      }
    });
    testWidgets('toggle client job requires $outcome confirmation', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      when(
        () => api.switchService(serviceId: service.id, needTurnOn: true),
      ).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      final result = await ServiceToggleJob(
        service: service,
        needToTurnOn: true,
      ).execute();
      expect(result.$1, outcome == ServerMutationOutcome.confirmed);
      expect(data.services.isExpired, isTrue);
    });
    testWidgets('job deletion reports $outcome', (final tester) async {
      await pumpForTest(tester, const SizedBox.shrink());
      when(() => repository.removeServerJob('job-1')).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await tester.runAsync(() async {
        jobs.add(const RemoveServerJob('job-1'));
        await pumpEventQueue();
      });
      if (outcome == ServerMutationOutcome.confirmed) {
        verifyNever(() => navigation.showSnackBar(any()));
      } else {
        verify(() => navigation.showSnackBar(any())).called(1);
      }
    });
  }

  testWidgets('confirmed move without a job warns and invalidates', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    connection.jobs.store.push([]);
    when(() => api.moveService(service.id, 'sdb')).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.missing(),
      ),
    );
    await tester.runAsync(() async {
      services.add(ServiceMove(service, 'sdb'));
      await pumpEventQueue();
    });
    expect(data.serverJobs.data, isEmpty);
    expect(data.serverJobs.isExpired, isTrue);
    const key = 'server_mutation.payload_unavailable';
    expect(key.tr(), isNot(key));
    verify(() => navigation.showSnackBar(key.tr())).called(1);
  });
  testWidgets('move upserts an existing job and preserves stale status', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    final updated = aServiceMoveJob();
    connection.jobs.store
      ..push([aServiceMoveJob(status: 'CREATED')])
      ..invalidate();
    when(() => api.moveService(service.id, 'sdb')).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(updated),
      ),
    );
    await tester.runAsync(() async {
      services.add(ServiceMove(service, 'sdb'));
      await pumpEventQueue();
    });
    expect(data.serverJobs.data, [updated]);
    expect(data.serverJobs.isExpired, isTrue);
  });
  testWidgets('move seeds unloaded jobs without marking the list complete', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    final job = aServiceMoveJob();
    when(() => api.moveService(service.id, 'sdb')).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(job),
      ),
    );
    await tester.runAsync(() async {
      services.add(ServiceMove(service, 'sdb'));
      await pumpEventQueue();
    });
    expect(data.serverJobs.data, isNull);
    expect(connection.jobs.confirmedBeforeLoad[job.uid], job);
    expect(data.serverJobs.isExpired, isTrue);
  });

  for (final outcome in ServerMutationOutcome.values) {
    testWidgets('migration applies only the typed result: $outcome', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      connection.volumesStore.push([]);
      final result = ServerMutationResult(
        outcome: outcome,
        payload: ServerMutationPayload.available(aServiceMoveJob()),
      );
      when(
        () => api.migrateToBinds({'gitea': 'sdb'}, 'sda1'),
      ).thenAnswer((_) async => result);
      await jobs.migrateToBinds({'gitea': 'sdb'});
      expect(
        connection.jobs.confirmedBeforeLoad.isNotEmpty,
        outcome == ServerMutationOutcome.confirmed,
      );
      if (outcome == ServerMutationOutcome.confirmed) {
        verifyNever(
          () =>
              navigation.showSnackBar(any(), behavior: any(named: 'behavior')),
        );
      } else {
        verify(
          () => navigation.showSnackBar(
            any(),
            behavior: SnackBarBehavior.floating,
          ),
        ).called(1);
      }
    });
  }
  testWidgets('migration uses the loaded root volume as fallback', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    connection.volumesStore.push(
      Query$GetServerDiskVolumes.fromJson(
        loadJsonFixture('graphql/domain_reads.json')['GetServerDiskVolumes']
            as Map<String, dynamic>,
      ).storage.volumes.map(ServerDiskVolume.fromGraphQL).toList(),
    );
    final root = data.volumes.data!.firstWhere((final volume) => volume.root);
    final result = ServerMutationResult(
      outcome: ServerMutationOutcome.confirmed,
      payload: ServerMutationPayload.available(aServiceMoveJob()),
    );
    when(
      () => api.migrateToBinds({}, root.name),
    ).thenAnswer((_) async => result);
    await jobs.migrateToBinds({});
    verify(() => api.migrateToBinds({}, root.name)).called(1);
  });

  testWidgets(
    'migration with missing confirmed job reports unavailable payload',
    (final tester) async {
      await pumpForTest(tester, const SizedBox.shrink());
      final result = ServerMutationResult<ServerJob>(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.missing(),
      );
      when(
        () => api.migrateToBinds({}, 'sda1'),
      ).thenAnswer((_) async => result);
      await jobs.migrateToBinds({});
      verify(
        () => navigation.showSnackBar(
          'server_mutation.payload_unavailable'.tr(),
          behavior: SnackBarBehavior.floating,
        ),
      ).called(1);
    },
  );

  testWidgets('bulk deletion reports each failed result only', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    when(repository.removeAllFinishedServerJobs).thenAnswer(
      (_) async => {
        'deleted': ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        ),
        'rejected': ServerMutationResult(
          outcome: ServerMutationOutcome.rejected,
          payload: const ServerMutationPayload.notExpected(),
        ),
        'unknown': ServerMutationResult(
          outcome: ServerMutationOutcome.indeterminate,
          payload: const ServerMutationPayload.notExpected(),
        ),
      },
    );
    await tester.runAsync(() async {
      jobs.add(RemoveAllFinishedJobs());
      await pumpEventQueue();
    });
    verify(
      () => navigation.showSnackBar('server_mutation.rejected'.tr()),
    ).called(1);
    verify(
      () => navigation.showSnackBar('server_mutation.outcome_unknown'.tr()),
    ).called(1);
    verifyNoMoreInteractions(navigation);
  });
}
