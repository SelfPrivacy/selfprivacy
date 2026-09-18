import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

import '../../helpers/widget_harness.dart';

void main() {
  setUpAll(setUpWidgetTestHarness);
  for (final outcome in ServerMutationOutcome.values) {
    for (final secret in ['', '  ', 'SECRET_SENTINEL']) {
      testWidgets('secret feedback: $outcome / length=${secret.length}', (
        final tester,
      ) async {
        await pumpForTest(tester, const SizedBox.shrink());
        final result = ServerMutationResult<String>(
          outcome: outcome,
          payload: ServerMutationPayload.available(secret),
          message: 'SECRET_SENTINEL',
        );
        final key = switch (outcome) {
          ServerMutationOutcome.confirmed =>
            secret.trim().isEmpty
                ? 'server_mutation.payload_unavailable'
                : 'basis.done',
          ServerMutationOutcome.rejected => 'server_mutation.rejected',
          ServerMutationOutcome.indeterminate =>
            'server_mutation.outcome_unknown',
        };
        final message = serverMutationMessage(result, sensitive: true);
        expect(message, key.tr());
        expect(message, isNot(contains('SECRET_SENTINEL')));
        expect(key.tr(), isNot(key));
      });
    }
  }
  for (final outcome in ServerMutationOutcome.values) {
    for (final sensitive in [true, false]) {
      for (final message in [null, '', '  ', 'server message']) {
        testWidgets('$outcome / sensitive=$sensitive / message=$message', (
          final tester,
        ) async {
          await pumpForTest(tester, const SizedBox.shrink());
          final result = ServerMutationResult<void>(
            outcome: outcome,
            payload: const ServerMutationPayload.notExpected(),
            message: message,
          );
          final key = switch (outcome) {
            ServerMutationOutcome.confirmed => 'basis.done',
            ServerMutationOutcome.rejected => 'server_mutation.rejected',
            ServerMutationOutcome.indeterminate =>
              'server_mutation.outcome_unknown',
          };
          final useMessage =
              !sensitive &&
              outcome != ServerMutationOutcome.indeterminate &&
              message == 'server message';
          expect(
            serverMutationMessage(result, sensitive: sensitive),
            useMessage ? message : key.tr(),
          );
          expect(key.tr(), isNot(key));
        });
      }
    }
  }
  for (final payload in [
    const ServerMutationPayload<String>.missing(),
    const ServerMutationPayload<String>.unreadable(),
  ]) {
    testWidgets('confirmed unavailable payload: ${payload.status}', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      final result = ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: payload,
        message: 'ignored',
      );
      expect(
        serverMutationMessage(result),
        'server_mutation.payload_unavailable'.tr(),
      );
    });
  }
}
