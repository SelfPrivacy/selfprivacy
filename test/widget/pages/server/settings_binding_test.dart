import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:selfprivacy/ui/pages/server/server_settings.dart';
import 'package:timezone/data/latest.dart';

import '../../../helpers/fixtures/system_settings_fixtures.dart';
import '../../../helpers/widget_harness.dart';

class _Jobs extends Mock implements JobsCubit {}

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    initializeTimeZones();
  });

  testWidgets(
    'settings drafts survive confirmed rotation but reset for a new binding',
    (final tester) async {
      final source =
          StreamController<
            ConnectionObservation<CachedValue<SystemSettings>>
          >.broadcast(sync: true);
      final details = ServerDetailsCubit(
        settings: source.stream,
        loadMetadata: (_) async => [],
        onMetadataFailure: () {},
      );
      final jobs = _Jobs();
      when(() => jobs.state).thenReturn(JobsStateEmpty());
      when(() => jobs.stream).thenAnswer((_) => const Stream.empty());
      final origin = ServerStateOrigin('server');
      void publish(final ServerStateOrigin origin) => source.add(
        ConnectionObservation.attached(
          origin,
          CachedValue(data: aSystemSettings()),
        ),
      );
      publish(origin);
      await pumpForTest(
        tester,
        MultiBlocProvider(
          providers: [
            BlocProvider<ServerDetailsCubit>.value(value: details),
            BlocProvider<JobsCubit>.value(value: jobs),
          ],
          child: const ServerSettingsPage(),
        ),
      );
      final toggle = find.byType(SwitchListTile).first;
      expect(tester.widget<SwitchListTile>(toggle).value, isTrue);
      tester.widget<SwitchListTile>(toggle).onChanged!(false);
      await tester.pump();
      expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
      publish(ServerStateOrigin('server', continuity: origin.continuity));
      await tester.pump();
      expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
      publish(ServerStateOrigin('server'));
      await tester.pump();
      expect(tester.widget<SwitchListTile>(toggle).value, isTrue);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.runAsync(() async {
        await details.close();
        await source.close();
      });
    },
  );
}
