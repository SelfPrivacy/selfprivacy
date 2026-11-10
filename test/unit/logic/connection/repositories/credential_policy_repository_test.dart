import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/credential_policy.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/operations/configuration/apply_changes_operation.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../../fakes/graphql/link_transport.dart';
import '../../../../helpers/connection_fixture.dart';
import '../../../../helpers/fixtures/json_fixture.dart';

void main() {
  late ServerConnection connection;
  late Map<String, dynamic> responses;
  late List<String> calls;
  var attached = true;
  String? failure;

  setUp(() {
    attached = true;
    failure = null;
    calls = [];
    responses = {
      ...loadJsonFixture('graphql/domain_reads.json'),
      ...loadJsonFixture('graphql/credential_policy.json'),
    };
    connection = ServerConnection(
      serverId: 'server',
      isAttached: () => attached,
      api: ServerApi(
        transport: transportWithLink(
          Link.function((final request, [final forward]) {
            final name = request.operation.document.definitions
                .whereType<OperationDefinitionNode>()
                .single
                .name!
                .value;
            calls.add(name);
            if (name == 'GetCredentialPolicy' && failure == 'policyRead') {
              return Stream.error(StateError('offline'));
            }
            if (name == 'SetCredentialPolicy') {
              expect(request.variables, {'policy': 'mfa'});
              if (failure == 'transport') {
                return Stream.error(StateError('offline'));
              }
            }
            return Stream.value(
              Response(
                response: const {},
                data: responses[name] as Map<String, dynamic>,
              ),
            );
          }),
        ),
      ),
    )..cache.setVersion(Version(3, 9, 0));
  });
  tearDown(() => connection.dispose());

  test(
    'policy read failure does not prevent loading system settings',
    () async {
      failure = 'policyRead';
      await Future.wait([
        connection.settings.refresh(force: true),
        connection.credentialPolicy.refresh(force: true),
      ]);
      expect(connection.settings.value.data!.timezone, 'Europe/Berlin');
      expect(connection.settings.value.lastError, isNull);
      expect(connection.credentialPolicy.value.lastError, isNotNull);
      expect(calls, unorderedEquals(['SystemSettings', 'GetCredentialPolicy']));
    },
  );

  test(
    'older API loads settings without requesting credential policy',
    () async {
      connection.cache.setVersion(Version(3, 8, 9));
      await Future.wait([
        connection.settings.refresh(force: true),
        connection.credentialPolicy.refresh(force: true),
      ]);
      expect(connection.settings.value.data!.timezone, 'Europe/Berlin');
      expect(
        connection.credentialPolicy.value.support,
        DomainSupport.unsupported,
      );
      expect(calls, ['SystemSettings']);
    },
  );

  test('queuing replaces the policy only and does not send a mutation', () {
    connection.cache.credentialPolicy.push(CredentialPolicy.any);
    final timezone = ChangeServerTimezoneJob(timezone: 'UTC');
    connection.changeDraft.add(timezone);
    connection.credentialPolicy
      ..stageChange(ChangeCredentialPolicyJob(policy: CredentialPolicy.passkey))
      ..stageChange(ChangeCredentialPolicyJob(policy: CredentialPolicy.mfa));
    final queued =
        connection.changeDraft.value.last as ChangeCredentialPolicyJob;
    expect(connection.changeDraft.value, [timezone, queued]);
    expect(queued.policy, CredentialPolicy.mfa);
    expect(queued.requiresRebuild, false);
    expect(queued.requiresDnsUpdate, false);
    expect(calls, isEmpty);
    expect(connection.credentialPolicy.value.data, CredentialPolicy.any);
    connection.credentialPolicy.stageChange(
      ChangeCredentialPolicyJob(policy: CredentialPolicy.any),
    );
    expect(connection.changeDraft.value, [timezone]);
  });

  test(
    'only an authoritative read reconciles a matching queued policy',
    () async {
      final policy = ChangeCredentialPolicyJob(policy: CredentialPolicy.mfa);
      connection.cache.credentialPolicy.push(CredentialPolicy.any);
      connection.credentialPolicy.stageChange(policy);
      final read = responses['GetCredentialPolicy'] as Map<String, dynamic>;
      (read['users'] as Map<String, dynamic>)['minimumCredentialType'] = 'mfa';
      await connection.credentialPolicy.refresh(force: true);
      await pumpEventQueue();
      expect(connection.changeDraft.value, isEmpty);
      expect(calls, ['GetCredentialPolicy']);
    },
  );

  test(
    'unsupported, detached and unknown policies cannot enter the queue',
    () async {
      connection.cache.credentialPolicy.push(CredentialPolicy.any);
      expect(
        connection.credentialPolicy.stageChange(
          ChangeCredentialPolicyJob(policy: CredentialPolicy.unknown),
        ),
        false,
      );
      connection.cache.setVersion(Version(3, 8, 9));
      await connection.credentialPolicy.refresh();
      await connection.credentialPolicy.setPolicy(CredentialPolicy.mfa);
      expect(
        connection.credentialPolicy.stageChange(
          ChangeCredentialPolicyJob(policy: CredentialPolicy.mfa),
        ),
        false,
      );
      connection.cache.setVersion(Version(3, 9, 0));
      attached = false;
      await connection.credentialPolicy.setPolicy(CredentialPolicy.mfa);
      expect(
        connection.credentialPolicy.stageChange(
          ChangeCredentialPolicyJob(policy: CredentialPolicy.mfa),
        ),
        false,
      );
      expect(connection.changeDraft.value, isEmpty);
      expect(calls, isEmpty);
    },
  );

  for (final scenario in [
    'confirmed',
    'rejected',
    'missing',
    'malformed',
    'transport',
  ]) {
    test(
      '$scenario mutation updates only confirmed returned policy without rebuild or replay',
      () async {
        await connection.settings.refresh();
        final settings = connection.settings.value;
        await connection.credentialPolicy.refresh();
        final result =
            ((responses['SetCredentialPolicy'] as Map<String, dynamic>)['users']
                    as Map<String, dynamic>)['setKanidmMinimumCredentialType']
                as Map<String, dynamic>;
        if (scenario == 'rejected') {
          result['success'] = false;
        }
        if (scenario == 'missing') {
          result['minimumCredentialType'] = null;
        }
        if (scenario == 'malformed') {
          result.remove('success');
        }
        failure = scenario;
        final progress = <ConfigurationProgress>[];
        await configurationOperation(connection).run([
          ChangeCredentialPolicyJob(policy: CredentialPolicy.mfa),
        ], onProgress: progress.add);
        expect(calls, [
          'SystemSettings',
          'GetCredentialPolicy',
          'SetCredentialPolicy',
        ]);
        expect(connection.settings.value, same(settings));
        expect(
          connection.credentialPolicy.value.data,
          scenario == 'confirmed' ? CredentialPolicy.mfa : CredentialPolicy.any,
        );
        expect(progress.last.status, switch (scenario) {
          'confirmed' => OperationStatus.succeeded,
          'rejected' => OperationStatus.rejected,
          'missing' => OperationStatus.unknown,
          _ => OperationStatus.unknown,
        });
        expect(
          progress.every(
            (final item) => item.stage == ConfigurationStage.change,
          ),
          true,
        );
      },
    );
  }

  test(
    'future policy is displayed as unknown rather than password-only',
    () async {
      final read = responses['GetCredentialPolicy'] as Map<String, dynamic>;
      (read['users'] as Map<String, dynamic>)['minimumCredentialType'] =
          'future_policy';
      await connection.credentialPolicy.refresh();
      expect(connection.credentialPolicy.value.data, CredentialPolicy.unknown);
      expect(
        () => connection.credentialPolicy.setPolicy(CredentialPolicy.unknown),
        throwsArgumentError,
      );
      expect(calls, ['GetCredentialPolicy']);
    },
  );
}
