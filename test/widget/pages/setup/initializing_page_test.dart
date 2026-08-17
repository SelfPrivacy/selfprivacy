import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/initializing.dart';

import '../../../helpers/fixtures/credential_fixtures.dart';
import '../../../helpers/fixtures/server_fixtures.dart';
import '../../../helpers/widget_harness.dart';

class _MockServerInstallationCubit extends Mock
    implements ServerInstallationCubit {}

class _MockSupportSystemCubit extends Mock implements SupportSystemCubit {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  late _MockServerInstallationCubit serverInstallationCubit;
  late _MockSupportSystemCubit supportSystemCubit;

  setUp(() {
    getIt.registerSingleton<DeveloperSettingsModel>(DeveloperSettingsModel());
    serverInstallationCubit = _MockServerInstallationCubit();
    supportSystemCubit = _MockSupportSystemCubit();

    when(() => serverInstallationCubit.state).thenReturn(
      ServerInstallationNotFinished(
        providerApiToken: 'server-token',
        serverTypeIdentificator: 'cx22',
        serverLocation: 'fsn1',
        dnsApiCredential: aDnsProviderCredential(),
        serverDomain: aServerDomain(),
        serverDetails: null,
        isServerStarted: false,
        isCertificateVerified: false,
        isServerRebooted: false,
        isLoading: false,
        dnsMatches: null,
        customSshKey: null,
      ),
    );
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

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('shows server creation after domain selection', (
    final tester,
  ) async {
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
            builder: (final context) => MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: const InitializingPage(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Create server'), findsWidgets);
    expect(find.text('Create master account'), findsNothing);
    expect(find.text('Enter username and strong password'), findsNothing);
  });
}
