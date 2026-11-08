import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/ui/pages/server/server_settings.dart';
import 'package:timezone/data/latest.dart';

import '../../../helpers/fixtures/system_settings_fixtures.dart';
import '../../../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

class _Jobs extends Mock implements JobsCubit {}

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    initializeTimeZones();
  });

  testWidgets('settings project the shared draft over refreshed server data', (
    final tester,
  ) async {
    final connection = ServerConnection(
      api: _Api(),
      serverId: 'server',
      isAttached: () => true,
    )..cache.setVersion(Version(3, 9, 0));
    connection.cache.settings.push(aSystemSettings());
    final settings = ServerSettingsBloc(
      connection: connection,
      showMessage: (_) {},
    );
    final jobs = _Jobs();
    when(() => jobs.state).thenReturn(JobsStateEmpty());
    when(() => jobs.stream).thenAnswer((_) => const Stream.empty());
    await pumpForTest(
      tester,
      MultiBlocProvider(
        providers: [
          BlocProvider<ServerSettingsBloc>.value(value: settings),
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
    connection.cache.settings.push(aSystemSettings());
    await tester.pump();
    expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
    connection.changeDraft.remove(connection.changeDraft.value.single.id);
    await tester.pump();
    expect(tester.widget<SwitchListTile>(toggle).value, isTrue);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() async {
      await settings.close();
      connection.dispose();
    });
  });
}
