import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/ui/molecules/list_items/token_renewal_subtitle.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/server_fixtures.dart';
import '../../../helpers/widget_harness.dart';

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    await setUpInMemoryHive();
  });
  tearDownAll(tearDownInMemoryHive);

  late ResourcesModel resourcesModel;

  setUp(() async {
    await Hive.openBox(BNames.resourcesBox);
    resourcesModel = ResourcesModel()..init();
  });

  tearDown(() async {
    await resourcesModel.dispose();
    final box = Hive.box(BNames.resourcesBox);
    await box.clear();
    await box.close();
  });

  Future<void> pumpSubtitle(final WidgetTester tester) =>
      pumpForTest(tester, TokenRenewalSubtitle(resourcesModel: resourcesModel));

  Future<void> addServer(final WidgetTester tester, final Server server) async {
    await tester.runAsync(() => resourcesModel.addServer(server));
  }

  testWidgets('shows that there is no token to renew', (final tester) async {
    await pumpSubtitle(tester);

    expect(find.text('There is no token to renew yet.'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('shows that an untracked token is due now', (final tester) async {
    await addServer(tester, aServer());
    await pumpSubtitle(tester);

    expect(find.text('Token renewal is due now.'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('shows the next renewal as relative time', (final tester) async {
    await addServer(
      tester,
      aServer(
        hostingDetails: aServerHostingDetails(
          apiTokenRotatedAt: DateTime.now().add(const Duration(minutes: 1)),
        ),
      ),
    );
    await pumpSubtitle(tester);

    expect(find.text('Next token renewal in 30 days.'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('shows an overdue renewal as relative time', (
    final tester,
  ) async {
    await addServer(
      tester,
      aServer(
        hostingDetails: aServerHostingDetails(
          apiTokenRotatedAt: DateTime.now().subtract(const Duration(days: 31)),
        ),
      ),
    );
    await pumpSubtitle(tester);

    expect(find.text('Token renewal was due 1 day ago.'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('updates after the stored server token changes', (
    final tester,
  ) async {
    final server = aServer(
      hostingDetails: aServerHostingDetails(
        apiTokenRotatedAt: DateTime.now().subtract(const Duration(days: 31)),
      ),
    );
    await addServer(tester, server);
    await pumpSubtitle(tester);
    expect(find.text('Token renewal was due 1 day ago.'), findsOneWidget);

    await tester.runAsync(
      () => resourcesModel.updateServerByDomain(
        aServer(
          domain: server.domain,
          hostingDetails: server.hostingDetails.copyWith(
            apiToken: 'renewed-token',
            apiTokenRotatedAt: DateTime.now().add(const Duration(minutes: 1)),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Next token renewal in 30 days.'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
