import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/pages/services/service_settings.dart';

import '../../helpers/fixtures/service_fixtures.dart';
import '../../helpers/widget_harness.dart';

class _Jobs extends Mock implements JobsCubit {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  for (final queued in [false, true]) {
    testWidgets(
      'service draft survives rotation but resets on unrelated binding: queued=$queued',
      (final tester) async {
        final source =
            StreamController<
              ConnectionObservation<CachedValue<List<Service>>>
            >.broadcast(sync: true);
        final services = ServicesBloc(
          services: source.stream,
          refresh: () async {},
          restart: (_, _) async => null,
          move: (_, _, _) async => null,
          showMessage: (_) {},
        );
        final jobs = _Jobs();
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
        final origin = ServerStateOrigin('server');
        Future<void> publish(final ServerStateOrigin value) async {
          source.add(
            ConnectionObservation.attached(value, CachedValue(data: [service])),
          );
          await tester.runAsync(pumpEventQueue);
          await tester.pump();
        }

        await publish(origin);
        await pumpForTest(
          tester,
          MultiBlocProvider(
            providers: [
              BlocProvider<ServicesBloc>.value(value: services),
              BlocProvider<JobsCubit>.value(value: jobs),
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
        await publish(
          ServerStateOrigin('server', continuity: origin.continuity),
        );
        expect(tester.widget<SwitchListTile>(toggle).value, queued);
        when(() => jobs.state).thenReturn(JobsStateEmpty());
        await publish(ServerStateOrigin('server'));
        expect(tester.widget<SwitchListTile>(toggle).value, isTrue);
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
