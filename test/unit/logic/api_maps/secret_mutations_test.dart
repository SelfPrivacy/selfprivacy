import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/models/console_log.dart';
import 'package:selfprivacy/logic/models/json/device_token.dart';

import '../../../helpers/fixtures/json_fixture.dart';

class _TlsContext extends Mock implements TlsContext {}

void main() {
  setUpAll(() => registerFallbackValue(TlsPolicy.strict));

  final operations =
      <String, Future<ServerMutationResult<String>> Function(ServerApi)>{
        'GetNewRecoveryApiKey': (final api) =>
            api.generateRecoveryToken(DateTime.utc(2027), 3),
        'GetNewDeviceApiKey': (final api) => api.createDeviceToken(),
        'AuthorizeWithNewDeviceApiKey': (final api) => api.authorizeDevice(
          DeviceToken(device: 'Laptop', token: 'input-secret'),
        ),
        'UseRecoveryApiKey': (final api) => api.useRecoveryToken(
          DeviceToken(device: 'Laptop', token: 'input-secret'),
        ),
        'RefreshDeviceApiToken': (final api) => api.refreshDeviceApiToken(),
        'GeneratePasswordResetLink': (final api) =>
            api.generatePasswordResetLink('alex'),
      };

  for (final operation in operations.entries) {
    group(operation.key, () {
      late Map<String, dynamic> data;
      late Map<String, dynamic> mutation;
      late String field;
      late List<ConsoleLog> logs;
      late List<http.Request> requests;
      late ServerApi api;
      var transportFailure = false;
      var withoutData = false;
      var withErrors = false;

      setUp(() {
        data =
            loadJsonFixture('graphql/mutation_results.json')[operation.key]
                as Map<String, dynamic>;
        final domain =
            data[operation.key == 'GeneratePasswordResetLink' ? 'users' : 'api']
                as Map<String, dynamic>;
        mutation = domain.values.whereType<Map<String, dynamic>>().single;
        field = mutation.containsKey('key')
            ? 'key'
            : mutation.containsKey('token')
            ? 'token'
            : 'passwordResetLink';
        logs = [];
        requests = [];
        transportFailure = false;
        withoutData = false;
        withErrors = false;
        final tls = _TlsContext();
        when(
          () => tls.clientFor(
            host: any(named: 'host'),
            policy: any(named: 'policy'),
          ),
        ).thenReturn(
          MockClient((final request) async {
            requests.add(request);
            if (transportFailure) {
              throw http.ClientException('input-secret fixture-secret');
            }
            return http.Response(
              jsonEncode({
                'data': withoutData ? null : data,
                if (withErrors)
                  'errors': [
                    {
                      'message': 'fixture-secret input-secret',
                      'path': ['otherField'],
                    },
                  ],
              }),
              200,
              headers: {'content-type': 'application/json'},
            );
          }),
        );
        api = ServerApi(
          transport: GraphQLTransport(
            domainProvider: () => 'example.test',
            localeProvider: () => 'en',
            tlsContext: tls,
            consoleLog: logs.add,
          ),
        );
      });

      void expectSafe(final ServerMutationResult<String> result) {
        expect(requests, hasLength(1));
        expect(logs, hasLength(2));
        for (final log in logs) {
          expect(log, isNot(isA<LogWithRawResponse>()));
          for (final text in [
            log.title,
            log.content,
            log.shareableData,
            result.toString(),
          ]) {
            expect(text, isNot(contains('fixture-secret')));
            expect(text, isNot(contains('input-secret')));
            expect(text, isNot(contains('abcd-0123-abcd-0123')));
          }
          expect(log.content, contains(operation.key));
          expect(log.content, isNot(contains('document')));
          expect(log.content, isNot(contains('variables')));
        }
      }

      test('returns confirmed secret without logging it', () async {
        final result = await operation.value(api);
        expect(result.outcome, ServerMutationOutcome.confirmed);
        expect(result.confirmedSecret, mutation[field]);
        expectSafe(result);
      });

      test(
        'preserves typed data alongside safely logged GraphQL errors',
        () async {
          withErrors = true;
          final result = await operation.value(api);
          expect(result.confirmedSecret, mutation[field]);
          expect(
            result.diagnostics,
            contains(ServerMutationDiagnostic.graphql),
          );
          expectSafe(result);
        },
      );

      test('does not expose a rejected secret to callers', () async {
        mutation['success'] = false;
        mutation['message'] = 'fixture-secret';
        final result = await operation.value(api);
        expect(result.outcome, ServerMutationOutcome.rejected);
        expect(result.confirmedSecret, isNull);
        expect(result.secretFailureKey, 'server_mutation.rejected');
        expectSafe(result);
      });

      for (final value in [null, '', '   ']) {
        test('treats secret "$value" as unavailable', () async {
          mutation[field] = value;
          final result = await operation.value(api);
          expect(result.outcome, ServerMutationOutcome.confirmed);
          expect(result.payload.status, ServerMutationPayloadStatus.missing);
          expect(result.confirmedSecret, isNull);
          expect(
            result.secretFailureKey,
            'server_mutation.payload_unavailable',
          );
          expectSafe(result);
        });
      }

      test('treats an omitted secret as unavailable', () async {
        mutation.remove(field);
        final result = await operation.value(api);
        expect(result.outcome, ServerMutationOutcome.confirmed);
        expect(result.confirmedSecret, isNull);
        expectSafe(result);
      });

      test('treats malformed typed data as indeterminate', () async {
        mutation[field] = 42;
        final result = await operation.value(api);
        expect(result.outcome, ServerMutationOutcome.indeterminate);
        expect(result.confirmedSecret, isNull);
        expect(result.secretFailureKey, 'server_mutation.outcome_unknown');
        expectSafe(result);
      });

      test('treats absent response data as indeterminate', () async {
        withoutData = true;
        final result = await operation.value(api);
        expect(result.outcome, ServerMutationOutcome.indeterminate);
        expectSafe(result);
      });

      test('does not log or replay a transport failure', () async {
        transportFailure = true;
        final result = await operation.value(api);
        expect(result.outcome, ServerMutationOutcome.indeterminate);
        expect(
          result.diagnostics,
          contains(ServerMutationDiagnostic.transport),
        );
        expectSafe(result);
      });
    });
  }
}
