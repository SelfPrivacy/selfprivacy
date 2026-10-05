import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/operations_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/ui/pages/services/service_settings.dart';

import '../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../helpers/fixtures/server_fixtures.dart';
import '../../helpers/fixtures/service_fixtures.dart';
import '../../helpers/operation_fixture.dart';
import '../../helpers/widget_harness.dart';

class _Jobs extends Mock implements JobsCubit {}

class _Operations extends Mock implements OperationsCubit {}

class _Api extends Mock implements ServerApi {}

class _Resources extends Mock implements ResourcesModel {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  testWidgets('authoritative missing job releases service settings', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    final fixture = (await tester.runAsync(() async {
      final api = _Api();
      final hub = fixtureHub(api);
      final connection = hub.active!;
      final resources = _Resources();
      when(() => resources.servers).thenReturn([aServer()]);
      final acceptedJob = aServiceMoveJob();
      when(api.upgrade).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(acceptedJob),
        ),
      );
      final jobs = createJobsCubit(
        connection,
        resources: resources,
        dnsProvider: () => null,
        showMessage: (_) {},
      );
      final operations = OperationsCubit(
        queue: connection.operations,
        remove: (_) async => false,
        showMessage: (_) {},
      );
      final service = aService(
        configuration: const [
          BoolServiceConfigItem(
            id: 'disableRegistration',
            description: 'Disable registration',
            widget: 'switch',
            type: 'bool',
            value: true,
            defaultValue: true,
          ),
        ],
      );
      final services = ServicesBloc(
        services: Stream.value(CachedValue(data: [service])),
        refresh: () async {},
        restart: (_) async => null,
        move: (_) async => null,
        showMessage: (_) {},
      );

      return (
        jobs: jobs,
        operations: operations,
        services: services,
        connection: connection,
        acceptedJob: acceptedJob,
        service: service,
      );
    }))!;
    final (
      jobs: jobs,
      operations: operations,
      services: services,
      connection: connection,
      acceptedJob: acceptedJob,
      service: service,
    ) = fixture;
    await tester.runAsync(pumpEventQueue);
    await pumpForTest(
      tester,
      MultiBlocProvider(
        providers: [
          BlocProvider<ServicesBloc>.value(value: services),
          BlocProvider<JobsCubit>.value(value: jobs),
          BlocProvider<OperationsCubit>.value(value: operations),
        ],
        child: ServiceSettingsPage(serviceId: service.id),
      ),
    );
    expect(find.byType(SwitchListTile), findsOneWidget);
    await tester.runAsync(jobs.upgradeServer);
    await tester.runAsync(pumpEventQueue);
    await tester.pump();
    expect(find.byType(SwitchListTile), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    connection.operations.observeMissingJob(acceptedJob.uid);
    await tester.runAsync(pumpEventQueue);
    await tester.pump();
    expect(operations.state.operations.single.status, OperationStatus.unknown);
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() async {
      await jobs.close();
      await operations.close();
      await services.close();
    });
  });

  for (final queued in [false, true]) {
    testWidgets(
      'service draft survives refreshed server data: queued=$queued',
      (final tester) async {
        final source = StreamController<CachedValue<List<Service>>?>.broadcast(
          sync: true,
        );
        final services = ServicesBloc(
          services: source.stream,
          refresh: () async {},
          restart: (_) async => null,
          move: (_) async => null,
          showMessage: (_) {},
        );
        final jobs = _Jobs();
        final operations = _Operations();
        when(
          () => operations.state,
        ).thenReturn(OperationsState(operations: const []));
        when(() => operations.stream).thenAnswer((_) => const Stream.empty());
        final draft = ChangeServiceConfiguration(
          serviceId: 'gitea',
          serviceDisplayName: 'Gitea',
          settings: const {'disableRegistration': false},
        );
        when(
          () => jobs.state,
        ).thenReturn(queued ? JobsStateWithJobs([draft]) : JobsStateEmpty());
        when(() => jobs.stream).thenAnswer((_) => const Stream.empty());
        final service = aService(
          configuration: const [
            BoolServiceConfigItem(
              id: 'disableRegistration',
              description: 'Disable registration',
              widget: 'switch',
              type: 'bool',
              value: true,
              defaultValue: true,
            ),
          ],
        );
        Future<void> publish() async {
          source.add(CachedValue(data: [service]));
          await tester.runAsync(pumpEventQueue);
          await tester.pump();
        }

        await publish();
        await pumpForTest(
          tester,
          MultiBlocProvider(
            providers: [
              BlocProvider<ServicesBloc>.value(value: services),
              BlocProvider<JobsCubit>.value(value: jobs),
              BlocProvider<OperationsCubit>.value(value: operations),
            ],
            child: ServiceSettingsPage(serviceId: service.id),
          ),
        );
        final toggle = find.byType(SwitchListTile);
        expect(tester.widget<SwitchListTile>(toggle).value, !queued);
        await tester.tap(toggle);
        await tester.pump();
        expect(tester.takeException(), isNull);
        expect(tester.widget<SwitchListTile>(toggle).value, queued);
        expect(draft.settings, {'disableRegistration': false});
        await publish();
        expect(tester.widget<SwitchListTile>(toggle).value, queued);
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.runAsync(() async {
          final closing = services.close();
          await Future<void>.delayed(Duration.zero);
          await tester.pump();
          await closing;
          await source.close();
        });
      },
    );
  }
}
