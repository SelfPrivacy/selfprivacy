import 'package:auto_route/auto_route.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/ui/router/router.dart';

import '../../../helpers/widget_harness.dart';

class _MockServerInstallationCubit extends Mock
    implements ServerInstallationCubit {}

class _MockSupportSystemCubit extends Mock implements SupportSystemCubit {}

String _validMnemonic(final int entropyBytes) =>
    Mnemonic(List<int>.filled(entropyBytes, 0), Language.english).sentence;

void main() {
  setUpAll(setUpWidgetTestHarness);

  late _MockServerInstallationCubit serverInstallationCubit;
  late _MockSupportSystemCubit supportSystemCubit;
  late void Function(RecoveryStep step) setRecoveryStep;
  late Future<void> Function(WidgetTester tester) pumpRecoveryPage;

  setUp(() {
    serverInstallationCubit = _MockServerInstallationCubit();
    supportSystemCubit = _MockSupportSystemCubit();
    when(
      () => serverInstallationCubit.stream,
    ).thenAnswer((final _) => const Stream<ServerInstallationState>.empty());
    when(
      () => supportSystemCubit.stream,
    ).thenAnswer((final _) => const Stream<SupportSystemState>.empty());
    when(
      () => supportSystemCubit.state,
    ).thenReturn(const SupportSystemState('about'));
    setRecoveryStep = (final step) {
      when(() => serverInstallationCubit.state).thenReturn(
        ServerInstallationRecovery(
          currentStep: step,
          recoveryCapabilities: ServerRecoveryCapabilities.loginTokens,
        ),
      );
    };
    pumpRecoveryPage = (final tester) async {
      final router = RootRouter(GlobalKey<NavigatorState>());
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
                BlocProvider<SupportSystemCubit>.value(
                  value: supportSystemCubit,
                ),
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
    };
  });

  testWidgets('recovery-key input owns and renders the reactive form', (
    final tester,
  ) async {
    setRecoveryStep(RecoveryStep.recoveryKey);
    final phrase = _validMnemonic(24);
    when(
      () => serverInstallationCubit.tryToRecover(
        any(),
        ServerRecoveryMethods.recoveryKey,
      ),
    ).thenAnswer((final _) async {});

    await pumpRecoveryPage(tester);
    await tester.enterText(
      find.byType(ReactiveTextField<String>),
      ' ${phrase.toUpperCase()} ',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(find.byType(ReactiveTextField<String>), findsOneWidget);
    verify(
      () => serverInstallationCubit.tryToRecover(
        phrase,
        ServerRecoveryMethods.recoveryKey,
      ),
    ).called(1);
  });

  testWidgets('old-token input owns and renders the reactive form', (
    final tester,
  ) async {
    setRecoveryStep(RecoveryStep.oldToken);
    when(
      () => serverInstallationCubit.tryToRecover(
        any(),
        ServerRecoveryMethods.oldToken,
      ),
    ).thenAnswer((final _) async {});

    await pumpRecoveryPage(tester);
    await tester.enterText(
      find.byType(ReactiveTextField<String>),
      ' Token-AbC ',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(find.byType(ReactiveTextField<String>), findsOneWidget);
    verify(
      () => serverInstallationCubit.tryToRecover(
        'Token-AbC',
        ServerRecoveryMethods.oldToken,
      ),
    ).called(1);
  });

  testWidgets('new-device-key input owns and renders the reactive form', (
    final tester,
  ) async {
    setRecoveryStep(RecoveryStep.newDeviceKey);
    final phrase = _validMnemonic(16);
    when(
      () => serverInstallationCubit.tryToRecover(
        any(),
        ServerRecoveryMethods.newDeviceKey,
      ),
    ).thenAnswer((final _) async {});

    await pumpRecoveryPage(tester);
    await tester.tap(find.text('I have received my token'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(ReactiveTextField<String>), phrase);
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(find.byType(ReactiveTextField<String>), findsOneWidget);
    verify(
      () => serverInstallationCubit.tryToRecover(
        phrase,
        ServerRecoveryMethods.newDeviceKey,
      ),
    ).called(1);
  });
}
