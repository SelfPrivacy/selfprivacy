import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/recovery_key/recovery_key_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';

import '../../../../helpers/operation_fixture.dart';
import '../../../../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late _Api api;
  late ServerConnectionHub hub;
  late RecoveryKeyBloc bloc;

  setUp(() async {
    api = _Api();
    hub = fixtureHub(api);
    when(api.getRecoveryTokenStatus).thenAnswer(
      (_) async =>
          const RecoveryKeyStatus(exists: true, valid: true, usesLeft: 3),
    );
    await hub.active!.recoveryKey.refresh();
    bloc = createRecoveryKeyBloc(hub);
    await bloc.stream.firstWhere((final state) => state is RecoveryKeyLoaded);
  });

  tearDown(() async {
    await bloc.close();
  });

  test('loaded status is a captured value', () {
    final state = RecoveryKeyLoaded(
      keyStatus: RecoveryKeyStatus(
        exists: true,
        valid: true,
        date: DateTime.utc(2026),
        usesLeft: 3,
      ),
    );
    expect(state.exists, isTrue);
    expect(state.isValid, isTrue);
    expect(state.generatedAt, DateTime.utc(2026));
    expect(state.usesLeft, 3);
  });

  test('refresh failure retains the observed status', () async {
    final before = bloc.state;
    when(api.getRecoveryTokenStatus).thenThrow(StateError('unavailable'));
    final failed = bloc.stream.firstWhere(
      (final state) => state is RecoveryKeyError,
    );
    bloc.add(const RecoveryKeyStatusRefresh());
    expect((await failed).usesLeft, 3);
    expect(before, isA<RecoveryKeyLoaded>());
    expect(before.isValid, isTrue);
  });

  test('reset discards a queued status refresh', () async {
    clearInteractions(api);
    bloc.add(const RecoveryKeyStatusRefresh());
    hub
      ..clear()
      ..resume();
    hub.active!.cache.setVersion(Version(3, 6, 0));
    await pumpEventQueue();
    verifyNever(api.getRecoveryTokenStatus);
  });

  test('closing the caller discards a late generated secret', () async {
    final pending = Completer<ServerMutationResult<String>>();
    final sent = Completer<void>();
    when(() => api.generateRecoveryToken(null, null)).thenAnswer((_) {
      sent.complete();
      return pending.future;
    });
    final result = bloc.generateRecoveryKey();
    final discarded = expectLater(result, throwsA(isA<GenerationError>()));
    await sent.future;
    await bloc.close();
    pending.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available('late-secret'),
      ),
    );
    await discarded;
  });

  for (final outcome in ServerMutationOutcome.values) {
    for (final secret in ['fixture-secret', '', null]) {
      testWidgets('recovery key ${outcome.name}/$secret', (final tester) async {
        await pumpForTest(tester, const SizedBox.shrink());
        await tester.runAsync(() async {
          final result = ServerMutationResult<String>(
            outcome: outcome,
            payload: secret == null
                ? const ServerMutationPayload.missing()
                : ServerMutationPayload.available(secret),
            message: 'secret-sentinel',
          );
          when(
            () => api.generateRecoveryToken(null, null),
          ).thenAnswer((_) async => result);
          if (outcome == ServerMutationOutcome.confirmed &&
              secret == 'fixture-secret') {
            expect(await bloc.generateRecoveryKey(), secret);
            expect(hub.active!.recoveryKey.reader.store.isDue, isTrue);
          } else {
            final failureKey = switch (outcome) {
              ServerMutationOutcome.confirmed =>
                'server_mutation.payload_unavailable',
              ServerMutationOutcome.rejected => 'server_mutation.rejected',
              ServerMutationOutcome.indeterminate =>
                'server_mutation.outcome_unknown',
            };
            final message = failureKey.tr();
            expect(message, isNot(failureKey));
            await expectLater(
              bloc.generateRecoveryKey(),
              throwsA(
                isA<GenerationError>().having(
                  (final error) => error.message,
                  'message',
                  message,
                ),
              ),
            );
          }
        });
      });
    }
  }
}
