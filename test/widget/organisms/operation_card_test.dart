import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/operations/operation.dart';
import 'package:selfprivacy/ui/organisms/jobs/operation_card.dart';

import '../../helpers/widget_harness.dart';

void main() {
  setUpAll(setUpWidgetTestHarness);
  testWidgets('resize completion discloses that the final size is unverified', (
    final tester,
  ) async {
    final operation = OperationSnapshot(
      id: 1,
      serverId: 'server',
      kind: OperationKind.resizeVolume,
      events: [OperationEvent(DateTime.utc(2026), OperationStatus.succeeded)],
    );
    var removed = false;
    await pumpForTest(
      tester,
      OperationCard(
        operation: operation,
        expanded: true,
        onRemove: () => removed = true,
      ),
    );
    expect(
      find.text('The final disk size has not been verified.'),
      findsOneWidget,
    );
    expect(
      tester.getCenter(find.byIcon(Icons.expand_more)).dx,
      tester.getCenter(find.byIcon(Icons.delete_outline)).dx,
      reason: 'Expansion and history actions share the trailing column',
    );
    await tester.tap(find.byTooltip('Remove from history'));
    expect(removed, isTrue);
  });

  testWidgets('only queued operations offer cancellation', (
    final tester,
  ) async {
    for (final status in [OperationStatus.queued, OperationStatus.running]) {
      await pumpForTest(
        tester,
        OperationCard(
          key: ValueKey(status),
          expanded: true,
          operation: OperationSnapshot(
            id: 1,
            serverId: 'server',
            kind: OperationKind.manageUsers,
            events: [OperationEvent(DateTime.utc(2026), status)],
          ),
          onCancel: () {},
          onRemove: () {},
        ),
      );
      expect(
        find.byTooltip('Cancel'),
        status == OperationStatus.queued ? findsOneWidget : findsNothing,
      );
      expect(find.byTooltip('Remove from history'), findsNothing);
      if (status == OperationStatus.running) {
        expect(find.byIcon(Icons.pending_outlined), findsOneWidget);
      }
    }
  });
}
