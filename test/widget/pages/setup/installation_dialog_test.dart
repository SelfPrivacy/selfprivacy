import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/server_installation/provisioning_dialog.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/provisioning_request.dart';
import 'package:selfprivacy/logic/models/provisioning_result.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/ui/atoms/buttons/dialog_action_button.dart';

import '../../../helpers/fixtures/credential_fixtures.dart';
import '../../../helpers/fixtures/server_fixtures.dart';
import '../../../helpers/widget_harness.dart';

class _Repository extends Mock implements ServerInstallationRepository {}

class _ServerProvider extends Mock implements ServerProvider {}

class _DnsProvider extends Mock implements DnsProvider {}

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    registerFallbackValue(aProvisioningRequest());
    registerFallbackValue(aServerHostingDetails());
    registerFallbackValue(aServerDomain());
  });
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
    cubit.closeTimer();
    if (!cubit.isClosed) {
      await cubit.close();
    }
    await getIt.reset();
  });

  group('provisioning consumer', () {
    late _ServerProvider provider;
    late _DnsProvider dns;

    Future<void> prepare(final WidgetTester tester) async {
      await cubit.close();
      provider = _ServerProvider();
      dns = _DnsProvider();
      cubit = ServerInstallationCubit(
        repository: repository,
        serverProvider: provider,
        dnsProvider: dns,
      );
      when(() => repository.load()).thenAnswer(
        (_) async => ServerInstallationNotFinished(
          providerApiToken: 'provider-token',
          serverTypeIdentificator: 'cpx22',
          serverLocation: 'fsn1',
          dnsApiCredential: aDnsProviderCredential(),
          serverDomain: aServerDomain(),
          isServerStarted: false,
          isCertificateVerified: false,
          isServerRebooted: false,
          isLoading: false,
          dnsMatches: null,
          customSshKey: null,
        ),
      );
      await pumpForTest(
        tester,
        MaterialApp(
          navigatorKey: navigation.navigatorKey,
          home: const Scaffold(body: SizedBox.shrink()),
        ),
      );
      await cubit.load();
    }

    for (final kind in [
      ProvisioningFailureKind.rejected,
      ProvisioningFailureKind.indeterminate,
    ]) {
      testWidgets('$kind never saves details or changes DNS', (
        final tester,
      ) async {
        await prepare(tester);
        when(() => provider.provisionServer(any())).thenAnswer(
          (_) async => ProvisioningFailed(
            stage: ProvisioningStage.createServer,
            kind: kind,
            resources: [],
          ),
        );
        await cubit.createServerAndSetDnsRecords();
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(
          find.byType(DialogActionButton),
          findsNWidgets(kind == ProvisioningFailureKind.indeterminate ? 1 : 2),
        );
        await cubit.createServerAndSetDnsRecords();
        verify(() => provider.provisionServer(any())).called(1);
        verifyNever(() => repository.saveServerDetails(any()));
        verifyZeroInteractions(dns);
      });
    }

    testWidgets('retry taps share one new request and generate a fresh token', (
      final tester,
    ) async {
      await prepare(tester);
      final response = Completer<ProvisioningResult>();
      var calls = 0;
      when(() => provider.provisionServer(any())).thenAnswer(
        (_) => ++calls == 1
            ? Future.value(
                ProvisioningFailed(
                  stage: ProvisioningStage.createServer,
                  kind: ProvisioningFailureKind.rejected,
                  resources: [],
                ),
              )
            : response.future,
      );
      await cubit.createServerAndSetDnsRecords();
      await tester.pumpAndSettle();
      final retry = cubit.state.installationDialoguePopUp!.choices[1].callback!;
      final first = retry();
      final second = retry();
      expect(calls, 2);
      await cubit.close();
      response.complete(
        ProvisioningFailed(
          stage: ProvisioningStage.createServer,
          kind: ProvisioningFailureKind.indeterminate,
          resources: [],
        ),
      );
      await Future.wait([first, second]);
      final requests = verify(
        () => provider.provisionServer(captureAny()),
      ).captured.cast<ProvisioningRequest>();
      expect(requests, hasLength(2));
      expect(requests[0].serverApiToken, isNot(requests[1].serverApiToken));
      verifyNever(() => repository.saveServerDetails(any()));
    });

    testWidgets('confirmed provisioning saves once and continues DNS once', (
      final tester,
    ) async {
      await prepare(tester);
      final details = aServerHostingDetails();
      when(() => provider.provisionServer(any())).thenAnswer(
        (_) async => ProvisioningCompleted(details: details, resources: []),
      );
      when(() => repository.saveServerDetails(any())).thenAnswer((_) async {});
      when(
        () => dns.removeDomainRecords(
          records: any(named: 'records'),
          domain: any(named: 'domain'),
        ),
      ).thenAnswer((_) async => GenericResult(success: true, data: null));
      when(
        () => dns.createDomainRecords(
          records: any(named: 'records'),
          domain: any(named: 'domain'),
        ),
      ).thenAnswer((_) async => GenericResult(success: true, data: null));
      await cubit.createServerAndSetDnsRecords();
      verify(() => repository.saveServerDetails(details)).called(1);
      verify(
        () => dns.removeDomainRecords(
          records: any(named: 'records'),
          domain: any(named: 'domain'),
        ),
      ).called(1);
      verify(
        () => dns.createDomainRecords(
          records: any(named: 'records'),
          domain: any(named: 'domain'),
        ),
      ).called(1);
      expect(cubit.state.serverDetails, same(details));
      expect(cubit.timer?.isActive, isTrue);
      cubit.closeTimer();
    });

    testWidgets('close during persistence prevents the DNS continuation', (
      final tester,
    ) async {
      await prepare(tester);
      final saved = Completer<void>();
      when(() => provider.provisionServer(any())).thenAnswer(
        (_) async => ProvisioningCompleted(
          details: aServerHostingDetails(),
          resources: [],
        ),
      );
      when(
        () => repository.saveServerDetails(any()),
      ).thenAnswer((_) => saved.future);
      final pending = cubit.createServerAndSetDnsRecords();
      await tester.pump(Duration.zero);
      verify(() => repository.saveServerDetails(any())).called(1);
      await cubit.close();
      saved.complete();
      await pending;
      verifyZeroInteractions(dns);
    });
  });

  CallbackDialogueBranching failureDialog(
    final ProvisioningFailureKind kind, {
    final List<ProvisionedResource> resources = const [],
    final Future<void> Function()? onStop,
    final Future<GenericResult<CallbackDialogueBranching?>> Function()? onRetry,
    final Future<GenericResult<void>> Function(ProvisionedResource)?
    deleteResource,
  }) => provisioningFailureDialog(
    failure: ProvisioningFailed(
      stage: ProvisioningStage.createServer,
      kind: kind,
      resources: resources,
    ),
    onStop: onStop ?? () async {},
    onRetry: onRetry ?? () async => GenericResult(success: true, data: null),
    deleteResource:
        deleteResource ?? (_) async => GenericResult(success: true, data: null),
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
      () => failureDialog(
        ProvisioningFailureKind.nameConflict,
        onStop: () async {
          stopped = true;
        },
      ),
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
    final deleted = <String?>[];
    await pumpDialog(
      tester,
      () => failureDialog(
        ProvisioningFailureKind.rejected,
        resources: [
          ProvisionedResource(
            provider: ServerProviderType.hetzner,
            kind: ProvisionedResourceKind.volume,
            id: '41',
          ),
          ProvisionedResource(
            provider: ServerProviderType.hetzner,
            kind: ProvisionedResourceKind.server,
            id: '7',
          ),
        ],
        onStop: () async {
          stopped = true;
        },
        deleteResource: (final resource) async {
          deleted.add(resource.id);
          return GenericResult(
            success:
                resource.kind == ProvisionedResourceKind.volume ||
                ++attempts > 1,
            data: null,
          );
        },
        onRetry: () async {
          continued = true;
          return GenericResult(success: true, data: null);
        },
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
    expect(deleted, ['7', '7', '41']);
    expect(stopped, isFalse);
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets(
    'uncertain creation offers only stop and never cleans earlier resources',
    (final tester) async {
      var stopped = false;
      var retried = false;
      final deleted = <ProvisionedResource>[];
      await pumpDialog(
        tester,
        () => failureDialog(
          ProvisioningFailureKind.indeterminate,
          resources: [
            ProvisionedResource(
              provider: ServerProviderType.hetzner,
              kind: ProvisionedResourceKind.volume,
              id: '41',
            ),
          ],
          onStop: () async {
            stopped = true;
          },
          onRetry: () async {
            retried = true;
            return GenericResult(success: true, data: null);
          },
          deleteResource: (final resource) async {
            deleted.add(resource);
            return GenericResult(success: true, data: null);
          },
        ),
      );
      expect(find.byType(DialogActionButton), findsOneWidget);
      await tester.tap(find.byType(DialogActionButton));
      await tester.pumpAndSettle();
      expect(stopped, isTrue);
      expect(retried, isFalse);
      expect(deleted, isEmpty);
    },
  );

  test('repeated cleanup submissions share one action', () async {
    final pendingDelete = Completer<GenericResult<void>>();
    var deletes = 0;
    var retries = 0;
    final dialog = failureDialog(
      ProvisioningFailureKind.rejected,
      resources: [
        ProvisionedResource(
          provider: ServerProviderType.hetzner,
          kind: ProvisionedResourceKind.volume,
          id: '41',
        ),
      ],
      deleteResource: (_) {
        deletes++;
        return pendingDelete.future;
      },
      onRetry: () async {
        retries++;
        return GenericResult(success: true, data: null);
      },
    );
    final first = dialog.choices[1].callback!();
    final second = dialog.choices[1].callback!();
    expect(deletes, 1);
    pendingDelete.complete(GenericResult(success: true, data: null));
    await Future.wait([first, second]);
    expect(deletes, 1);
    expect(retries, 1);
  });

  for (final id in ['41', null, '', '   ']) {
    test(
      'leaving unreadable resource ($id) never deletes or retries',
      () async {
        var stopped = 0;
        var retries = 0;
        final deleted = <ProvisionedResource>[];
        final dialog = failureDialog(
          ProvisioningFailureKind.unreadable,
          resources: [
            ProvisionedResource(
              provider: ServerProviderType.hetzner,
              kind: ProvisionedResourceKind.volume,
              id: id,
            ),
          ],
          onStop: () async {
            stopped++;
          },
          onRetry: () async {
            retries++;
            return GenericResult(success: true, data: null);
          },
          deleteResource: (final resource) async {
            deleted.add(resource);
            return GenericResult(success: true, data: null);
          },
        );
        await dialog.choices[0].callback!();
        if (id == null || id.trim().isEmpty) {
          await dialog.choices[1].callback!();
        }
        expect(stopped, id == '41' ? 1 : 2);
        expect(retries, 0);
        expect(deleted, isEmpty);
      },
    );
  }

  test(
    'unreadable creation permits explicit cleanup but never recreates',
    () async {
      var stopped = false;
      var retried = false;
      final deleted = <String?>[];
      final dialog = failureDialog(
        ProvisioningFailureKind.unreadable,
        resources: [
          ProvisionedResource(
            provider: ServerProviderType.hetzner,
            kind: ProvisionedResourceKind.volume,
            id: '41',
          ),
          ProvisionedResource(
            provider: ServerProviderType.hetzner,
            kind: ProvisionedResourceKind.server,
            id: '7',
          ),
        ],
        onStop: () async {
          stopped = true;
        },
        onRetry: () async {
          retried = true;
          return GenericResult(success: true, data: null);
        },
        deleteResource: (final resource) async {
          deleted.add(resource.id);
          return GenericResult(success: true, data: null);
        },
      );
      expect(deleted, isEmpty);
      await dialog.choices[1].callback!();
      expect(deleted, ['7', '41']);
      expect(stopped, isTrue);
      expect(retried, isFalse);
    },
  );
}
