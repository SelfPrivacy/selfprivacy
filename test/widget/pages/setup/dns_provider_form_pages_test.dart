import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/dns_provider_picker.dart';
import 'package:selfprivacy/ui/router/router.dart';

import '../../../helpers/widget_harness.dart';

class MockServerInstallationCubit extends Mock
    implements ServerInstallationCubit {}

class MockSupportSystemCubit extends Mock implements SupportSystemCubit {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  late MockServerInstallationCubit serverInstallationCubit;
  late MockSupportSystemCubit supportSystemCubit;

  setUp(() {
    serverInstallationCubit = MockServerInstallationCubit();
    supportSystemCubit = MockSupportSystemCubit();
    when(
      () => serverInstallationCubit.stream,
    ).thenAnswer((_) => const Stream<ServerInstallationState>.empty());
    when(
      () => supportSystemCubit.state,
    ).thenReturn(const SupportSystemState('about'));
    when(
      () => supportSystemCubit.stream,
    ).thenAnswer((_) => const Stream<SupportSystemState>.empty());
  });

  testWidgets('setup provider input owns and disposes the DNS form', (
    final tester,
  ) async {
    await pumpForTest(
      tester,
      ProviderInputDataPage(
        providerInfo: const ProviderPageInfo(
          providerType: DnsProviderType.porkbun,
          pathToHow: 'how_porkbun',
        ),
        serverInstallationCubit: serverInstallationCubit,
      ),
    );

    expect(find.byType(ReactiveTextField<String>), findsNWidgets(2));
    expect(find.text('Provider API Token ID'), findsOneWidget);

    await pumpForTest(tester, const SizedBox());
  });

  testWidgets('recovery page owns and renders the DNS form', (
    final tester,
  ) async {
    when(() => serverInstallationCubit.state).thenReturn(
      ServerInstallationRecovery(
        currentStep: RecoveryStep.dnsProviderToken,
        recoveryCapabilities: ServerRecoveryCapabilities.legacy,
        serverDomain: ServerDomain(
          domainName: 'example.com',
          provider: DnsProviderType.porkbun,
        ),
      ),
    );

    await _pumpRecoveryPage(
      tester,
      serverInstallationCubit: serverInstallationCubit,
      supportSystemCubit: supportSystemCubit,
    );

    expect(find.text('Connect to Porkbun'), findsOneWidget);
    expect(find.byType(ReactiveTextField<String>), findsNWidgets(2));

    await pumpForTest(tester, const SizedBox());
  });
}

Future<void> _pumpRecoveryPage(
  final WidgetTester tester, {
  required final ServerInstallationCubit serverInstallationCubit,
  required final SupportSystemCubit supportSystemCubit,
}) async {
  final router = _createRouter();
  await tester.runAsync(() async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        saveLocale: false,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ServerInstallationCubit>.value(
              value: serverInstallationCubit,
            ),
            BlocProvider<SupportSystemCubit>.value(value: supportSystemCubit),
          ],
          child: Builder(
            builder: (final context) => MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routerConfig: router.config(
                deepLinkBuilder: (final _) =>
                    const DeepLink([RecoveryRoutingRoute()]),
              ),
            ),
          ),
        ),
      ),
    );
    await Future<void>.delayed(Duration.zero);
  });
  await tester.pumpAndSettle();
}

RootRouter _createRouter() => RootRouter(GlobalKey<NavigatorState>());
