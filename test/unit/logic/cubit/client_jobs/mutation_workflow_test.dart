import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import '../../../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../../../helpers/widget_harness.dart';

class _Repository extends Mock implements ApiConnectionRepository {}

class _Api extends Mock implements ServerApi {}

class _Navigation extends Mock implements NavigationService {}

class _ActionJob extends ClientJob {
  _ActionJob({
    required this.succeeds,
    required final String id,
    super.requiresRebuild,
    super.requiresDnsUpdate,
    super.status,
    super.message,
  }) : super(id: id, title: id);
  final bool succeeds;
  @override
  Future<(bool, String)> execute() async =>
      (succeeds, succeeds ? 'done' : 'uncertain');
  @override
  _ActionJob copyWithNewStatus({
    required final JobStatusEnum status,
    final String? message,
  }) => _ActionJob(
    succeeds: succeeds,
    id: id,
    requiresRebuild: requiresRebuild,
    requiresDnsUpdate: requiresDnsUpdate,
    status: status,
    message: message,
  );
}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late _Repository repository;
  late _Api api;
  late _Navigation navigation;
  late JobsCubit cubit;
  late ApiData data;
  late StreamController<ApiData> stream;
  setUp(() {
    repository = _Repository();
    api = _Api();
    navigation = _Navigation();
    data = ApiData(api);
    stream = StreamController<ApiData>.broadcast();
    when(() => repository.api).thenReturn(api);
    when(() => repository.apiData).thenReturn(data);
    when(() => repository.dataStream).thenAnswer((_) => stream.stream);
    when(api.getDnsRecords).thenAnswer((_) async => []);
    getIt
      ..registerSingleton<ApiConnectionRepository>(repository)
      ..registerSingleton<NavigationService>(navigation);
    cubit = JobsCubit();
  });
  tearDown(() async {
    await cubit.close();
    await stream.close();
    await getIt.reset();
  });

  for (final outcome in ServerMutationOutcome.values) {
    testWidgets(
      'queued garbage collection uses $outcome and retains the result',
      (final tester) async {
        await pumpForTest(tester, const SizedBox.shrink());
        final result = ServerMutationResult(
          outcome: outcome,
          payload: ServerMutationPayload.available(aServiceMoveJob()),
        );
        when(api.collectNixGarbage).thenAnswer((_) async => result);
        final feedback = await CollectNixGarbageJob().execute();
        expect(feedback.$1, outcome == ServerMutationOutcome.confirmed);
        verify(() => repository.applyServerJobMutation(result)).called(1);
      },
    );
    testWidgets('reboot reports $outcome', (final tester) async {
      await pumpForTest(tester, const SizedBox.shrink());
      when(api.reboot).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await cubit.rebootServer();
      final job = (cubit.state as JobsStateFinished).clientJobList.single;
      expect(
        job.status,
        outcome == ServerMutationOutcome.confirmed
            ? JobStatusEnum.finished
            : JobStatusEnum.error,
      );
      expect(job.message, isNotEmpty);
      await cubit.rebootServer();
      verify(api.reboot).called(1);
    });
    for (final action in ['upgrade', 'garbage']) {
      for (final hasJob in [true, false]) {
        testWidgets('$action / $outcome / job=$hasJob', (final tester) async {
          await pumpForTest(tester, const SizedBox.shrink());
          final job = aServiceMoveJob();
          final result = ServerMutationResult<ServerJob>(
            outcome: outcome,
            payload: hasJob
                ? ServerMutationPayload.available(job)
                : const ServerMutationPayload.missing(),
          );
          when(api.upgrade).thenAnswer((_) async => result);
          when(api.collectNixGarbage).thenAnswer((_) async => result);
          if (action == 'upgrade') {
            await cubit.upgradeServer();
          } else {
            await cubit.collectNixGarbage();
          }
          verify(() => repository.applyServerJobMutation(result)).called(1);
          if (outcome == ServerMutationOutcome.confirmed && hasJob) {
            expect(cubit.state, isA<JobsStateLoading>());
            expect(cubit.state.rebuildJobUid, job.uid);
          } else {
            final state = cubit.state as JobsStateFinished;
            expect(state.rebuildJobUid, isNull);
            expect(
              state.clientJobList.single.status,
              outcome == ServerMutationOutcome.confirmed
                  ? JobStatusEnum.finished
                  : JobStatusEnum.error,
            );
            if (outcome == ServerMutationOutcome.confirmed) {
              expect(
                state.clientJobList.single.message,
                'server_mutation.payload_unavailable'.tr(),
              );
            }
          }
        });
      }
    }
  }
  testWidgets('mixed command results stop DNS updates and rebuild', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    cubit
      ..addJob(
        _ActionJob(succeeds: true, id: 'success', requiresDnsUpdate: true),
      )
      ..addJob(_ActionJob(succeeds: false, id: 'uncertain'));
    await tester.runAsync(cubit.applyAll);
    final state = cubit.state as JobsStateFinished;
    expect(state.clientJobList.map((final job) => job.status), [
      JobStatusEnum.finished,
      JobStatusEnum.error,
      JobStatusEnum.error,
    ]);
    verifyNever(api.apply);
    verify(api.getDnsRecords).called(1);
  });
  testWidgets('successful commands without rebuild do not request one', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    cubit.addJob(
      _ActionJob(succeeds: true, id: 'no-rebuild', requiresRebuild: false),
    );
    await tester.runAsync(cubit.applyAll);
    expect(cubit.state, isA<JobsStateFinished>());
    verifyNever(api.apply);
  });
  for (final outcome in ServerMutationOutcome.values) {
    for (final payload in [
      ServerMutationPayload.available(aServiceMoveJob()),
      const ServerMutationPayload<ServerJob>.missing(),
      const ServerMutationPayload<ServerJob>.notExpected(),
    ]) {
      testWidgets('rebuild / $outcome / ${payload.status}', (
        final tester,
      ) async {
        await pumpForTest(tester, const SizedBox.shrink());
        final result = ServerMutationResult(outcome: outcome, payload: payload);
        when(api.apply).thenAnswer((_) async => result);
        cubit.addJob(_ActionJob(succeeds: true, id: 'change'));
        clearInteractions(navigation);
        await tester.runAsync(cubit.applyAll);
        verify(() => repository.applyServerJobMutation(result)).called(1);
        expect(
          cubit.state is JobsStateLoading,
          outcome == ServerMutationOutcome.confirmed && payload.value != null,
        );
        if (outcome != ServerMutationOutcome.confirmed ||
            payload.status == ServerMutationPayloadStatus.missing) {
          verify(() => navigation.showSnackBar(any())).called(1);
        } else {
          verifyNever(() => navigation.showSnackBar(any()));
        }
      });
    }
  }
  testWidgets('a missing tracked job does not prove completion', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    final job = aServiceMoveJob();
    when(api.upgrade).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(job),
      ),
    );
    await cubit.upgradeServer();
    await tester.runAsync(() async {
      data.serverJobs.data = [aServiceMoveJob(uid: 'other')];
      stream.add(data);
      await pumpEventQueue();
    });
    expect(cubit.state, isA<JobsStateLoading>());
    await tester.runAsync(() async {
      data.serverJobs.data = [aServiceMoveJob(status: 'FINISHED')];
      stream.add(data);
      await pumpEventQueue();
    });
    expect(cubit.state, isA<JobsStateFinished>());
  });
}
