import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/pages/services/service_settings.dart';

import '../../helpers/fixtures/json_fixture.dart';
import '../../helpers/widget_harness.dart';

class _Jobs extends Mock implements JobsCubit {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  testWidgets(
    'service draft survives rotation but resets on unrelated binding',
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
      when(() => jobs.state).thenReturn(JobsStateEmpty());
      when(() => jobs.stream).thenAnswer((_) => const Stream.empty());
      final data =
          loadJsonFixture('graphql/domain_reads.json')['AllServices']
              as Map<String, dynamic>;
      final rows =
          (data['services'] as Map<String, dynamic>)['allServices'] as List;
      final row = rows.first as Map<String, dynamic>;
      row['configuration'] = (row['configuration'] as List)
          .cast<Map<String, dynamic>>()
          .where((final item) => item['__typename'] == 'BoolConfigItem')
          .toList();
      final service = Service.fromGraphQL(
        Query$AllServices.fromJson(data).services.allServices.first,
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
      expect(tester.widget<SwitchListTile>(toggle).value, isTrue);
      tester.widget<SwitchListTile>(toggle).onChanged!(false);
      await tester.pump();
      expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
      await publish(ServerStateOrigin('server', continuity: origin.continuity));
      expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
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
