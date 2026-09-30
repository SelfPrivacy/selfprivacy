import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/connection/lifecycle/app_lifecycle.dart';

class _Binding extends Mock implements WidgetsBinding {}

void main() {
  test('unknown initial visibility does not permit background work', () {
    final binding = _Binding();
    final lifecycle = AppLifecycle(binding: binding);
    expect(lifecycle.isForeground, isFalse);
    verify(() => binding.addObserver(lifecycle)).called(1);
    when(() => binding.removeObserver(lifecycle)).thenReturn(true);
    lifecycle.dispose();
    verify(() => binding.removeObserver(lifecycle)).called(1);
  });

  for (final state in AppLifecycleState.values) {
    testWidgets('reads initial $state from the binding', (final tester) async {
      tester.binding.handleAppLifecycleStateChanged(state);
      final lifecycle = AppLifecycle();
      expect(
        lifecycle.isForeground,
        state == AppLifecycleState.resumed ||
            state == AppLifecycleState.inactive,
      );
      lifecycle.dispose();
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    });
  }

  testWidgets(
    'emits visibility changes immediately and ignores focus changes',
    (final tester) async {
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      final lifecycle = AppLifecycle();
      final states = <bool>[];
      final subscription = lifecycle.foregroundChanges.listen(states.add);
      addTearDown(subscription.cancel);
      expect(states, isEmpty);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      expect(lifecycle.isForeground, isTrue);
      expect(states, isEmpty);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
      expect(states, [false]);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      expect(states, [false]);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      expect(states, [false, true]);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      expect(states, [false, true]);
      lifecycle.dispose();
    },
  );

  testWidgets('disposal unregisters observation and closes the stream', (
    final tester,
  ) async {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    final lifecycle = AppLifecycle();
    var closed = false;
    final subscription = lifecycle.foregroundChanges.listen(
      (_) {},
      onDone: () => closed = true,
    );
    addTearDown(subscription.cancel);
    lifecycle
      ..dispose()
      ..dispose();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    lifecycle.didChangeAppLifecycleState(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(closed, isTrue);
    expect(lifecycle.isForeground, isTrue);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
  });
}
