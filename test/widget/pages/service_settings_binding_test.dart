import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
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
      'service draft survives refreshed server data: queued=$queued',
      (final tester) async {
        final source = StreamController<CachedValue<List<Service>>?>.broadcast(
          sync: true,
        );
        final services = ServicesBloc(
          services: source.stream,
          refresh: () async {},
          restart: (_) async => null,
          move: (_, _) async => null,
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
