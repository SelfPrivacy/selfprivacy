import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/ui/pages/more/about_application.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/stalled_certificate_card.dart';

import '../../helpers/widget_harness.dart';

class _MockServerApi extends Mock implements ServerApi {}

class _MockConnection extends Mock implements ApiConnectionRepository {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  setUp(() {
    final connection = _MockConnection();
    when(() => connection.apiData).thenReturn(ApiData(_MockServerApi()));
    getIt.registerSingleton<ApiConnectionRepository>(connection);
  });

  tearDown(getIt.reset);

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
    await pumpForTest(tester, const StalledCertificateCard());

    await tester.tap(find.text('Contact support'));
    await tester.pumpAndSettle();

    expect(find.byType(StalledCertificateCard), findsNothing);
    expect(find.byType(AboutApplicationPage), findsOneWidget);
  });
}
