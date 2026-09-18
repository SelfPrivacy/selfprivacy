import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/recovery_key/recovery_key_bloc.dart';

import '../../../../helpers/widget_harness.dart';

class _Repository extends Mock implements ApiConnectionRepository {}

class _Api extends Mock implements ServerApi {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late _Repository repository;
  late _Api api;
  late ApiData data;
  late RecoveryKeyBloc bloc;

  setUp(() {
    repository = _Repository();
    api = _Api();
    data = ApiData(api);
    when(() => repository.api).thenReturn(api);
    when(() => repository.apiData).thenReturn(data);
    when(() => repository.dataStream).thenAnswer((_) => const Stream.empty());
    when(() => repository.reload(null)).thenAnswer((_) async {});
    getIt.registerSingleton<ApiConnectionRepository>(repository);
    bloc = RecoveryKeyBloc();
  });

  tearDown(() async {
    await bloc.close();
    await getIt.reset();
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
            expect(data.recoveryKeyStatus.isExpired, isTrue);
            verify(() => repository.reload(null)).called(1);
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
            verifyNever(() => repository.reload(null));
          }
        });
      });
    }
  }
}
