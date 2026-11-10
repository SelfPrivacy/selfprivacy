import 'package:flutter_test/flutter_test.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../../fakes/graphql/link_transport.dart';
import '../../../../helpers/connection_fixture.dart';
import '../../../../helpers/fixtures/json_fixture.dart';
import '../../../../helpers/fixtures/telemetry_fixtures.dart';

void main() {
  late ServerConnection connection;
  late Map<String, dynamic> responses;
  late List<String> calls;
  late List<Map<String, dynamic>> variables;
  var attached = true;
  var offline = false;
  setUp(() {
    attached = true;
    offline = false;
    calls = [];
    variables = [];
    responses = {
      ...loadJsonFixture('graphql/domain_reads.json'),
      ...loadJsonFixture('graphql/mutation_results.json'),
      ...loadJsonFixture('graphql/telemetry.json'),
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
            variables.add(request.variables);
            if (offline) {
              return Stream.error(StateError('offline input-secret'));
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

  test('staging replaces only telemetry without sending secrets', () {
    connection.cache.telemetry.push(aTelemetrySettings());
    final timezone = ChangeServerTimezoneJob(timezone: 'UTC');
    connection.changeDraft.add(timezone);
    final change = ChangeTelemetrySettingsJob(settings: aTelemetryUpdate());
    expect(connection.telemetry.stageChange(change), true);
    final replacement = ChangeTelemetrySettingsJob(
      settings: aTelemetryUpdate(logs: true),
    );
    connection.telemetry.stageChange(replacement);
    expect(connection.changeDraft.value, [timezone, replacement]);
    expect(calls, isEmpty);
    expect(replacement.toString(), isNot(contains('input-secret')));
    expect(replacement.settings.toString(), isNot(contains('input-secret')));
  });

  test('returning to saved values removes the queued telemetry change', () {
    connection.cache.telemetry.push(aTelemetrySettings());
    connection.telemetry.stageChange(
      ChangeTelemetrySettingsJob(settings: aTelemetryUpdate()),
    );
    connection.telemetry.stageChange(
      ChangeTelemetrySettingsJob(
        settings: aTelemetryUpdate(enable: false, logs: true, headers: {}),
      ),
    );
    expect(connection.changeDraft.value, isEmpty);
  });

  test('header names cannot confirm a queued secret replacement', () async {
    await connection.telemetry.refresh();
    final change = ChangeTelemetrySettingsJob(
      settings: aTelemetryUpdate(
        enable: false,
        headers: {'authorization': 'input-secret'},
      ),
    );
    connection.telemetry.stageChange(change);
    await connection.telemetry.refresh(force: true);
    expect(connection.changeDraft.value, [change]);
  });

  test('fresh values reconcile only non-secret changes', () async {
    connection.cache.telemetry.push(aTelemetrySettings());
    connection.telemetry.stageChange(
      ChangeTelemetrySettingsJob(settings: aTelemetryUpdate(headers: {})),
    );
    final data = responses['GetTelemetrySettings'] as Map<String, dynamic>;
    final system = data['system'] as Map<String, dynamic>;
    final settings = system['settings'] as Map<String, dynamic>;
    final telemetry = settings['openTelemetry'] as Map<String, dynamic>;
    telemetry['enable'] = true;
    telemetry['uploadSystemLogs'] = false;
    await connection.telemetry.refresh(force: true);
    expect(connection.changeDraft.value, isEmpty);
  });

  test('old and detached servers cannot stage or submit telemetry', () async {
    connection.cache.setVersion(Version(3, 8, 9));
    await connection.telemetry.refresh();
    await connection.telemetry.save(aTelemetryUpdate());
    expect(
      connection.telemetry.stageChange(
        ChangeTelemetrySettingsJob(settings: aTelemetryUpdate()),
      ),
      false,
    );
    connection.cache.setVersion(Version(3, 9, 0));
    connection.cache.telemetry.push(aTelemetrySettings());
    attached = false;
    await connection.telemetry.save(aTelemetryUpdate());
    expect(
      connection.telemetry.stageChange(
        ChangeTelemetrySettingsJob(settings: aTelemetryUpdate()),
      ),
      false,
    );
    expect(calls, isEmpty);
  });

  for (final outcome in [
    'confirmed',
    'rejected',
    'transport',
    'missing',
    'malformed',
  ]) {
    test(
      '$outcome telemetry save controls rebuild without exposing secrets',
      () async {
        await connection.telemetry.refresh();
        final old = connection.telemetry.value.data;
        final data = responses['SetTelemetrySettings'] as Map<String, dynamic>;
        final system = data['system'] as Map<String, dynamic>;
        final mutation =
            system['changeOpenTelemetrySettings'] as Map<String, dynamic>;
        if (outcome == 'rejected') {
          mutation['success'] = false;
        }
        if (outcome == 'missing') {
          mutation['settings'] = null;
        }
        if (outcome == 'malformed') {
          mutation['success'] = 'invalid';
        }
        mutation['message'] = 'input-secret';
        offline = outcome == 'transport';
        final result = await connection
            .submit<void>(
              OperationKind.applyChanges,
              (final owner) => configurationOperation(owner).run([
                ChangeTelemetrySettingsJob(settings: aTelemetryUpdate()),
              ], onProgress: (_) {}),
            )
            .result;
        final confirmed = outcome == 'confirmed';
        expect(
          calls,
          confirmed
              ? [
                  'GetTelemetrySettings',
                  'SetTelemetrySettings',
                  'RunSystemRebuild',
                ]
              : ['GetTelemetrySettings', 'SetTelemetrySettings'],
        );
        expect(
          connection.telemetry.value.data,
          confirmed ? isNot(same(old)) : same(old),
        );
        expect(result.status, switch (outcome) {
          'confirmed' => OperationStatus.accepted,
          'rejected' => OperationStatus.rejected,
          _ => OperationStatus.unknown,
        });
        final history = connection.operations.history.single;
        for (final step in history.steps) {
          expect(
            [step.titleKey, step.target, step.messageKey].join(),
            isNot(contains('input-secret')),
          );
          expect(step.target, isNull);
        }
        if (outcome != 'transport') {
          expect(variables[1]['settings'], {
            'enable': true,
            'endpoint': 'https://collector.example.org:4317',
            'uploadSystemLogs': false,
            'uploadSystemMetrics': true,
            'headers': [
              {'name': 'authorization', 'value': 'input-secret'},
              {'name': 'obsolete', 'value': null},
            ],
          });
        }
      },
    );
  }

  test('rebuild rejection does not roll back confirmed telemetry', () async {
    final rebuild = responses['RunSystemRebuild'] as Map<String, dynamic>;
    final system = rebuild['system'] as Map<String, dynamic>;
    (system['runSystemRebuild'] as Map<String, dynamic>)['success'] = false;
    final result = await connection
        .submit<void>(
          OperationKind.applyChanges,
          (final owner) => configurationOperation(owner).run([
            ChangeTelemetrySettingsJob(settings: aTelemetryUpdate()),
          ], onProgress: (_) {}),
        )
        .result;
    expect(result.status, OperationStatus.rejected);
    expect(connection.telemetry.value.data!.enable, true);
  });

  test('disabled telemetry transmits an explicit null endpoint', () async {
    final data = responses['SetTelemetrySettings'] as Map<String, dynamic>;
    final system = data['system'] as Map<String, dynamic>;
    final mutation =
        system['changeOpenTelemetrySettings'] as Map<String, dynamic>;
    final returned = mutation['settings'] as Map<String, dynamic>;
    returned['enable'] = false;
    returned['endpoint'] = null;
    await connection.telemetry.save(
      aTelemetryUpdate(enable: false, endpoint: null, headers: {}),
    );
    final settings = variables.single['settings'] as Map<String, dynamic>;
    expect(settings.containsKey('endpoint'), true);
    expect(settings['endpoint'], isNull);
    expect(connection.telemetry.value.data!.enable, false);
    expect(connection.telemetry.value.data!.endpoint, isNull);
  });
}
