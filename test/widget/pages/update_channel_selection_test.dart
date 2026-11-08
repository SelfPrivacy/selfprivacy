import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/update_channels.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/ui/organisms/update_channel_selection.dart';
import 'package:selfprivacy/ui/pages/server/select_update_channel.dart';

import '../../helpers/fixtures/update_channels_fixtures.dart';
import '../../helpers/widget_harness.dart';

class _SettingsBloc extends Mock implements ServerSettingsBloc {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late UpdateChannels channels;
  late List<UpdateChannel> submitted;
  var refreshes = 0;
  setUp(() {
    channels = anUpdateChannels();
    submitted = [];
    refreshes = 0;
  });

  Future<void> show(
    final WidgetTester tester, {
    final UpdateChannels? data,
    final Object? error,
    final Freshness freshness = Freshness.fresh,
    final bool refreshing = false,
    final String? pendingChannelId,
  }) => pumpForTest(
    tester,
    UpdateChannelSelection(
      pendingChannelId: pendingChannelId,
      snapshot: CachedValue(
        data: data,
        support: DomainSupport.supported,
        freshness: freshness,
        lastError: error,
        isRefreshing: refreshing,
      ),
      onAdd: submitted.add,
      onRefresh: () => refreshes++,
    ),
  );

  testWidgets('error card retries loading and disables retries in flight', (
    final tester,
  ) async {
    await show(tester, error: StateError('offline'));
    expect(find.text('Tap here to try again.'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
    await tester.tap(find.text('Could not load update channels.'));
    expect(refreshes, 1);
    await show(tester, error: StateError('offline'), refreshing: true);
    await tester.tap(find.text('Could not load update channels.'));
    expect(refreshes, 1);
    expect(find.text('Trying again…'), findsOneWidget);
  });

  testWidgets('current channel starts selected and cannot create a draft', (
    final tester,
  ) async {
    await show(tester, data: channels);
    expect(
      tester
          .widget<RadioSelectionCard>(find.byType(RadioSelectionCard))
          .isSelected,
      isTrue,
    );
    expect(find.byType(FilledButton), findsNothing);
    expect(find.byType(InfoBox), findsOneWidget);
    expect(submitted, isEmpty);
  });

  testWidgets('channel action has a 24 pixel gap after choices', (
    final tester,
  ) async {
    await show(
      tester,
      data: UpdateChannels(
        currentChannel: channels.currentChannel,
        channels: [channels.currentChannel, testUpdateChannel],
      ),
    );
    expect(
      tester.getTopLeft(find.byType(FilledButton)).dy -
          tester.getBottomLeft(find.byType(RadioSelectionCard).last).dy,
      24,
    );
  });

  testWidgets('cached data can be refreshed by clicking its card', (
    final tester,
  ) async {
    await show(tester, data: channels, freshness: Freshness.stale);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
    await tester.tap(find.text('Showing cached data'));
    expect(refreshes, 1);
    await show(
      tester,
      data: channels,
      freshness: Freshness.stale,
      refreshing: true,
    );
    await tester.tap(find.text('Showing cached data'));
    expect(refreshes, 1);
    expect(find.text('Stable channel'), findsOneWidget);
  });

  testWidgets('only queued choices are marked not applied', (
    final tester,
  ) async {
    final data = UpdateChannels(
      currentChannel: channels.currentChannel,
      channels: [channels.currentChannel, testUpdateChannel],
    );
    await show(tester, data: data);
    await tester.tap(find.text('Test channel'));
    await tester.pump();
    expect(find.text('Not applied'), findsNothing);
    await show(tester, data: data, pendingChannelId: testUpdateChannel.id);
    expect(find.text('Not applied'), findsOneWidget);
    await show(tester, data: data);
    expect(find.text('Not applied'), findsNothing);
    expect(
      tester
          .widgetList<RadioSelectionCard>(find.byType(RadioSelectionCard))
          .map((final card) => card.isSelected),
      [true, false],
    );
  });

  testWidgets('a pristine selection follows the refreshed current channel', (
    final tester,
  ) async {
    final stable = channels.currentChannel;
    final choices = [stable, testUpdateChannel];
    await show(
      tester,
      data: UpdateChannels(currentChannel: stable, channels: choices),
    );
    await show(
      tester,
      data: UpdateChannels(
        currentChannel: testUpdateChannel,
        channels: choices,
      ),
    );
    expect(
      tester
          .widgetList<RadioSelectionCard>(find.byType(RadioSelectionCard))
          .map((final card) => card.isSelected),
      [false, true],
    );
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    await tester.tap(find.text('Stable channel'));
    await tester.pump();
    await show(
      tester,
      data: UpdateChannels(
        currentChannel: testUpdateChannel,
        channels: choices,
      ),
    );
    expect(
      tester
          .widgetList<RadioSelectionCard>(find.byType(RadioSelectionCard))
          .map((final card) => card.isSelected),
      [true, false],
    );
    await tester.tap(find.text('Create job'));
    expect(submitted.single.id, 'stable');
  });

  testWidgets(
    'custom channel starts selected and requires confirmation to leave',
    (final tester) async {
      channels = anUpdateChannels(custom: true);
      await show(tester, data: channels);
      expect(find.byType(RadioSelectionCard), findsNWidgets(2));
      expect(
        tester
            .widgetList<RadioSelectionCard>(find.byType(RadioSelectionCard))
            .where((final card) => card.isSelected)
            .single
            .title,
        'Custom update source',
      );
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
      await tester.tap(find.text('Stable channel'));
      await tester.pump();
      await tester.tap(find.text('Custom update source'));
      await tester.pump();
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
      await tester.tap(find.text('Stable channel'));
      await tester.pump();
      await tester.tap(find.text('Create job'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(submitted, isEmpty);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(submitted, isEmpty);
      await tester.tap(find.text('Create job'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Create job'));
      await tester.pumpAndSettle();
      expect(submitted.single.id, 'stable');
      expect(find.byType(AlertDialog), findsNothing);
    },
  );

  testWidgets('cached choices remain usable after a failed read', (
    final tester,
  ) async {
    final current = channels.currentChannel;
    await show(
      tester,
      data: UpdateChannels(
        currentChannel: current,
        channels: [current, testUpdateChannel],
      ),
      error: StateError('offline'),
    );
    await tester.tap(find.text('Test channel'));
    await tester.pump();
    await tester.tap(find.text('Create job'));
    await tester.pump();
    expect(submitted.single.id, 'test-channel');
  });

  testWidgets('a removed selection cannot be queued after refresh', (
    final tester,
  ) async {
    final current = channels.currentChannel;
    await show(
      tester,
      data: UpdateChannels(
        currentChannel: current,
        channels: [current, testUpdateChannel],
      ),
    );
    await tester.tap(find.text('Test channel'));
    await tester.pump();
    await show(tester, data: channels);
    expect(find.byType(FilledButton), findsNothing);
    expect(submitted, isEmpty);
  });

  testWidgets(
    'an open queued selection does not reset when the registry removes it',
    (final tester) async {
      final current = channels.currentChannel;
      await show(
        tester,
        data: UpdateChannels(
          currentChannel: current,
          channels: [current, testUpdateChannel],
        ),
        pendingChannelId: testUpdateChannel.id,
      );
      await show(
        tester,
        data: UpdateChannels(currentChannel: current, channels: [current]),
      );
      expect(
        tester
            .widget<RadioSelectionCard>(find.byType(RadioSelectionCard))
            .isSelected,
        false,
      );
      expect(
        find.text(
          'The selected channel is no longer available. Choose another channel.',
        ),
        findsOneWidget,
      );
      expect(find.byType(FilledButton), findsNothing);
      expect(submitted, isEmpty);
    },
  );

  testWidgets('empty and failed reads do not offer a usable change', (
    final tester,
  ) async {
    await show(tester, error: StateError('offline'));
    expect(find.text('Could not load update channels.'), findsOneWidget);
    expect(find.text('Refresh'), findsNothing);
    expect(find.text('Retry'), findsNothing);
    await show(
      tester,
      data: UpdateChannels(
        currentChannel: channels.currentChannel,
        channels: [],
      ),
    );
    expect(find.byType(InfoBox), findsOneWidget);
    expect(tester.widget<InfoBox>(find.byType(InfoBox)).isWarning, isFalse);
    expect(
      tester
          .widget<RadioSelectionCard>(find.byType(RadioSelectionCard))
          .isSelected,
      isTrue,
    );
    expect(find.byType(FilledButton), findsNothing);
    expect(find.textContaining('Create a job'), findsNothing);
  });

  for (final failed in [false, true]) {
    testWidgets('pull refresh works with short content: failed=$failed', (
      final tester,
    ) async {
      var refreshes = 0;
      final bloc = _SettingsBloc();
      final state = ServerSettingsReady(
        settings: const CachedValue(),
        channels: CachedValue(
          data: failed ? null : channels,
          support: DomainSupport.supported,
          lastError: failed ? StateError('offline') : null,
        ),
        draft: const [],
      );
      when(() => bloc.state).thenReturn(state);
      when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
      when(bloc.refresh).thenAnswer((_) async {
        refreshes++;
      });
      await pumpForTest(
        tester,
        BlocProvider<ServerSettingsBloc>.value(
          value: bloc,
          child: const SelectUpdateChannelPage(),
        ),
      );
      await tester.pumpAndSettle();
      expect(refreshes, 1);
      await tester.drag(find.byType(CustomScrollView), const Offset(0, 350));
      await tester.pumpAndSettle();
      expect(refreshes, 2);
      final position = tester
          .state<ScrollableState>(find.byType(Scrollable).last)
          .position;
      expect(position.pixels, greaterThanOrEqualTo(position.minScrollExtent));
      expect(position.pixels, lessThanOrEqualTo(position.maxScrollExtent));
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -1500));
      await tester.pumpAndSettle();
      expect(position.pixels, greaterThanOrEqualTo(position.minScrollExtent));
      expect(position.pixels, lessThanOrEqualTo(position.maxScrollExtent));
      expect(find.text('Refresh'), findsNothing);
      expect(find.text('Retry'), findsNothing);
    });
  }
}
