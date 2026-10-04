import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/users/reset_password_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/pages/users/reset_password/reset_password_page.dart';

import '../../../helpers/operation_fixture.dart';
import '../../../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

class _Jobs extends Mock implements JobsCubit {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  tearDown(getIt.reset);

  testWidgets('disposing the reset page discards its pending secret', (
    final tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final api = _Api();
    final pending = Completer<ServerMutationResult<String>>();
    when(
      () => api.generatePasswordResetLink('alex'),
    ).thenAnswer((_) => pending.future);
    final hub = fixtureHub(api);
    getIt.registerSingleton<ServerConnectionHub>(hub);
    final jobs = _Jobs();
    when(() => jobs.state).thenReturn(JobsStateEmpty());
    when(() => jobs.stream).thenAnswer((_) => const Stream.empty());
    await pumpForTest(tester, const SizedBox.shrink());
    await tester.runAsync(() async {
      await tester.pumpWidget(
        wrapForTest(
          child: BlocProvider<JobsCubit>.value(
            value: jobs,
            child: RepositoryProvider<ServerConnection>.value(
              value: hub.active!,
              child: ResetPasswordPage(user: User.fake(login: 'alex')),
            ),
          ),
        ),
      );
      await tester.pump();
      final bloc = tester
          .element(find.byType(CircularProgressIndicator))
          .read<ResetPasswordBloc>();
      final states = <ResetPasswordState>[];
      final closed = Completer<void>();
      final subscription = bloc.stream.listen(
        states.add,
        onDone: closed.complete,
      );
      verify(() => api.generatePasswordResetLink('alex')).called(1);
      await tester.pumpWidget(const SizedBox.shrink());
      pending.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available(
            'https://auth.example.org/ui/reset?token=late-secret',
          ),
        ),
      );
      await closed.future;
      expect(bloc.isClosed, isTrue);
      expect(
        states.any((final state) => state.passwordResetLink != null),
        isFalse,
      );
      expect(tester.takeException(), isNull);
      await subscription.cancel();
    });
    hub.dispose();
  });
}
