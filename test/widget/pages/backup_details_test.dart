import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/tokens/tokens_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/ui/pages/backups/backup_details.dart';

import '../../helpers/fixtures/credential_fixtures.dart';
import '../../helpers/fixtures/server_fixtures.dart';
import '../../helpers/widget_harness.dart';

class _Backups extends Mock implements BackupsBloc {}

class _ServerJobs extends Mock implements ServerJobsBloc {}

class _Services extends Mock implements ServicesBloc {}

class _Tokens extends Mock implements TokensBloc {}

class _Readiness extends Mock implements AppReadinessCubit {}

class _Navigation extends Mock implements NavigationService {}

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    registerFallbackValue(InitializeBackupsRepository(aBackupsCredential()));
  });
  tearDown(getIt.reset);

  for (final count in [1, 2]) {
    testWidgets('initialization with $count backup credentials', (
      final tester,
    ) async {
      tester.view.physicalSize = const Size(1000, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final backups = _Backups();
      final serverJobs = _ServerJobs();
      final services = _Services();
      final tokens = _Tokens();
      final readiness = _Readiness();
      final navigation = _Navigation();
      getIt.registerSingleton<NavigationService>(navigation);
      final credentials = List.generate(
        count,
        (final i) => aBackupsCredential(uuid: 'credential-$i'),
      );
      when(() => backups.state).thenReturn(const BackupsUninitialized());
      when(() => backups.stream).thenAnswer((_) => const Stream.empty());
      when(() => serverJobs.state).thenReturn(ServerJobsListEmptyState());
      when(() => serverJobs.stream).thenAnswer((_) => const Stream.empty());
      when(() => services.state).thenReturn(ServicesInitial());
      when(() => services.stream).thenAnswer((_) => const Stream.empty());
      when(() => tokens.state).thenReturn(
        TokensChecked(
          serverProviderCredentials: const [],
          dnsProviderCredentials: const [],
          backupsCredentials: credentials
              .map(
                (final credential) => TokenStatusWrapper(
                  data: credential,
                  status: TokenStatus.valid,
                ),
              )
              .toList(),
        ),
      );
      when(() => tokens.stream).thenAnswer((_) => const Stream.empty());
      when(() => readiness.state).thenReturn(ServerConfigured(aServer()));
      when(() => readiness.stream).thenAnswer((_) => const Stream.empty());
      await pumpForTest(
        tester,
        MultiBlocProvider(
          providers: [
            BlocProvider<BackupsBloc>.value(value: backups),
            BlocProvider<ServerJobsBloc>.value(value: serverJobs),
            BlocProvider<ServicesBloc>.value(value: services),
            BlocProvider<TokensBloc>.value(value: tokens),
            BlocProvider<AppReadinessCubit>.value(value: readiness),
          ],
          child: const BackupDetailsPage(),
        ),
      );
      await tester.tap(find.text('Initialize'));
      await tester.pump();
      if (count == 1) {
        final event =
            verify(() => backups.add(captureAny())).captured.single
                as InitializeBackupsRepository;
        expect(event.credential, same(credentials.single));
      } else {
        verifyNever(() => backups.add(any()));
        verify(() => navigation.showSnackBar(any())).called(1);
      }
      expect(tester.takeException(), isNull);
    });
  }
}
