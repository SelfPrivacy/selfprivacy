import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import '../../../fakes/graphql/link_transport.dart';
import '../../../helpers/fixtures/json_fixture.dart';

void main() {
  final calls =
      <String, Future<ServerMutationResult<ServerJob>> Function(ServerApi)>{
        'RunSystemRebuild': (final api) => api.apply(),
        'RunSystemUpgrade': (final api) => api.upgrade(),
      };
  for (final call in calls.entries) {
    group(call.key, () {
      late Map<String, dynamic> error;
      late Map<String, dynamic> fallback;
      late List<Request> requests;
      late ServerApi api;
      Map<String, dynamic>? executionData;
      var transportFailure = false;
      var fallbackFailure = false;
      var extraError = false;
      setUp(() {
        error = loadJsonFixture('graphql/legacy_job_field_error.json');
        fallback =
            loadJsonFixture(
                  'graphql/mutation_results.json',
                )['${call.key}Fallback']
                as Map<String, dynamic>;
        requests = [];
        executionData = null;
        transportFailure = false;
        fallbackFailure = false;
        extraError = false;
        api = ServerApi(
          transport: transportWithLink(
            Link.function((final request, [final forward]) {
              requests.add(request);
              if (requests.length == 1) {
                if (transportFailure) {
                  return Stream.error(StateError('lost response'));
                }
                return Stream.value(
                  Response(
                    response: const {},
                    data: executionData,
                    errors: [
                      GraphQLError(
                        message: error['message'] as String,
                        path: error['path'] as List<dynamic>?,
                        extensions:
                            error['extensions'] as Map<String, dynamic>?,
                      ),
                      if (extraError)
                        const GraphQLError(message: 'unrelated error'),
                    ],
                  ),
                );
              }
              if (fallbackFailure) {
                return Stream.error(StateError('fallback response lost'));
              }
              return Stream.value(Response(response: const {}, data: fallback));
            }),
          ),
        );
      });

      for (final code in [null, 'GRAPHQL_VALIDATION_FAILED']) {
        test(
          'legacy missing-job validation rejection permits one fallback: $code',
          () async {
            if (code != null) {
              error['extensions'] = {'code': code};
            }
            final result = await call.value(api);
            expect(result.outcome, ServerMutationOutcome.confirmed);
            expect(
              result.payload.status,
              ServerMutationPayloadStatus.notExpected,
            );
            expect(requests, hasLength(2));
            expect(
              requests.last.operation.document,
              isNot(requests.first.operation.document),
            );
            expect(api.transport.client().cache.store.toMap(), isEmpty);
          },
        );
      }
      test('supports double-quoted validation wording', () async {
        error['message'] =
            'Cannot query field "job" on type "GenericMutationReturn".';
        expect(
          (await call.value(api)).outcome,
          ServerMutationOutcome.confirmed,
        );
        expect(requests, hasLength(2));
      });
      test('fallback rejection stays rejected', () async {
        fallback.values
                .whereType<Map<String, dynamic>>()
                .single
                .values
                .whereType<Map<String, dynamic>>()
                .single['success'] =
            false;
        expect((await call.value(api)).outcome, ServerMutationOutcome.rejected);
        expect(requests, hasLength(2));
      });
      test('uncertain fallback is not retried again', () async {
        fallbackFailure = true;
        expect(
          (await call.value(api)).outcome,
          ServerMutationOutcome.indeterminate,
        );
        expect(requests, hasLength(2));
      });
      test('transport failure never triggers fallback', () async {
        transportFailure = true;
        expect(
          (await call.value(api)).outcome,
          ServerMutationOutcome.indeterminate,
        );
        expect(requests, hasLength(1));
      });
      test(
        'execution data prevents fallback despite matching validation text',
        () async {
          executionData =
              loadJsonFixture('graphql/mutation_results.json')[call.key]
                  as Map<String, dynamic>;
          expect(
            (await call.value(api)).outcome,
            ServerMutationOutcome.confirmed,
          );
          expect(requests, hasLength(1));
        },
      );
      test('malformed execution data prevents fallback', () async {
        executionData = {};
        expect(
          (await call.value(api)).outcome,
          ServerMutationOutcome.indeterminate,
        );
        expect(requests, hasLength(1));
      });
      test('an execution path prevents fallback', () async {
        error['path'] = ['system'];
        expect(
          (await call.value(api)).outcome,
          ServerMutationOutcome.indeterminate,
        );
        expect(requests, hasLength(1));
      });
      test('unrelated errors prevent fallback', () async {
        extraError = true;
        expect(
          (await call.value(api)).outcome,
          ServerMutationOutcome.indeterminate,
        );
        expect(requests, hasLength(1));
      });
      for (final code in [
        'UNAUTHENTICATED',
        'GRAPHQL_PARSE_FAILED',
        'INTERNAL_SERVER_ERROR',
      ]) {
        test('$code prevents fallback', () async {
          error['extensions'] = {'code': code};
          await call.value(api);
          expect(requests, hasLength(1));
        });
      }
      for (final message in [
        "Cannot query field 'other' on type 'GenericMutationReturn'.",
        "Cannot query field 'job' on type 'OtherType'.",
        'execution failed',
      ]) {
        test('other failure does not trigger fallback: $message', () async {
          error['message'] = message;
          error['extensions'] = {'code': 'GRAPHQL_VALIDATION_FAILED'};
          expect(
            (await call.value(api)).outcome,
            ServerMutationOutcome.rejected,
          );
          expect(requests, hasLength(1));
        });
      }
    });
  }
}
