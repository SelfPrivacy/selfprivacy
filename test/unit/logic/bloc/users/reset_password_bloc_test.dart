import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/users/reset_password_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../../helpers/operation_fixture.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  late _Api api;
  late ResetPasswordBloc bloc;
  late ServerConnectionHub hub;
  setUp(() {
    api = _Api();
    hub = fixtureHub(api);
    bloc = createResetPasswordBloc(hub.active!, User.fake(login: 'alex'));
  });
  tearDown(() => bloc.close());

  for (final outcome in ServerMutationOutcome.values) {
    for (final secret in [
      if (outcome == ServerMutationOutcome.confirmed) ...[
        null,
        '',
        'relative/path',
      ],
      'https://auth.example.org/ui/reset?token=abcd-0123-abcd-0123',
    ]) {
      test(
        'reset link requires confirmation and URI: ${outcome.name}/$secret',
        () async {
          when(() => api.generatePasswordResetLink('alex')).thenAnswer(
            (_) async => ServerMutationResult(
              outcome: outcome,
              payload: secret == null
                  ? const ServerMutationPayload.missing()
                  : ServerMutationPayload.available(secret),
              message: 'secret-sentinel',
            ),
          );
          final result = bloc.stream.firstWhere(
            (final state) =>
                !state.isLoading &&
                (state.passwordResetLink != null ||
                    state.errorMessage.isNotEmpty),
          );
          bloc.add(const RequestNewPassword());
          final state = await result;
          expect(
            state.passwordResetLink,
            outcome == ServerMutationOutcome.confirmed &&
                    secret != null &&
                    secret.startsWith('https:')
                ? Uri.parse(secret)
                : null,
          );
          expect(state.errorMessage, isNot(contains('secret-sentinel')));
        },
      );
    }
  }

  test('cancellation prevents a reset queued behind another command', () async {
    final blocker = Completer<ServerMutationResult<User>>();
    final user = User.fake(login: 'alex');
    when(
      () => api.updateUser(any(), any(), any()),
    ).thenAnswer((_) => blocker.future);
    final active = hub.active!.run(
      OperationKind.manageUsers,
      (final owner) => owner.users.updateUser(user),
    );
    bloc.add(const RequestNewPassword());
    await bloc.stream.firstWhere((final state) => state.isLoading);
    bloc.add(const CancelNewPasswordRequest());
    await bloc.stream.firstWhere((final state) => !state.isLoading);
    blocker.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(user),
      ),
    );
    await active;
    await pumpEventQueue();
    verifyNever(() => api.generatePasswordResetLink(any()));
    expect(hub.active!.operations.history.last.status, OperationStatus.notSent);
  });

  test('cancellation does not publish a late secret', () async {
    final sent = Completer<void>();
    final pending = Completer<ServerMutationResult<String>>();
    when(() => api.generatePasswordResetLink('alex')).thenAnswer((_) {
      sent.complete();
      return pending.future;
    });
    bloc.add(const RequestNewPassword());
    await sent.future;
    final cancelled = bloc.stream.firstWhere((final state) => !state.isLoading);
    bloc.add(const CancelNewPasswordRequest());
    await cancelled;
    pending.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available(
          'https://auth.example.org/ui/reset?token=late-secret',
        ),
      ),
    );
    await pumpEventQueue();
    expect(bloc.state.passwordResetLink, isNull);
    expect(
      hub.active!.operations.history.last.status,
      OperationStatus.succeeded,
    );
  });
}
