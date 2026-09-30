import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_reconciler.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import '../../../../helpers/fixtures/json_fixture.dart';

class _Api extends Mock implements ServerApi {}

ServerJob job({
  final String uid = 'job-1',
  final int seconds = 0,
  final int progress = 25,
}) {
  final fixture = loadJsonFixture('graphql/domain_reads.json');
  final parsed = Query$GetApiJobs.fromJson(
    fixture['GetApiJobs'] as Map<String, dynamic>,
  ).jobs.getJobs.single;
  return ServerJob.fromGraphQL(
    parsed.copyWith(
      uid: uid,
      updatedAt: parsed.updatedAt.add(Duration(seconds: seconds)),
      progress: progress,
    ),
  );
}

void main() {
  late DomainStore<List<ServerJob>> store;
  late ServerCommandCoordinator commands;
  late JobsReconciler reconciler;
  late List<ServerJob> nextRead;
  late bool failRead;

  void testJobs(final String name, final WidgetTesterCallback body) {
    testWidgets(name, (final tester) async {
      nextRead = [];
      failRead = false;
      store = DomainStore(
        name: 'jobs',
        fetch: () async {
          if (failRead) {
            throw StateError('read failed');
          }
          return List.unmodifiable(nextRead);
        },
        support: DomainSupport.supported,
        refreshInterval: const Duration(seconds: 10),
        now: tester.binding.clock.now,
      );
      final origin = ServerStateOrigin('server');
      commands = ServerCommandCoordinator(
        origin: origin,
        currentOrigin: () => origin,
        api: _Api(),
        stores: [store],
      );
      reconciler = JobsReconciler(store: store, commands: commands);
      try {
        await body(tester);
      } finally {
        reconciler.dispose();
        commands.dispose();
        store.dispose();
        await tester.pump();
      }
    });
  }

  testJobs('ordinary snapshots establish a complete immutable list', (
    final tester,
  ) async {
    final jobs = [job()];
    reconciler.receiveSnapshot(jobs);
    jobs.clear();
    expect(store.value.data, [job()]);
    expect(store.value.freshness, Freshness.fresh);
    expect(() => store.value.data!.clear(), throwsUnsupportedError);
  });

  testJobs('rejects a coordinator belonging to another store', (
    final tester,
  ) async {
    final origin = ServerStateOrigin('other-server');
    final foreign = ServerCommandCoordinator(
      origin: origin,
      currentOrigin: () => origin,
      api: _Api(),
      stores: [],
    );
    expect(
      () => JobsReconciler(store: store, commands: foreign),
      throwsArgumentError,
    );
    foreign.dispose();
  });

  testJobs(
    'confirmed entities before first load remain an incomplete projection',
    (final tester) async {
      reconciler.upsertConfirmed(job());
      expect(store.value.data, isNull);
      expect(store.value.updatedAt, isNull);
      expect(reconciler.confirmedBeforeLoad.keys, ['job-1']);
      expect(
        () => reconciler.confirmedBeforeLoad.clear(),
        throwsUnsupportedError,
      );
      reconciler.receiveSnapshot([job(seconds: 1, progress: 50)]);
      expect(store.value.data, isNull);
      expect(reconciler.confirmedBeforeLoad['job-1']!.progress, 50);
      nextRead = [job(seconds: 2, progress: 60)];
      expect(await store.refresh(), RefreshResult.applied);
      expect(reconciler.confirmedBeforeLoad, isEmpty);
      expect(store.value.data!.single.progress, 60);
    },
  );

  testJobs('confirmed removal cannot be undone by an unversioned snapshot', (
    final tester,
  ) async {
    store.push([job()]);
    final updatedAt = store.value.updatedAt;
    reconciler
      ..removeConfirmed('job-1')
      ..receiveSnapshot([job(seconds: 10)]);
    expect(store.value.data, isEmpty);
    expect(store.value.updatedAt, updatedAt);
    expect(store.value.needsReconciliation, isTrue);
    expect(await store.refresh(), RefreshResult.applied);
    reconciler.receiveSnapshot([job(seconds: 20)]);
    expect(store.value.data, [job(seconds: 20)]);
  });

  testJobs(
    'only independently newer records merge while effects are protected',
    (final tester) async {
      store.push([job(), job(uid: 'other')]);
      final updatedAt = store.value.updatedAt;
      reconciler
        ..upsertConfirmed(job(seconds: 10, progress: 50))
        ..receiveSnapshot([job(seconds: 10, progress: 0), job(uid: 'unknown')]);
      expect(
        store.value.data!
            .firstWhere((final item) => item.uid == 'job-1')
            .progress,
        50,
      );
      expect(
        store.value.data!.map((final item) => item.uid),
        contains('other'),
      );
      expect(
        store.value.data!.map((final item) => item.uid),
        isNot(contains('unknown')),
      );
      reconciler.receiveSnapshot([job(seconds: 11, progress: 75)]);
      expect(
        store.value.data!
            .firstWhere((final item) => item.uid == 'job-1')
            .progress,
        75,
      );
      expect(store.value.updatedAt, updatedAt);
      reconciler.receiveSnapshot([]);
      expect(store.value.data, hasLength(2));
      await tester.pump(const Duration(seconds: 20));
      expect(store.value.freshness, Freshness.stale);
    },
  );

  testJobs(
    'conflicting snapshots coalesce and cannot erase a confirmed returned job',
    (final tester) async {
      store.push([job()]);
      final response = Completer<ServerMutationResult<ServerJob>>();
      final command = commands.submit<ServerJob>(
        domains: [store],
        send: (_) => response.future,
        applyConfirmed: (final result) {
          reconciler.upsertConfirmed(result.payload.value!);
          return [store];
        },
      );
      reconciler
        ..receiveSnapshot([job(seconds: 30, progress: 99)])
        ..receiveSnapshot([job(seconds: 11, progress: 75)]);
      expect(store.value.data!.single.progress, 25);
      response.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(
            job(seconds: 10, progress: 50),
          ),
        ),
      );
      await command.completion;
      await tester.pump();
      expect(store.value.data!.single.progress, 75);
      expect(store.value.needsReconciliation, isTrue);
    },
  );

  testJobs('buffered snapshot is not deletion proof even after rejection', (
    final tester,
  ) async {
    store.push([job()]);
    final response = Completer<ServerMutationResult<void>>();
    final command = commands.submit<void>(
      domains: [store],
      send: (_) => response.future,
    );
    reconciler.receiveSnapshot([]);
    response.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.rejected,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    await command.completion;
    await tester.pump();
    expect(store.value.data, [job()]);
    expect(store.value.needsReconciliation, isTrue);
  });

  testJobs('a failed full read does not release deletion protection', (
    final tester,
  ) async {
    store.push([job()]);
    reconciler.removeConfirmed('job-1');
    failRead = true;
    expect(await store.refresh(force: true), RefreshResult.failed);
    reconciler.receiveSnapshot([job()]);
    expect(store.value.data, isEmpty);
    expect(store.value.needsReconciliation, isTrue);
  });

  testJobs('deleting an incomplete confirmed entity removes its projection', (
    final tester,
  ) async {
    reconciler
      ..upsertConfirmed(job())
      ..removeConfirmed('job-1')
      ..receiveSnapshot([job(seconds: 1)]);
    expect(reconciler.confirmedBeforeLoad, isEmpty);
    expect(store.value.data, isNull);
  });

  testJobs('detachment and disposal ignore late subscription inputs', (
    final tester,
  ) async {
    store.push([job()]);
    commands.dispose();
    reconciler.receiveSnapshot([]);
    expect(store.value.data, [job()]);
    expect(() => reconciler.removeConfirmed('job-1'), throwsStateError);
    reconciler
      ..dispose()
      ..receiveSnapshot([]);
    expect(store.value.data, [job()]);
  });

  testJobs(
    'projection changes are observable and disposal closes observation',
    (final tester) async {
      var events = 0;
      var closed = false;
      final subscription = reconciler.changes.listen(
        (_) => events++,
        onDone: () => closed = true,
      );
      reconciler.upsertConfirmed(job());
      await tester.pump();
      expect(events, 1);
      reconciler.dispose();
      await tester.pump();
      expect(closed, isTrue);
      unawaited(subscription.cancel());
    },
  );
}
