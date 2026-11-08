import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';

void main() {
  for (final brightness in Brightness.values) {
    for (final selected in [false, true]) {
      testWidgets(
        'disabled card preserves selection in $brightness: $selected',
        (final tester) async {
          final colors = ColorScheme.fromSeed(
            seedColor: const Color(0xFF455C99),
            brightness: brightness,
          );
          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData(colorScheme: colors),
              home: Scaffold(
                body: RadioSelectionCard(
                  isSelected: selected,
                  title: 'Stable channel',
                  subtitle: 'Latest tested release',
                  onTap: null,
                ),
              ),
            ),
          );
          final card = tester.widget<Card>(find.byType(Card));
          final border = (card.shape! as RoundedRectangleBorder).side;
          // ignore: deprecated_member_use
          expect(card.color, colors.surfaceVariant);
          expect(border.color, colors.outlineVariant);
          expect(border.width, selected ? 3 : 1);
          final icon = tester.widget<Icon>(find.byType(Icon));
          expect(icon.color, colors.outline);
          expect(
            icon.icon,
            selected
                ? Icons.radio_button_on_outlined
                : Icons.radio_button_off_outlined,
          );
          for (final text in ['Stable channel', 'Latest tested release']) {
            expect(
              tester.widget<Text>(find.text(text)).style!.color,
              colors.onSurfaceVariant,
            );
          }
        },
      );
    }
  }

  testWidgets('disabling keeps selection but removes the tap action', (
    final tester,
  ) async {
    final enabled = ValueNotifier(true);
    addTearDown(enabled.dispose);
    var taps = 0;
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ValueListenableBuilder<bool>(
            valueListenable: enabled,
            builder: (final context, final value, final child) =>
                RadioSelectionCard(
                  isSelected: true,
                  title: 'Stable channel',
                  subtitle: 'Latest tested release',
                  onTap: value ? () => taps++ : null,
                ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Stable channel'));
    expect(taps, 1);
    enabled.value = false;
    await tester.pumpAndSettle();
    expect(
      tester.getSemantics(find.byType(RadioSelectionCard)),
      matchesSemantics(
        hasSelectedState: true,
        isSelected: true,
        hasEnabledState: true,
      ),
    );
    await tester.tap(find.text('Stable channel'));
    expect(taps, 1);
    enabled.value = true;
    await tester.pumpAndSettle();
    await tester.tap(find.text('Stable channel'));
    expect(taps, 2);
    semantics.dispose();
  });
}
