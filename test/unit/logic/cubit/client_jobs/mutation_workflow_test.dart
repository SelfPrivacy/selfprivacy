import 'dart:async';

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
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

import '../../../../helpers/connection_fixture.dart';
import '../../../../helpers/fixtures/dns_record_fixtures.dart';
import '../../../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../../../helpers/fixtures/server_fixtures.dart';
import '../../../../helpers/fixtures/service_fixtures.dart';
import '../../../../helpers/operation_fixture.dart';
import '../../../../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

class _Resources extends Mock implements ResourcesModel {}

class _DnsProvider extends Mock implements DnsProvider {}

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
  late _Resources resources;
  DnsProvider? dnsProvider;
  setUp(() async {
    api = _Api();
    messages = [];
    hub = fixtureHub(api);
    connection = hub.active!..cache.setVersion(Version(3, 0, 0));
    resources = _Resources();
    dnsProvider = null;
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
      hub.active!,
      resources: resources,
      dnsProvider: () => dnsProvider,
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

  test(
    'DNS update keeps the operation provider and domain across a held command',
    () async {
      final original = _DnsProvider();
      final replacement = _DnsProvider();
      final domain = resources.servers.single.domain;
      dnsProvider = original;
      final before = [aDnsRecord()];
      final after = [aDnsRecord(content: '203.0.113.11')];
      var reads = 0;
      when(
        api.getDnsRecords,
      ).thenAnswer((_) async => reads++ == 0 ? before : after);
      when(() => original.isAuthorized).thenReturn(true);
      when(
        () => original.updateDnsRecords(
          newRecords: after,
          oldRecords: before,
          domain: domain,
        ),
      ).thenAnswer((_) async => GenericResult(success: true, data: null));
      final sent = Completer<void>();
      final receipt = Completer<ServerMutationResult<void>>();
      when(
        () => api.switchService(serviceId: 'gitea', needTurnOn: false),
      ).thenAnswer((_) {
        sent.complete();
        return receipt.future;
      });
      when(api.apply).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(aServiceMoveJob()),
        ),
      );
      cubit.addJob(ServiceToggleJob(service: aService(), needToTurnOn: false));
      final applying = cubit.applyAll();
      await sent.future;
      dnsProvider = replacement;
      when(() => resources.servers).thenReturn([
        aServer(domain: aServerDomain(domainName: 'replacement.example.org')),
      ]);
      receipt.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await applying;
      verify(
        () => original.updateDnsRecords(
          newRecords: after,
          oldRecords: before,
          domain: domain,
        ),
      ).called(1);
      verifyZeroInteractions(replacement);
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
        final feedback = await configurationOperation(
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
      final job = (cubit.state as JobsStateFinished).steps.single;
      expect(job.status, switch (outcome) {
        ServerMutationOutcome.confirmed => OperationStatus.succeeded,
        ServerMutationOutcome.rejected => OperationStatus.rejected,
        ServerMutationOutcome.indeterminate => OperationStatus.unknown,
      });
      expect(job.messageKey, isNotEmpty);
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
            final step = (cubit.state as JobsStateLoading).steps.single;
            expect(step.status, OperationStatus.accepted);
            expect(step.messageKey, 'operations.status.accepted');
          } else {
            final state = cubit.state as JobsStateFinished;
            expect(state.rebuildJobUid, isNull);
            expect(
              state.steps.single.status,
              outcome == ServerMutationOutcome.rejected
                  ? OperationStatus.rejected
                  : OperationStatus.unknown,
            );
            if (outcome == ServerMutationOutcome.confirmed) {
              expect(
                state.steps.single.messageKey,
                'server_mutation.payload_unavailable',
              );
            }
          }
        });
      }
    }
  }
  test(
    'closing the cubit does not stop submitted configuration work',
    () async {
      final receipt = Completer<ServerMutationResult<String>>();
      final sent = Completer<void>();
      when(() => api.setTimezone('Europe/Helsinki')).thenAnswer((_) {
        sent.complete();
        return receipt.future;
      });
      final job = aServiceMoveJob();
      when(api.apply).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(job),
        ),
      );
      cubit.addJob(ChangeServerTimezoneJob(timezone: 'Europe/Helsinki'));
      final applying = cubit.applyAll();
      await sent.future;
      await cubit.close();
      receipt.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('Europe/Helsinki'),
        ),
      );
      await applying;
      expect(connection.jobs.confirmedBeforeLoad.keys, contains(job.uid));
      final steps = connection.operations.history.single.steps;
      expect(steps.map((final step) => step.status), [
        OperationStatus.succeeded,
        OperationStatus.accepted,
      ]);
      expect(steps.last.jobId, job.uid);
    },
  );

  test(
    'recreating the UI cannot start another configuration batch while a job runs',
    () async {
      when(api.apply).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(aServiceMoveJob()),
        ),
      );
      cubit.addJob(ChangeServerTimezoneJob(timezone: 'Europe/Helsinki'));
      await cubit.applyAll();
      await cubit.close();
      cubit = createJobsCubit(
        connection,
        resources: resources,
        dnsProvider: () => dnsProvider,
        showMessage: messages.add,
      );
      await pumpEventQueue();
      cubit.addJob(ChangeServerTimezoneJob(timezone: 'Europe/Berlin'));
      await cubit.applyAll();
      expect(cubit.state, isA<JobsStateWithJobs>());
      verifyNever(() => api.setTimezone('Europe/Berlin'));
      verify(api.apply).called(1);
      var independentRan = false;
      await connection.run(OperationKind.manageUsers, (_) async {
        independentRan = true;
      });
      expect(independentRan, isTrue);
      connection.operations.observeJob(aServiceMoveJob().uid, succeeded: true);
      await cubit.applyAll();
      verify(() => api.setTimezone('Europe/Berlin')).called(1);
    },
  );

  test(
    'submitted changes leave only safe progress and a separate draft',
    () async {
      final response = Completer<ServerMutationResult<void>>();
      when(
        () => api.setServiceConfiguration('gitea', any()),
      ).thenAnswer((_) => response.future);
      when(api.apply).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(aServiceMoveJob()),
        ),
      );
      cubit.addJob(
        ChangeServiceConfiguration(
          serviceId: 'gitea',
          serviceDisplayName: 'Gitea',
          settings: const {'password': 'secret-sentinel'},
        ),
      );
      final applying = cubit.applyAll();
      await pumpEventQueue();
      cubit
        ..addJob(
          ChangeServiceConfiguration(
            serviceId: 'gitea',
            serviceDisplayName: 'Gitea',
            settings: const {'port': 3000},
          ),
        )
        ..addJob(
          ChangeServiceConfiguration(
            serviceId: 'nextcloud',
            serviceDisplayName: 'Nextcloud',
            settings: const {'port': 8080},
          ),
        );
      final state = cubit.state as JobsStateLoading;
      expect(state.postponedJobs.map((final change) => change.id), [
        'change_settings_gitea',
        'change_settings_nextcloud',
      ]);
      expect(state.steps.first.status, OperationStatus.running);
      expect(state.steps.first.target, 'Gitea');
      response.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await applying;
      verify(
        () => api.setServiceConfiguration('gitea', const {
          'password': 'secret-sentinel',
        }),
      ).called(1);
      verifyNever(() => api.setServiceConfiguration('nextcloud', any()));
    },
  );

  testWidgets('mixed command results still apply the saved configuration', (
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
    when(api.apply).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(aServiceMoveJob()),
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
    final state = cubit.state as JobsStateLoading;
    expect(state.steps.map((final job) => job.status), [
      OperationStatus.succeeded,
      OperationStatus.unknown,
      OperationStatus.failed,
    ]);
    verify(api.apply).called(1);
    verify(api.getDnsRecords).called(2);
  });
  test('service configuration draft owns an immutable copy of its input', () {
    final paths = ['original'];
    final settings = <String, dynamic>{
      'nested': <String, dynamic>{'paths': paths},
    };
    final change = ChangeServiceConfiguration(
      serviceId: 'gitea',
      serviceDisplayName: 'Gitea',
      settings: settings,
    );
    paths.add('later');
    settings.clear();
    final nested = change.settings['nested'] as Map<String, dynamic>;
    expect(nested['paths'], ['original']);
    expect(change.settings.clear, throwsUnsupportedError);
    expect(nested.clear, throwsUnsupportedError);
    expect(() => (nested['paths'] as List).clear(), throwsUnsupportedError);
  });

  testWidgets('a failed DNS read does not prevent edits or rebuild', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    when(api.getDnsRecords).thenThrow(StateError('secret-sentinel'));
    when(
      () => api.switchService(serviceId: 'gitea', needTurnOn: false),
    ).thenAnswer(
      (_) async => ServerMutationResult<void>(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    when(api.apply).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(aServiceMoveJob()),
      ),
    );
    cubit.addJob(ServiceToggleJob(service: aService(), needToTurnOn: false));
    await tester.runAsync(cubit.applyAll);
    verify(
      () => api.switchService(serviceId: 'gitea', needTurnOn: false),
    ).called(1);
    verify(api.apply).called(1);
    expect(
      connection.operations.history.single.steps.map(
        (final step) => step.status,
      ),
      [
        OperationStatus.succeeded,
        OperationStatus.failed,
        OperationStatus.accepted,
      ],
    );
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

  testWidgets('a detached operation never dispatches its later jobs', (
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
