import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/ui/pages/server/telemetry.dart';

import '../../../helpers/fixtures/telemetry_fixtures.dart';
import '../../../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late ServerConnection connection;
  late ServerSettingsBloc bloc;
  var reads = 0;
  setUp(() {
    reads = 0;
    final api = _Api();
    when(api.getTelemetrySettings).thenAnswer((_) async {
      reads++;
      return aTelemetrySettings();
    });
    connection = ServerConnection(
      api: api,
      serverId: 'server',
      isAttached: () => true,
    )..cache.setVersion(Version(3, 9, 0));
    connection.cache.telemetry.push(aTelemetrySettings());
    bloc = ServerSettingsBloc(connection: connection, showMessage: (_) {});
  });
  tearDown(() async {
    await bloc.close();
    connection.dispose();
  });

  Future<void> show(final WidgetTester tester) async {
    await pumpForTest(
      tester,
      BlocProvider<ServerSettingsBloc>.value(
        value: bloc,
        child: const TelemetryPage(),
      ),
    );
    await tester.runAsync(pumpEventQueue);
    await tester.pump();
  }

  testWidgets('cached telemetry can be refreshed through its status card', (
    final tester,
  ) async {
    await show(tester);
    final initial = reads;
    expect(initial, greaterThan(0));
    connection.cache.telemetry.invalidate();
    await tester.runAsync(pumpEventQueue);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Showing cached data'));
    await tester.runAsync(pumpEventQueue);
    await tester.pumpAndSettle();
    expect(reads, initial + 1);
    expect(find.text('Showing cached data'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('removing a queued change resets an untouched form', (
    final tester,
  ) async {
    final change = ChangeTelemetrySettingsJob(settings: aTelemetryUpdate());
    connection.telemetry.stageChange(change);
    await tester.pump();
    await show(tester);
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile).first).value,
      true,
    );
    expect(find.text('Not applied'), findsOneWidget);
    connection.changeDraft.remove(change.id);
    await tester.runAsync(pumpEventQueue);
    await tester.pumpAndSettle();
    expect(bloc.state.pending<ChangeTelemetrySettingsJob>(), isNull);
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile).first).value,
      false,
    );
    expect(find.text('Not applied'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
