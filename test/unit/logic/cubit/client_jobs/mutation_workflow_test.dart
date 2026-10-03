import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';

import '../../../../helpers/connection_fixture.dart';
import '../../../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../../../helpers/fixtures/server_fixtures.dart';
import '../../../../helpers/operation_fixture.dart';
import '../../../../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

class _Resources extends Mock implements ResourcesModel {}

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    registerFallbackValue(SshSettings(enable: true));
  });
  late _Api api;
  late List<String> messages;
  late ServerConnectionHub hub;
  late JobsCubit cubit;
  late ServerConnection connection;
  setUp(() async {
    api = _Api();
    messages = [];
    hub = fixtureHub(api);
    connection = hub.active!..setVersion(Version(3, 0, 0));
    final resources = _Resources();
    when(() => resources.servers).thenReturn([aServer()]);
    when(api.getDnsRecords).thenAnswer((_) async => []);
    when(() => api.setTimezone(any())).thenAnswer(
      (final call) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(
          call.positionalArguments.single as String,
        ),
      ),
    );
    cubit = createJobsCubit(
      hub,
      resources: resources,
      dnsProvider: () => null,
      showMessage: messages.add,
    );
    await pumpEventQueue();
  });
  tearDown(() async {
    await cubit.close();
    hub.dispose();
  });

  test(
    'reset clears pending client jobs without waiting for another server',
    () async {
      cubit.addJob(ChangeServerTimezoneJob(timezone: 'Europe/Helsinki'));
      hub.clear();
      await pumpEventQueue();
      expect(cubit.state, isA<JobsStateEmpty>());
    },
  );

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
        final feedback = await clientJobWorkflow(
          connection,
        ).execute(CollectNixGarbageJob());
        expect(feedback.outcome, outcome);
        expect(
          connection.jobs.confirmedBeforeLoad.isNotEmpty,
          outcome == ServerMutationOutcome.confirmed,
        );
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
          expect(
            connection.jobs.confirmedBeforeLoad.isNotEmpty,
            outcome == ServerMutationOutcome.confirmed && hasJob,
          );
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
    when(() => api.setServiceConfiguration('gitea', any())).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    when(() => api.setTimezone('Europe/Helsinki')).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.indeterminate,
        payload: const ServerMutationPayload.missing(),
      ),
    );
    cubit
      ..addJob(
        ChangeServiceConfiguration(
          serviceId: 'gitea',
          serviceDisplayName: 'Gitea',
          settings: const {},
        ),
      )
      ..addJob(ChangeServerTimezoneJob(timezone: 'Europe/Helsinki'));
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
    when(api.reboot).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    cubit.addJob(RebootServerJob());
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
        cubit.addJob(ChangeServerTimezoneJob(timezone: 'Europe/Helsinki'));
        messages.clear();
        await tester.runAsync(cubit.applyAll);
        expect(
          connection.jobs.confirmedBeforeLoad.isNotEmpty,
          outcome == ServerMutationOutcome.confirmed && payload.value != null,
        );
        expect(
          cubit.state is JobsStateLoading,
          outcome == ServerMutationOutcome.confirmed && payload.value != null,
        );
        if (outcome != ServerMutationOutcome.confirmed ||
            payload.status == ServerMutationPayloadStatus.missing) {
          expect(messages, hasLength(1));
        } else {
          expect(messages, isEmpty);
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
      connection.jobs.store.push([aServiceMoveJob(uid: 'other')]);
      await pumpEventQueue();
    });
    expect(cubit.state, isA<JobsStateLoading>());
    await tester.runAsync(() async {
      connection.jobs.store.push([aServiceMoveJob(status: 'FINISHED')]);
      await pumpEventQueue();
    });
    expect(cubit.state, isA<JobsStateFinished>());
  });

  testWidgets('a detached workflow never dispatches its later jobs', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    when(() => api.setTimezone('Europe/Helsinki')).thenAnswer((_) async {
      hub.clear();
      return ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available('Europe/Helsinki'),
      );
    });
    cubit
      ..addJob(ChangeServerTimezoneJob(timezone: 'Europe/Helsinki'))
      ..addJob(ChangeSshSettingsJob(enable: true));
    await tester.runAsync(cubit.applyAll);
    verifyNever(() => api.setSshSettings(any()));
    expect(cubit.state, isA<JobsStateEmpty>());
    verifyNever(api.apply);
  });
}
