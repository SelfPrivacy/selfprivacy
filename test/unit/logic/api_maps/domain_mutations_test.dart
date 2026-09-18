import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';

import '../../../fakes/graphql/link_transport.dart';
import '../../../helpers/fixtures/json_fixture.dart';

void main() {
  final calls = <String, Future<ServerMutationResult> Function(ServerApi)>{
    'RebootSystem': (final api) => api.reboot(),
    'PullRepositoryChanges': (final api) => api.pullConfigurationUpdate(),
    'RunSystemRebuild': (final api) => api.apply(),
    'RunSystemUpgrade': (final api) => api.upgrade(),
    'NixCollectGarbage': (final api) => api.collectNixGarbage(),
    'MountVolume': (final api) => api.mountVolume('sdb'),
    'UnmountVolume': (final api) => api.unmountVolume('sdb'),
    'ResizeVolume': (final api) => api.resizeVolume('sdb'),
    'MigrateToBinds': (final api) =>
        api.migrateToBinds({'gitea': 'sdb'}, 'sda1'),
    'CreateUser': (final api) =>
        api.createUser('bob', 'Bob', ['sp.full_users']),
    'UpdateUser': (final api) =>
        api.updateUser('bob', 'Robert', ['sp.full_users']),
    'DeleteUser': (final api) => api.deleteUser('bob'),
    'AddSshKey': (final api) => api.addSshKey('bob', 'fixture-key'),
    'RemoveSshKey': (final api) => api.removeSshKey('bob', 'fixture-key'),
    'DeleteEmailPassword': (final api) =>
        api.deleteEmailPassword('bob', 'password-id'),
    'ChangeTimezone': (final api) => api.setTimezone('Europe/Moscow'),
    'ChangeAutoUpgradeSettings': (final api) => api.setAutoUpgradeSettings(
      AutoUpgradeSettings(enable: true, allowReboot: true),
    ),
    'ChangeSshSettings': (final api) =>
        api.setSshSettings(SshSettings(enable: true)),
    'EnableService': (final api) => api.enableService('outline'),
    'DisableService': (final api) => api.disableService('outline'),
    'StartService': (final api) => api.startService('outline'),
    'StopService': (final api) => api.stopService('outline'),
    'RestartService': (final api) => api.restartService('outline'),
    'MoveService': (final api) => api.moveService('outline', 'sdb'),
    'SetServiceConfiguration': (final api) =>
        api.setServiceConfiguration('outline', {'fixture-setting': true}),
    'RemoveJob': (final api) => api.removeApiJob('job-1'),
  };
  for (final call in calls.entries) {
    group(call.key, () {
      late Map<String, dynamic> data;
      late Map<String, dynamic> mutation;
      late String? payloadField;
      late List<Request> requests;
      late ServerApi api;
      var lostResponse = false;
      var missingResponse = false;
      var withErrors = false;
      setUp(() {
        data =
            loadJsonFixture('graphql/mutation_results.json')[call.key]
                as Map<String, dynamic>;
        mutation = data.values
            .whereType<Map<String, dynamic>>()
            .single
            .values
            .whereType<Map<String, dynamic>>()
            .single;
        payloadField = [
          'user',
          'job',
          'timezone',
          'enableAutoUpgrade',
          'enable',
        ].where(mutation.containsKey).firstOrNull;
        requests = [];
        lostResponse = false;
        missingResponse = false;
        withErrors = false;
        api = ServerApi(
          transport: transportWithLink(
            Link.function((final request, [final forward]) {
              requests.add(request);
              return lostResponse
                  ? Stream.error(StateError('lost response'))
                  : Stream.value(
                      Response(
                        response: const {},
                        data: missingResponse ? null : data,
                        errors: withErrors
                            ? const [
                                GraphQLError(
                                  message: 'other failure',
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
        'decodes confirmation and returned payload without cache writes',
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
          switch (result.payload.value) {
            case final User user:
              expect(
                user.login,
                (mutation['user'] as Map<String, dynamic>)['username'],
              );
              expect(
                user.displayName,
                (mutation['user'] as Map<String, dynamic>)['displayName'],
              );
              expect(
                user.sshKeys,
                (mutation['user'] as Map<String, dynamic>)['sshKeys'],
              );
            case final ServerJob job:
              expect(job.uid, (mutation['job'] as Map<String, dynamic>)['uid']);
              expect(
                job.typeId,
                (mutation['job'] as Map<String, dynamic>)['typeId'],
              );
            case final AutoUpgradeSettings settings:
              expect(settings.enable, mutation['enableAutoUpgrade']);
              expect(settings.allowReboot, mutation['allowReboot']);
            case final SshSettings settings:
              expect(settings.enable, mutation['enable']);
            case final String timezone:
              expect(timezone, mutation['timezone']);
          }
          expect(requests, hasLength(1));
          expect(api.transport.client().cache.store.toMap(), isEmpty);
          if (call.key == 'SetServiceConfiguration') {
            expect(
              requests.single.context.entry<SensitiveGraphQLRequest>(),
              isNotNull,
            );
          }
        },
      );
      test('preserves rejection even with a usable payload', () async {
        mutation['success'] = false;
        mutation['code'] = 409;
        final result = await call.value(api);
        expect(result.outcome, ServerMutationOutcome.rejected);
        expect(result.code, 409);
        if (payloadField != null) {
          expect(result.payload.value, isNotNull);
        }
      });
      test(
        'preserves confirmation alongside unrelated GraphQL errors',
        () async {
          withErrors = true;
          final result = await call.value(api);
          expect(result.outcome, ServerMutationOutcome.confirmed);
          expect(
            result.diagnostics,
            contains(ServerMutationDiagnostic.graphql),
          );
        },
      );
      test('malformed acknowledgement is indeterminate', () async {
        mutation['success'] = 'yes';
        expect(
          (await call.value(api)).outcome,
          ServerMutationOutcome.indeterminate,
        );
      });
      test('missing response is indeterminate', () async {
        missingResponse = true;
        expect(
          (await call.value(api)).outcome,
          ServerMutationOutcome.indeterminate,
        );
      });
      test('transport failure is indeterminate and never replayed', () async {
        lostResponse = true;
        final result = await call.value(api);
        expect(result.outcome, ServerMutationOutcome.indeterminate);
        expect(
          result.diagnostics,
          contains(ServerMutationDiagnostic.transport),
        );
        expect(requests, hasLength(1));
      });
      if ([
        'CreateUser',
        'UpdateUser',
        'AddSshKey',
        'RemoveSshKey',
        'MoveService',
        'ChangeTimezone',
        'RunSystemRebuild',
        'RunSystemUpgrade',
        'NixCollectGarbage',
        'MigrateToBinds',
      ].contains(call.key)) {
        test('nullable missing payload retains confirmation', () async {
          mutation[payloadField!] = null;
          final result = await call.value(api);
          expect(result.outcome, ServerMutationOutcome.confirmed);
          expect(result.payload.status, ServerMutationPayloadStatus.missing);
        });
        test('malformed payload is indeterminate', () async {
          mutation[payloadField!] = 42;
          final result = await call.value(api);
          expect(result.outcome, ServerMutationOutcome.indeterminate);
          expect(result.payload.status, ServerMutationPayloadStatus.unreadable);
        });
      }
      if ([
        'ChangeAutoUpgradeSettings',
        'ChangeSshSettings',
      ].contains(call.key)) {
        test('missing required settings are indeterminate', () async {
          mutation[payloadField!] = null;
          expect(
            (await call.value(api)).outcome,
            ServerMutationOutcome.indeterminate,
          );
        });
      }
      if ([
        'MoveService',
        'RunSystemRebuild',
        'RunSystemUpgrade',
        'NixCollectGarbage',
        'MigrateToBinds',
      ].contains(call.key)) {
        test('unknown job status is indeterminate', () async {
          (mutation['job'] as Map<String, dynamic>)['status'] = 'UNKNOWN';
          expect(
            (await call.value(api)).outcome,
            ServerMutationOutcome.indeterminate,
          );
        });
      }
    });
  }

  for (final enable in [true, false]) {
    test(
      'switchService delegates to the typed ${enable ? "enable" : "disable"} operation',
      () async {
        final operation = enable ? 'EnableService' : 'DisableService';
        final requests = <Request>[];
        final api = ServerApi(
          transport: transportWithLink(
            Link.function((final request, [final forward]) {
              requests.add(request);
              return Stream.value(
                Response(
                  response: const {},
                  data:
                      loadJsonFixture(
                            'graphql/mutation_results.json',
                          )[operation]
                          as Map<String, dynamic>,
                ),
              );
            }),
          ),
        );
        expect(
          (await api.switchService(
            serviceId: 'outline',
            needTurnOn: enable,
          )).outcome,
          ServerMutationOutcome.confirmed,
        );
        expect(requests.single.variables['serviceId'], 'outline');
      },
    );
  }
}
