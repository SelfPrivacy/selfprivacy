import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/ui/pages/more/about_application.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/stalled_certificate_card.dart';

import '../../helpers/widget_harness.dart';

class _Hub extends Mock implements ServerConnectionHub {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  testWidgets('names the problem and what to check', (final tester) async {
    await pumpForTest(tester, const StalledCertificateCard());

    expect(find.text('Still no security certificate'), findsOneWidget);
    expect(
      find.textContaining("Let's Encrypt has not issued a certificate"),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.gpp_maybe_outlined), findsOneWidget);
  });

  testWidgets('opens the support screen', (final tester) async {
    final hub = _Hub();
    when(() => hub.changes).thenAnswer((_) => const Stream.empty());
    getIt.registerSingleton<ServerConnectionHub>(hub);
    addTearDown(() => getIt.unregister<ServerConnectionHub>());
    await tester.runAsync(() async {
      await tester.pumpWidget(
        wrapForTest(child: const StalledCertificateCard()),
      );
      await Future<void>.delayed(Duration.zero);
    });
    await tester.pumpAndSettle();

    await tester.tap(find.text('Contact support'));
    await tester.pumpAndSettle();

    expect(find.byType(StalledCertificateCard), findsNothing);
    expect(find.byType(AboutApplicationPage), findsOneWidget);
  });
}
