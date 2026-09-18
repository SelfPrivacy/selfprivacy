import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/console_log.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';

import '../../../helpers/fixtures/json_fixture.dart';

class _TlsContext extends Mock implements TlsContext {}

class _Api extends ServerApi {
  _Api({required super.transport, required this.logs});

  final List<ConsoleLog> logs;

  @override
  void Function(String, {Object? error, StackTrace? stackTrace}) get logger =>
      (final message, {final error, final stackTrace}) =>
          logs.add(ManualConsoleLog(content: '$message $error $stackTrace'));
}

void main() {
  setUpAll(() => registerFallbackValue(TlsPolicy.strict));
  final operations = <String, Future<Object?> Function(ServerApi)>{
    'BackupConfiguration': (final api) => api.getBackupsConfiguration(),
    'AllServices': (final api) => api.getAllServices(),
    'SetAutobackupPeriod': (final api) => api.setAutobackupPeriod(period: 60),
    'setAutobackupQuotas': (final api) => api.setAutobackupQuotas(
      const AutobackupQuotas(
        last: 3,
        daily: 7,
        weekly: 4,
        monthly: 12,
        yearly: 1,
      ),
    ),
    'RemoveRepository': (final api) => api.removeRepository(),
    'InitializeRepository': (final api) => api.initializeRepository(
      InitializeRepositoryInput(
        provider: BackupsProviderType.backblaze,
        locationId: 'bucket',
        locationName: 'Backups',
        login: 'input-secret',
        password: 'input-secret',
      ),
    ),
    'SetServiceConfiguration': (final api) =>
        api.setServiceConfiguration('outline', {'password': 'input-secret'}),
  };

  for (final operation in operations.entries) {
    for (final failure in [null, 'graphql', 'transport', 'client']) {
      test('${operation.key} logging with $failure failure', () async {
        final logs = <ConsoleLog>[];
        final tls = _TlsContext();
        final reads = loadJsonFixture('graphql/domain_reads.json');
        final mutations = loadJsonFixture('graphql/mutation_results.json');
        final data =
            (reads[operation.key] ?? mutations[operation.key])
                as Map<String, dynamic>;
        data['unselectedSecret'] = 'response-secret';
        when(
          () => tls.clientFor(
            host: any(named: 'host'),
            policy: any(named: 'policy'),
          ),
        ).thenReturn(
          MockClient((final request) async {
            if (failure == 'transport') {
              throw http.ClientException('response-secret input-secret');
            }
            return http.Response(
              jsonEncode({
                'data': data,
                if (failure == 'graphql')
                  'errors': [
                    {
                      'message': 'response-secret input-secret',
                      'extensions': {'code': 'response-secret'},
                    },
                  ],
              }),
              200,
              headers: {'content-type': 'application/json'},
            );
          }),
        );
        if (failure == 'client') {
          when(
            () => tls.clientFor(
              host: any(named: 'host'),
              policy: any(named: 'policy'),
            ),
          ).thenThrow(StateError('input-secret response-secret'));
        }
        final api = _Api(
          logs: logs,
          transport: GraphQLTransport(
            domainProvider: () => 'example.test',
            localeProvider: () => 'en',
            tlsContext: tls,
            consoleLog: logs.add,
          ),
        );
        try {
          final result = await operation.value(api);
          if (failure == null && result is GenericResult) {
            expect(result.success, isTrue);
          }
          if (failure == null && result is ServerMutationResult) {
            expect(result.outcome, ServerMutationOutcome.confirmed);
          }
        } catch (_) {
          if (failure == null) {
            rethrow;
          }
        }
        if (failure != 'client') {
          expect(logs.length, greaterThanOrEqualTo(2));
          expect(logs.first.content, contains(operation.key));
        }
        for (final log in logs) {
          expect(log, isNot(isA<LogWithRawResponse>()));
          expect(log.content, isNot(contains('input-secret')));
          expect(log.content, isNot(contains('response-secret')));
          expect(log.shareableData, isNot(contains('input-secret')));
          expect(log.shareableData, isNot(contains('response-secret')));
        }
      });
    }
  }
}
