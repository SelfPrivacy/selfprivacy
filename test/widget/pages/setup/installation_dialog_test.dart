import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/providers/server_providers/resource_creation_dialog.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/ui/atoms/buttons/dialog_action_button.dart';

import '../../../helpers/fixtures/credential_fixtures.dart';
import '../../../helpers/fixtures/server_fixtures.dart';
import '../../../helpers/widget_harness.dart';

class _Repository extends Mock implements ServerInstallationRepository {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late _Repository repository;
  late ServerInstallationCubit cubit;
  late NavigationService navigation;

  setUp(() {
    repository = _Repository();
    cubit = ServerInstallationCubit(repository: repository);
    navigation = NavigationService();
    getIt.registerSingleton<NavigationService>(navigation);
  });
  tearDown(() async {
    await cubit.close();
    await getIt.reset();
  });

  LaunchInstallationData installationData(final VoidCallback onStop) =>
      LaunchInstallationData(
        dnsApiCredential: aDnsProviderCredential(),
        serverDomain: aServerDomain(),
        serverTypeId: 'cpx12',
        errorCallback: onStop,
        successCallback: (_) {},
        storageSize: cubit.initialStorage,
        customSshKey: null,
        location: 'fsn1',
      );

  Future<void> pumpDialog(
    final WidgetTester tester,
    final CallbackDialogueBranching Function() createDialog,
  ) async {
    await pumpForTest(
      tester,
      MaterialApp(
        navigatorKey: navigation.navigatorKey,
        home: const Scaffold(body: SizedBox.shrink()),
      ),
    );
    final dialog = createDialog();
    when(() => repository.load()).thenAnswer(
      (_) async => ServerInstallationNotFinished(
        isServerStarted: false,
        isCertificateVerified: false,
        isServerRebooted: false,
        isLoading: false,
        dnsMatches: null,
        customSshKey: null,
        installationDialoguePopUp: dialog,
      ),
    );
    await cubit.load();
    await tester.pumpAndSettle();
  }

  testWidgets('a name conflict renders one stop action and invokes it', (
    final tester,
  ) async {
    var stopped = false;
    await pumpDialog(
      tester,
      () => serverNameConflictResult(
        installationData: installationData(() => stopped = true),
      ).data!,
    );

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(DialogActionButton), findsOneWidget);
    expect(stopped, isFalse);
    await tester.tap(find.byType(DialogActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(stopped, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a dismiss-only choice closes without invoking a callback', (
    final tester,
  ) async {
    var retried = false;
    await pumpDialog(
      tester,
      () => CallbackDialogueBranching(
        title: 'Failure',
        description: 'Installation did not finish.',
        choices: [
          CallbackDialogueChoice(title: 'Close', callback: null),
          CallbackDialogueChoice(
            title: 'Retry',
            callback: () async {
              retried = true;
              return GenericResult(success: true, data: null);
            },
          ),
        ],
      ),
    );

    await tester.tap(find.widgetWithText(DialogActionButton, 'Close'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(retried, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('cleanup retry replaces the modal and preserves continuation', (
    final tester,
  ) async {
    var attempts = 0;
    var continued = false;
    var stopped = false;
    final data = installationData(() => stopped = true);
    await pumpDialog(
      tester,
      () => CallbackDialogueBranching(
        title: 'Failure',
        description: 'Installation did not finish.',
        choices: [
          CallbackDialogueChoice(title: 'Close', callback: null),
          CallbackDialogueChoice(
            title: 'Retry',
            callback: () => cleanupInstallationResources(
              installationData: data,
              cleanup: () async =>
                  GenericResult(success: ++attempts > 1, data: null),
              onSuccess: () async {
                continued = true;
                return GenericResult(success: true, data: null);
              },
            ),
          ),
        ],
      ),
    );
    final retry = find.byWidgetPredicate(
      (final widget) => widget is DialogActionButton && widget.isRed,
    );
    await tester.tap(retry);
    await tester.pumpAndSettle();
    expect(attempts, 1);
    expect(continued, isFalse);
    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.tap(retry);
    await tester.pumpAndSettle();
    expect(attempts, 2);
    expect(continued, isTrue);
    expect(stopped, isFalse);
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
