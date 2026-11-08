import 'package:flutter_test/flutter_test.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/update_channels.dart';
import 'package:selfprivacy/logic/operations/configuration/apply_changes_operation.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../../fakes/graphql/link_transport.dart';
import '../../../../helpers/connection_fixture.dart';
import '../../../../helpers/fixtures/json_fixture.dart';
import '../../../../helpers/fixtures/update_channels_fixtures.dart';

void main() {
  late Map<String, dynamic> responses;
  late ServerConnection connection;
  late List<String> calls;
  String? failure;
  var attached = true;

  setUp(() {
    responses = {
      ...loadJsonFixture('graphql/domain_reads.json'),
      ...loadJsonFixture('graphql/mutation_results.json'),
    };
    calls = [];
    failure = null;
    attached = true;
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
            if (name == 'SetUpdateChannel') {
              expect(request.variables, {'channelId': 'stable'});
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

  for (final scenario in ['confirmed', 'rejected', 'malformed', 'transport']) {
    test(
      'channel $scenario retains current state and reconciles without replay',
      () async {
        await connection.updateChannels.refresh();
        final previous = connection.updateChannels.value.data;
        final data = responses['SetUpdateChannel'] as Map<String, dynamic>;
        final result =
            (data['system'] as Map<String, dynamic>)['setUpdateChannel']
                as Map<String, dynamic>;
        if (scenario == 'rejected') {
          result['success'] = false;
        }
        if (scenario == 'malformed') {
          result.remove('success');
        }
        failure = scenario;
        final outcome = await connection.updateChannels.setChannel('stable');
        expect(outcome.outcome, switch (scenario) {
          'confirmed' => ServerMutationOutcome.confirmed,
          'rejected' => ServerMutationOutcome.rejected,
          _ => ServerMutationOutcome.indeterminate,
        });
        expect(connection.updateChannels.value.data, same(previous));
        expect(connection.updateChannels.value.freshness, Freshness.stale);
        expect(calls, ['GetUpdateChannels', 'SetUpdateChannel']);
      },
    );
  }

  test(
    'unsupported and detached connections never dispatch a change',
    () async {
      connection.cache.setVersion(Version(3, 8, 9));
      await connection.updateChannels.setChannel('stable');
      connection.cache.setVersion(Version(3, 9, 0));
      attached = false;
      await connection.updateChannels.setChannel('stable');
      expect(calls, isEmpty);
    },
  );

  test('channel draft replaces only another channel draft', () {
    final timezone = ChangeServerTimezoneJob(timezone: 'UTC');
    final first = ChangeUpdateChannelJob(
      channelId: testUpdateChannel.id,
      channelName: testUpdateChannel.name,
    );
    final last = ChangeUpdateChannelJob(
      channelId: 'stable',
      channelName: 'Stable',
    );
    final channels = anUpdateChannels(custom: true);
    connection.cache.updateChannels.push(
      UpdateChannels(
        currentChannel: channels.currentChannel,
        channels: [...channels.channels, testUpdateChannel],
      ),
    );
    final draft = connection.changeDraft..add(timezone);
    connection.updateChannels
      ..stageChange(first)
      ..stageChange(last);
    expect(draft.value, [timezone, last]);
    expect(last.requiresRebuild, isTrue);
    expect(configurationStep(last).target, 'Stable');
  });

  for (final scenario in ['confirmed', 'rejected', 'transport']) {
    test(
      '$scenario channel change continues independent changes and ends with apply',
      () async {
        final data = responses['SetUpdateChannel'] as Map<String, dynamic>;
        if (scenario == 'rejected') {
          ((data['system'] as Map<String, dynamic>)['setUpdateChannel']
                  as Map<String, dynamic>)['success'] =
              false;
        }
        failure = scenario;
        final progress = <ConfigurationProgress>[];
        await configurationOperation(connection).run([
          ChangeUpdateChannelJob(channelId: 'stable', channelName: 'Stable'),
          ChangeServerTimezoneJob(timezone: 'UTC'),
        ], onProgress: progress.add);
        expect(calls, [
          'SetUpdateChannel',
          'ChangeTimezone',
          'RunSystemRebuild',
        ]);
        expect(progress[1].status, switch (scenario) {
          'confirmed' => OperationStatus.succeeded,
          'rejected' => OperationStatus.rejected,
          _ => OperationStatus.unknown,
        });
      },
    );
  }
}
