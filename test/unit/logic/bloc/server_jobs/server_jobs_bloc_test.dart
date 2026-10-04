import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';

import '../../../../helpers/fixtures/domain_mutation_fixtures.dart';

void main() {
  late StreamController<JobsSnapshot?> source;
  late ServerJobsBloc bloc;
  late int removals;
  late int batches;
  late int migrations;
  late Completer<Map<String, ServerMutationResult<void>>?> batch;

  setUp(() {
    source = StreamController.broadcast(sync: true);
    removals = 0;
    batches = 0;
    migrations = 0;
    batch = Completer();
    bloc = ServerJobsBloc(
      jobs: source.stream,
      removeJob: (_) async {
        removals++;
        return null;
      },
      removeFinished: () {
        batches++;
        return batch.future;
      },
      migrate: (_) async {
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
      JobsSnapshot(
        value: CachedValue(lastError: StateError('list unavailable')),
        jobs: [job],
      ),
    );
    await pumpEventQueue();
    expect(bloc.state.serverJobList, [job]);
    expect(bloc.state.isComplete, isFalse);
    expect(bloc.state.hasError, isTrue);
  });

  test('duplicate bulk removals remain droppable', () async {
    source.add(
      JobsSnapshot(
        value: const CachedValue(data: []),
        jobs: const [],
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
        JobsSnapshot(
          value: const CachedValue(data: []),
          jobs: const [],
        ),
      );
      await pumpEventQueue();
      expect(bloc.state, isA<ServerJobsListEmptyState>());
      source.add(null);
      await pumpEventQueue();
      expect(bloc.state, isA<ServerJobsInitialState>());
    },
  );

  test('reset fences a queued removal before it reaches admission', () async {
    source.add(
      JobsSnapshot(
        value: const CachedValue(data: []),
        jobs: const [],
      ),
    );
    bloc.add(const RemoveServerJob('old-job'));
    source.add(null);
    await pumpEventQueue();
    expect(removals, 0);
  });

  test('a closed scope cannot submit migration choices', () async {
    final snapshot = JobsSnapshot(
      value: const CachedValue(data: []),
      jobs: const [],
    );
    source.add(snapshot);
    await pumpEventQueue();
    await bloc.close();
    await pumpEventQueue();
    await bloc.migrateToBinds({'gitea': 'sdb'});
    expect(migrations, 0);
  });
}
