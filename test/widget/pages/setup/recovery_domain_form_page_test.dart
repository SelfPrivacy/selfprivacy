import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/ui/router/router.dart';

import '../../../helpers/widget_harness.dart';

class _MockServerInstallationCubit extends Mock
    implements ServerInstallationCubit {}

class _MockSupportSystemCubit extends Mock implements SupportSystemCubit {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  testWidgets('shows an error when recovery is unavailable', (
    final tester,
  ) async {
    final cubit = _MockServerInstallationCubit();
    final supportSystemCubit = _MockSupportSystemCubit();
    final states = StreamController<ServerInstallationState>.broadcast();
    addTearDown(states.close);
    when(() => cubit.state).thenReturn(const ServerInstallationEmpty());
    when(() => cubit.stream).thenAnswer((final _) => states.stream);
    when(
      () => supportSystemCubit.stream,
    ).thenAnswer((final _) => const Stream<SupportSystemState>.empty());
    when(
      () => supportSystemCubit.state,
    ).thenReturn(const SupportSystemState('about'));

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
              BlocProvider<ServerInstallationCubit>.value(value: cubit),
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

    states.add(
      const ServerInstallationRecovery(
        currentStep: RecoveryStep.selecting,
        recoveryCapabilities: ServerRecoveryCapabilities.none,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Server with such domain was not found'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });
}
