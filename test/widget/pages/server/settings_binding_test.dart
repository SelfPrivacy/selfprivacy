import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/credential_policy.dart';
import 'package:selfprivacy/ui/molecules/cards/status_card.dart';
import 'package:selfprivacy/ui/organisms/server_settings_view.dart';
import 'package:selfprivacy/ui/pages/server/server_settings.dart';

import '../../../helpers/fixtures/system_settings_fixtures.dart';
import '../../../helpers/fixtures/telemetry_fixtures.dart';
import '../../../helpers/fixtures/update_channels_fixtures.dart';
import '../../../helpers/widget_harness.dart';

class _Jobs extends Mock implements JobsCubit {}

class _Api extends Mock implements ServerApi {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  testWidgets('credential policy has an independently loaded settings row', (
    final tester,
  ) async {
    await pumpForTest(
      tester,
      SingleChildScrollView(
        child: ServerSettingsView(
          state: ServerSettingsReady(
            telemetry: const CachedValue(support: DomainSupport.unsupported),
            policy: const CachedValue(
              data: CredentialPolicy.any,
              support: DomainSupport.supported,
            ),
            settings: CachedValue(
              data: aSystemSettings(),
              support: DomainSupport.supported,
            ),
            channels: const CachedValue(support: DomainSupport.unsupported),
          ),
          onEvent: (_) {},
          onChannel: () {},
          onTimezone: () {},
          onCredentialPolicy: () {},
          onTelemetry: () {},
          onShowOperation: () {},
          onRefresh: () {},
        ),
      ),
    );
    expect(
      find.widgetWithText(ListTile, 'Minimum sign-in credentials'),
      findsOneWidget,
    );
  });

  for (final bothStale in [true, false]) {
    testWidgets(
      'one cached-data notice for the whole settings screen: both stale=$bothStale',
      (final tester) async {
        var refreshes = 0;
        await pumpForTest(
          tester,
          SingleChildScrollView(
            child: ServerSettingsView(
              state: ServerSettingsReady(
                policy: const CachedValue(support: DomainSupport.unsupported),
                telemetry: CachedValue(
                  data: aTelemetrySettings(),
                  support: DomainSupport.supported,
                  freshness: Freshness.stale,
                ),
                settings: CachedValue(
                  data: aSystemSettings(),
                  support: DomainSupport.supported,
                  freshness: bothStale ? Freshness.stale : Freshness.fresh,
                ),
                channels: CachedValue(
                  data: anUpdateChannels(),
                  support: DomainSupport.supported,
                  freshness: Freshness.fresh,
                  lastError: StateError('offline'),
                  isRefreshing: !bothStale,
                ),
                draft: const [],
              ),
              onEvent: (_) {},
              onChannel: () {},
              onTimezone: () {},
              onCredentialPolicy: () {},
              onTelemetry: () {},
              onShowOperation: () {},
              onRefresh: () => refreshes++,
            ),
          ),
        );
        expect(find.text('Showing cached data'), findsOneWidget);
        expect(find.byType(StatusCard), findsOneWidget);
        expect(
          tester.getTopLeft(find.byType(StatusCard)).dy,
          lessThan(tester.getTopLeft(find.text('Updates')).dy),
        );
        expect(
          tester.widget<StatusCard>(find.byType(StatusCard)).onTap,
          bothStale ? isNotNull : isNull,
        );
        await tester.tap(find.byType(StatusCard));
        expect(refreshes, bothStale ? 1 : 0);
      },
    );
  }

  testWidgets('auto upgrade off disables reboot without clearing its value', (
    final tester,
  ) async {
    final events = <ServerSettingsEvent>[];
    await pumpForTest(
      tester,
      SingleChildScrollView(
        child: ServerSettingsView(
          state: ServerSettingsReady(
            policy: const CachedValue(support: DomainSupport.unsupported),
            telemetry: const CachedValue(support: DomainSupport.unsupported),
            settings: CachedValue(
              data: aSystemSettings(autoUpgrade: false, allowReboot: true),
              support: DomainSupport.supported,
            ),
            channels: const CachedValue(support: DomainSupport.unsupported),
            draft: const [],
          ),
          onEvent: events.add,
          onChannel: () {},
          onTimezone: () {},
          onCredentialPolicy: () {},
          onTelemetry: () {},
          onShowOperation: () {},
          onRefresh: () {},
        ),
      ),
    );
    final reboot = find.byType(SwitchListTile).at(1);
    expect(tester.widget<SwitchListTile>(reboot).value, isTrue);
    expect(tester.widget<SwitchListTile>(reboot).onChanged, isNull);
    await tester.tap(reboot);
    expect(events, isEmpty);
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile).last).onChanged,
      isNotNull,
    );
  });

  testWidgets('applying card opens the operation without a nested button', (
    final tester,
  ) async {
    var opened = false;
    await pumpForTest(
      tester,
      SingleChildScrollView(
        child: ServerSettingsView(
          state: ServerSettingsApplying(
            policy: const CachedValue(support: DomainSupport.unsupported),
            telemetry: const CachedValue(support: DomainSupport.unsupported),
            settings: CachedValue(
              data: aSystemSettings(),
              support: DomainSupport.supported,
            ),
            channels: const CachedValue(support: DomainSupport.unsupported),
            draft: const [],
          ),
          onEvent: (_) {},
          onChannel: () {},
          onTimezone: () {},
          onCredentialPolicy: () {},
          onTelemetry: () {},
          onShowOperation: () => opened = true,
          onRefresh: () {},
        ),
      ),
    );
    expect(find.byType(TextButton), findsNothing);
    await tester.tap(find.byType(StatusCard).first);
    expect(opened, isTrue);
  });

  testWidgets('failed initial settings do not pretend switches are off', (
    final tester,
  ) async {
    var opened = false;
    var refreshed = false;
    await pumpForTest(
      tester,
      SingleChildScrollView(
        child: ServerSettingsView(
          state: ServerSettingsReady(
            policy: const CachedValue(support: DomainSupport.unsupported),
            telemetry: const CachedValue(support: DomainSupport.unsupported),
            settings: CachedValue(
              support: DomainSupport.supported,
              lastError: StateError('offline'),
            ),
            channels: CachedValue(
              support: DomainSupport.supported,
              data: anUpdateChannels(),
            ),
            draft: const [],
          ),
          onEvent: (_) {},
          onChannel: () => opened = true,
          onTimezone: () {},
          onCredentialPolicy: () {},
          onTelemetry: () {},
          onShowOperation: () {},
          onRefresh: () => refreshed = true,
        ),
      ),
    );
    expect(find.byType(SwitchListTile), findsNothing);
    expect(find.text('Loading...'), findsNothing);
    await tester.tap(find.text('Could not load server settings'));
    expect(refreshed, isTrue);
    await tester.tap(find.widgetWithText(ListTile, 'Update channel'));
    expect(opened, isTrue);
  });

  testWidgets(
    'settings queue survives refresh and reflects removal from Jobs',
    (final tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final connection = ServerConnection(
        api: _Api(),
        serverId: 'server',
        isAttached: () => true,
      )..cache.setVersion(Version(3, 9, 0));
      connection.cache.settings.push(aSystemSettings());
      connection.cache.telemetry.push(aTelemetrySettings());
      connection.cache.credentialPolicy.push(CredentialPolicy.any);
      connection.cache.updateChannels.push(anUpdateChannels());
      final bloc = ServerSettingsBloc(
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
            BlocProvider<ServerSettingsBloc>.value(value: bloc),
            BlocProvider<JobsCubit>.value(value: jobs),
          ],
          child: const ServerSettingsPage(),
        ),
      );
      final toggle = find.byType(SwitchListTile).first;
      expect(tester.getSize(find.byType(ServerSettingsView)).width, 624);
      expect(tester.getCenter(find.byType(ServerSettingsView)).dx, 640);
      expect(tester.widget<SwitchListTile>(toggle).value, isTrue);
      await tester.tap(toggle);
      await tester.pump();
      expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
      expect(find.text('Not applied'), findsOneWidget);
      connection.cache.settings.push(aSystemSettings());
      await tester.pump();
      expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
      connection.changeDraft.remove(connection.changeDraft.value.single.id);
      await tester.pump();
      expect(tester.widget<SwitchListTile>(toggle).value, isTrue);
      expect(find.text('Not applied'), findsNothing);
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -1500));
      await tester.pumpAndSettle();
      final position = tester
          .state<ScrollableState>(find.byType(Scrollable).last)
          .position;
      expect(position.pixels, lessThanOrEqualTo(position.maxScrollExtent));
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.runAsync(() async {
        await bloc.close();
        connection.dispose();
      });
    },
  );
}
