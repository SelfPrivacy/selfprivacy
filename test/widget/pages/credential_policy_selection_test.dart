import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/credential_policy.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';
import 'package:selfprivacy/ui/molecules/cards/status_card.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/ui/organisms/credential_policy_selection.dart';

import '../../helpers/widget_harness.dart';

void main() {
  setUpAll(setUpWidgetTestHarness);
  late List<CredentialPolicy> submitted;
  var refreshes = 0;
  setUp(() {
    submitted = [];
    refreshes = 0;
  });

  Future<void> show(
    final WidgetTester tester, {
    final CredentialPolicy? current = CredentialPolicy.any,
    final CredentialPolicy? pending,
    final bool enabled = true,
    final bool applying = false,
    final Freshness freshness = Freshness.fresh,
    final Object? error,
    final bool refreshing = false,
  }) => pumpForTest(
    tester,
    SingleChildScrollView(
      child: CredentialPolicySelection(
        snapshot: CachedValue(
          data: current,
          support: DomainSupport.supported,
          freshness: freshness,
          lastError: error,
          isRefreshing: refreshing,
        ),
        pendingPolicy: pending,
        enabled: enabled,
        applying: applying,
        onAdd: submitted.add,
        onRefresh: () => refreshes++,
      ),
    ),
  );

  testWidgets('creating a job queues the choice without confirmation', (
    final tester,
  ) async {
    await show(tester);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    await tester.tap(find.text('Multi-factor authentication'));
    await tester.pump();
    expect(submitted, isEmpty);
    expect(find.text('Not applied'), findsNothing);
    await tester.ensureVisible(find.text('Queue change'));
    await tester.tap(find.text('Queue change'));
    await tester.pumpAndSettle();
    expect(submitted, [CredentialPolicy.mfa]);
    expect(find.byType(AlertDialog), findsNothing);
    expect(
      tester.getTopLeft(find.byType(InfoBox)).dy,
      greaterThan(tester.getBottomLeft(find.byType(FilledButton)).dy),
    );
  });

  testWidgets('attested passkeys are hidden unless required by the server', (
    final tester,
  ) async {
    await show(tester);
    expect(find.text('Attested passkey'), findsNothing);
    await show(tester, current: CredentialPolicy.unknown);
    expect(find.text('Attested passkey'), findsNothing);
    await show(tester, pending: CredentialPolicy.attestedPasskey);
    expect(find.text('Attested passkey'), findsNothing);
  });

  testWidgets('the current attested policy stays visible while editing', (
    final tester,
  ) async {
    await show(tester, current: CredentialPolicy.attestedPasskey);
    expect(
      tester
          .widget<RadioSelectionCard>(
            find.widgetWithText(RadioSelectionCard, 'Attested passkey'),
          )
          .isSelected,
      isTrue,
    );
    await tester.tap(find.text('Multi-factor authentication'));
    await tester.pump();
    expect(find.text('Attested passkey'), findsOneWidget);
    await tester.tap(find.text('Attested passkey'));
    await tester.pump();
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );

    await show(tester, current: CredentialPolicy.any);
    expect(find.text('Attested passkey'), findsNothing);
    expect(
      tester
          .widget<RadioSelectionCard>(
            find.widgetWithText(RadioSelectionCard, 'Any credentials'),
          )
          .isSelected,
      isTrue,
    );
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(submitted, isEmpty);
  });

  testWidgets('updating a job queues the current attested policy directly', (
    final tester,
  ) async {
    await show(
      tester,
      current: CredentialPolicy.attestedPasskey,
      pending: CredentialPolicy.mfa,
    );
    await tester.tap(find.text('Attested passkey'));
    await tester.pump();
    await tester.ensureVisible(find.text('Update queued change'));
    await tester.tap(find.text('Update queued change'));
    await tester.pumpAndSettle();
    expect(submitted, [CredentialPolicy.attestedPasskey]);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('removing a queued choice restores the confirmed selection', (
    final tester,
  ) async {
    await show(tester, pending: CredentialPolicy.mfa);
    expect(find.text('Not applied'), findsOneWidget);
    expect(find.text('Update queued change'), findsOneWidget);
    await show(tester);
    expect(find.text('Not applied'), findsNothing);
    expect(
      tester
          .widgetList<RadioSelectionCard>(find.byType(RadioSelectionCard))
          .map((final card) => card.isSelected),
      [true, false, false],
    );
  });

  testWidgets('unknown policy never selects a known default', (
    final tester,
  ) async {
    await show(tester, current: CredentialPolicy.unknown);
    expect(find.text('Policy not recognized by this app'), findsOneWidget);
    expect(
      tester
          .widgetList<RadioSelectionCard>(find.byType(RadioSelectionCard))
          .any((final card) => card.isSelected),
      false,
    );
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });

  testWidgets('refresh cards are actionable and suppress concurrent retries', (
    final tester,
  ) async {
    await show(tester, freshness: Freshness.stale);
    await tester.tap(find.text('Showing cached data'));
    expect(refreshes, 1);
    await show(tester, current: null, error: StateError('offline'));
    await tester.tap(find.text('Could not load the credential policy'));
    expect(refreshes, 2);
    await show(
      tester,
      current: null,
      error: StateError('offline'),
      refreshing: true,
    );
    await tester.tap(find.text('Could not load the credential policy'));
    expect(refreshes, 2);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
  });

  testWidgets('applying keeps the choices visible but disables selection', (
    final tester,
  ) async {
    await show(tester, enabled: false, applying: true);
    expect(find.byType(StatusCard), findsOneWidget);
    expect(find.byType(RadioSelectionCard), findsNWidgets(3));
    expect(
      tester
          .widgetList<RadioSelectionCard>(find.byType(RadioSelectionCard))
          .every((final card) => card.onTap == null),
      true,
    );
    await tester.tap(find.text('Multi-factor authentication'));
    await tester.pump();
    expect(submitted, isEmpty);
  });

  testWidgets('an unavailable policy disables queue submission', (
    final tester,
  ) async {
    await show(tester);
    await tester.tap(find.text('Multi-factor authentication'));
    await tester.pump();
    await show(tester, enabled: false, applying: true);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(submitted, isEmpty);
  });
}
