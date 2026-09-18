import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import '../../../fakes/graphql/link_transport.dart';
import '../../../helpers/fixtures/backup_fixtures.dart';
import '../../../helpers/fixtures/json_fixture.dart';

void main() {
  final calls = <String, Future<ServerMutationResult> Function(ServerApi)>{
    'ForceSnapshotsReload': (final api) => api.forceBackupListReload(),
    'ForgetSnapshot': (final api) => api.forgetSnapshot('snapshot-1'),
    'StartBackup': (final api) => api.startBackup('outline'),
    'RestoreBackup': (final api) => api.restoreBackup(
      'snapshot-1',
      BackupRestoreStrategy.downloadVerifyOverwrite,
    ),
    'SetAutobackupPeriod': (final api) => api.setAutobackupPeriod(period: 15),
    'setAutobackupQuotas': (final api) =>
        api.setAutobackupQuotas(aBackupConfiguration().autobackupQuotas),
    'RemoveRepository': (final api) => api.removeRepository(),
    'InitializeRepository': (final api) => api.initializeRepository(
      InitializeRepositoryInput(
        provider: BackupsProviderType.backblaze,
        locationId: 'bucket-id',
        locationName: 'Backups',
        login: 'fixture-login',
        password: 'fixture-password',
      ),
    ),
  };

  for (final call in calls.entries) {
    group(call.key, () {
      late Map<String, dynamic> data;
      late Map<String, dynamic> mutation;
      late String? payloadField;
      late List<Request> requests;
      late ServerApi api;
      var transportFailure = false;
      var withoutData = false;
      var withErrors = false;

      setUp(() {
        data =
            loadJsonFixture('graphql/mutation_results.json')[call.key]
                as Map<String, dynamic>;
        mutation = (data['backup'] as Map<String, dynamic>).values
            .whereType<Map<String, dynamic>>()
            .single;
        payloadField = mutation.containsKey('configuration')
            ? 'configuration'
            : mutation.containsKey('job')
            ? 'job'
            : null;
        requests = [];
        transportFailure = false;
        withoutData = false;
        withErrors = false;
        api = ServerApi(
          transport: transportWithLink(
            Link.function((final request, [final forward]) {
              requests.add(request);
              return transportFailure
                  ? Stream.error(StateError('connection lost'))
                  : Stream.value(
                      Response(
                        response: const {},
                        data: withoutData ? null : data,
                        errors: withErrors
                            ? const [
                                GraphQLError(
                                  message: 'unrelated field failed',
                                  path: ['other'],
                                ),
                              ]
                            : null,
                      ),
                    );
            }),
          ),
        );
      });

      test(
        'preserves confirmation and typed payload without cache writes',
        () async {
          final result = await call.value(api);
          expect(result.outcome, ServerMutationOutcome.confirmed);
          expect(result.code, 200);
          expect(
            result.payload.status,
            payloadField == null
                ? ServerMutationPayloadStatus.notExpected
                : ServerMutationPayloadStatus.available,
          );
          if (payloadField == 'configuration') {
            final config = result.payload.value as BackupConfiguration;
            final expected = mutation['configuration'] as Map<String, dynamic>;
            expect(config.encryptionKey, expected['encryptionKey']);
            expect(
              config.autobackupPeriod?.inMinutes,
              expected['autobackupPeriod'],
            );
            expect(config.isInitialized, expected['isInitialized']);
            expect(config.locationId, expected['locationId']);
            expect(config.locationName, expected['locationName']);
            expect(
              config.autobackupQuotas,
              aBackupConfiguration().autobackupQuotas,
            );
            expect(
              requests.single.context.entry<SensitiveGraphQLRequest>(),
              isNotNull,
            );
            expect(result.toString(), isNot(contains(config.encryptionKey)));
          } else if (payloadField == 'job') {
            final job = result.payload.value as ServerJob;
            expect(job.uid, (mutation['job'] as Map<String, dynamic>)['uid']);
          }
          expect(requests, hasLength(1));
          final variables = requests.single.variables;
          switch (call.key) {
            case 'StartBackup':
              expect(variables['serviceId'], 'outline');
            case 'RestoreBackup':
              expect(variables['snapshotId'], 'snapshot-1');
              expect(variables['strategy'], 'DOWNLOAD_VERIFY_OVERWRITE');
            case 'ForgetSnapshot':
              expect(variables['snapshotId'], 'snapshot-1');
            case 'SetAutobackupPeriod':
              expect(variables['period'], 15);
            case 'setAutobackupQuotas':
              expect(variables['quotas'], {
                'last': 3,
                'daily': 7,
                'weekly': 4,
                'monthly': 12,
                'yearly': 1,
              });
            case 'InitializeRepository':
              expect(variables['repository'], {
                'provider': 'BACKBLAZE',
                'locationId': 'bucket-id',
                'locationName': 'Backups',
                'login': 'fixture-login',
                'password': 'fixture-password',
              });
            default:
              expect(variables, isEmpty);
          }
          expect(api.transport.client().cache.store.toMap(), isEmpty);
        },
      );

      test('preserves rejection even when data is returned', () async {
        mutation['success'] = false;
        mutation['code'] = 409;
        final result = await call.value(api);
        expect(result.outcome, ServerMutationOutcome.rejected);
        expect(result.code, 409);
        if (payloadField != null) {
          expect(result.payload.value, isNotNull);
        }
      });

      test('keeps acknowledgement alongside GraphQL errors', () async {
        withErrors = true;
        final result = await call.value(api);
        expect(result.outcome, ServerMutationOutcome.confirmed);
        expect(result.diagnostics, contains(ServerMutationDiagnostic.graphql));
      });

      test('malformed acknowledgement is indeterminate', () async {
        mutation['success'] = 'yes';
        expect(
          (await call.value(api)).outcome,
          ServerMutationOutcome.indeterminate,
        );
      });

      test('missing response is indeterminate', () async {
        withoutData = true;
        expect(
          (await call.value(api)).outcome,
          ServerMutationOutcome.indeterminate,
        );
      });

      test('lost response is indeterminate and never replayed', () async {
        transportFailure = true;
        final result = await call.value(api);
        expect(result.outcome, ServerMutationOutcome.indeterminate);
        expect(
          result.diagnostics,
          contains(ServerMutationDiagnostic.transport),
        );
        expect(requests, hasLength(1));
      });

      if (!['ForceSnapshotsReload', 'ForgetSnapshot'].contains(call.key)) {
        test('nullable missing payload keeps confirmation', () async {
          mutation[payloadField!] = null;
          final result = await call.value(api);
          expect(result.outcome, ServerMutationOutcome.confirmed);
          expect(result.payload.status, ServerMutationPayloadStatus.missing);
        });

        test('malformed payload is indeterminate', () async {
          mutation[payloadField!] = {'invalid': true};
          final result = await call.value(api);
          expect(result.outcome, ServerMutationOutcome.indeterminate);
          expect(result.payload.status, ServerMutationPayloadStatus.unreadable);
        });
      }

      if (['StartBackup', 'RestoreBackup'].contains(call.key)) {
        test('unknown job status is an unreadable payload', () async {
          (mutation['job'] as Map<String, dynamic>)['status'] = 'UNRECOGNIZED';
          expect(
            (await call.value(api)).outcome,
            ServerMutationOutcome.indeterminate,
          );
        });
      }

      if ([
        'SetAutobackupPeriod',
        'setAutobackupQuotas',
        'RemoveRepository',
        'InitializeRepository',
      ].contains(call.key)) {
        test('nullable configuration fields stay null', () async {
          final config = mutation['configuration'] as Map<String, dynamic>;
          config['autobackupPeriod'] = null;
          config['locationId'] = null;
          config['locationName'] = null;
          final result = await call.value(api);
          expect(result.outcome, ServerMutationOutcome.confirmed);
          final mapped = result.payload.value as BackupConfiguration;
          expect(mapped.autobackupPeriod, isNull);
          expect(mapped.locationId, isNull);
          expect(mapped.locationName, isNull);
        });
      }
    });
  }
}
