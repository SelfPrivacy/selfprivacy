import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
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

  testWidgets('settings drafts survive refreshed server data', (
    final tester,
  ) async {
    final source = StreamController<CachedValue<SystemSettings>?>.broadcast(
      sync: true,
    );
    final details = ServerDetailsCubit(
      settings: source.stream,
      loadMetadata: () async => [],
      onMetadataFailure: () {},
    );
    final jobs = _Jobs();
    when(() => jobs.state).thenReturn(JobsStateEmpty());
    when(() => jobs.stream).thenAnswer((_) => const Stream.empty());
    void publish() => source.add(CachedValue(data: aSystemSettings()));
    publish();
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
    await tester.tap(toggle);
    await tester.pump();
    expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
    publish();
    await tester.pump();
    expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() async {
      await details.close();
      await source.close();
    });
  });
}
