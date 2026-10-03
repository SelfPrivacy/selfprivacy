import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';

import '../../../../helpers/fixtures/domain_mutation_fixtures.dart';

void main() {
  late StreamController<ConnectionObservation<JobsSnapshot>> source;
  late ServerJobsBloc bloc;
  late ServerStateOrigin origin;
  late int removals;
  late int batches;
  late int migrations;
  late Completer<Map<String, ServerMutationResult<void>>?> batch;

  setUp(() {
    source = StreamController.broadcast(sync: true);
    origin = ServerStateOrigin('server');
    removals = 0;
    batches = 0;
    migrations = 0;
    batch = Completer();
    bloc = ServerJobsBloc(
      jobs: source.stream,
      removeJob: (_, _) async {
        removals++;
        return null;
      },
      removeFinished: (_) {
        batches++;
        return batch.future;
      },
      migrate: (_, _) async {
        migrations++;
        return null;
      },
      showMessage: (_, {final behavior}) {},
    );
  });
  tearDown(() async {
    await bloc.close();
    await source.close();
  });

  test('accepted jobs remain visible before a complete jobs list', () async {
    final job = aServiceMoveJob();
    source.add(
      ConnectionObservation.attached(
        origin,
        JobsSnapshot(
          value: CachedValue(lastError: StateError('list unavailable')),
          jobs: [job],
        ),
      ),
    );
    await pumpEventQueue();
    expect(bloc.state.serverJobList, [job]);
    expect(bloc.state.isComplete, isFalse);
    expect(bloc.state.hasError, isTrue);
  });

  test('duplicate bulk removals remain droppable', () async {
    source.add(
      ConnectionObservation.attached(
        origin,
        JobsSnapshot(
          value: const CachedValue(data: []),
          jobs: const [],
        ),
      ),
    );
    await pumpEventQueue();
    bloc
      ..add(RemoveAllFinishedJobs())
      ..add(RemoveAllFinishedJobs());
    await pumpEventQueue();
    batch.complete({});
    await pumpEventQueue();
    expect(batches, 1);
  });

  test(
    'empty loaded jobs and an absent binding are different states',
    () async {
      source.add(
        ConnectionObservation.attached(
          origin,
          JobsSnapshot(
            value: const CachedValue(data: []),
            jobs: const [],
          ),
        ),
      );
      await pumpEventQueue();
      expect(bloc.state, isA<ServerJobsListEmptyState>());
      source.add(const ConnectionObservation.absent());
      await pumpEventQueue();
      expect(bloc.state, isA<ServerJobsInitialState>());
    },
  );

  test('reset fences a queued removal before it reaches admission', () async {
    source.add(
      ConnectionObservation.attached(
        origin,
        JobsSnapshot(
          value: const CachedValue(data: []),
          jobs: const [],
        ),
      ),
    );
    bloc.add(const RemoveServerJob('old-job'));
    source.add(const ConnectionObservation.absent());
    await pumpEventQueue();
    expect(removals, 0);
  });

  test(
    'migration cannot use a replacement not yet presented to the user',
    () async {
      final snapshot = JobsSnapshot(
        value: const CachedValue(data: []),
        jobs: const [],
      );
      source.add(ConnectionObservation.attached(origin, snapshot));
      await pumpEventQueue();
      source.add(
        ConnectionObservation.attached(ServerStateOrigin('server'), snapshot),
      );
      await bloc.migrateToBinds({'gitea': 'sdb'});
      expect(migrations, 0);
    },
  );
}
