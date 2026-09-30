import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import '../../../../helpers/fixtures/domain_mutation_fixtures.dart';

class _Api extends Mock implements ServerApi {}

ServerMutationResult<T> confirmed<T>(final T value) => ServerMutationResult(
  outcome: ServerMutationOutcome.confirmed,
  payload: ServerMutationPayload.available(value),
);

void main() {
  late _Api api;
  late ServerConnection connection;

  setUp(() {
    api = _Api();
    final origin = ServerStateOrigin('server');
    connection = ServerConnection(
      api: api,
      origin: origin,
      currentOrigin: () => origin,
    )..setVersion(Version(3, 0, 0));
  });
  tearDown(() => connection.dispose());

  test(
    'queued service configuration keeps its original submitted values',
    () async {
      final pending = Completer<ServerMutationResult<void>>();
      when(() => api.restartService('gitea')).thenAnswer((_) => pending.future);
      Map<String, dynamic>? sent;
      when(() => api.setServiceConfiguration('gitea', any())).thenAnswer((
        final invocation,
      ) async {
        sent = invocation.positionalArguments[1] as Map<String, dynamic>;
        return ServerMutationResult<void>(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        );
      });
      final first = connection.services.restart('gitea');
      final input = <String, dynamic>{'enable': true};
      final second = connection.services.setConfiguration('gitea', input);
      input['enable'] = false;
      pending.complete(
        ServerMutationResult<void>(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await first;
      await second;
      expect(sent, {'enable': true});
    },
  );

  test(
    'rebuild remains available when optional domains are unsupported',
    () async {
      connection.setVersion(Version(2, 3, 0));
      when(api.apply).thenAnswer((_) async => confirmed(aServiceMoveJob()));
      final result = await connection.jobs.apply();
      expect(result.outcome, ServerMutationOutcome.confirmed);
    },
  );

  test(
    'move retains confirmed job separately before first jobs load',
    () async {
      final job = aServiceMoveJob();
      when(
        () => api.moveService('gitea', 'disk'),
      ).thenAnswer((_) async => confirmed(job));
      await connection.services.move('gitea', 'disk');
      expect(connection.jobs.store.value.data, isNull);
      expect(connection.jobs.confirmedBeforeLoad[job.uid], job);
      expect(connection.services.store.value.needsReconciliation, isTrue);
    },
  );

  test('move deduplicates jobs without mutating earlier snapshots', () async {
    final job = aServiceMoveJob();
    final before = List<ServerJob>.unmodifiable([job]);
    connection.jobs.store.push(before);
    when(
      () => api.moveService('gitea', 'disk'),
    ).thenAnswer((_) async => confirmed(job));
    await connection.services.move('gitea', 'disk');
    await connection.services.move('gitea', 'disk');
    expect(connection.jobs.store.value.data, [job]);
    expect(before, [job]);
  });

  test('remove all preserves failed items and reports each outcome', () async {
    final removed = aServiceMoveJob(uid: 'removed', status: 'FINISHED');
    final retained = aServiceMoveJob(uid: 'retained', status: 'ERROR');
    connection.jobs.store.push([removed, retained]);
    when(() => api.removeApiJob('removed')).thenAnswer(
      (_) async => ServerMutationResult<void>(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    when(() => api.removeApiJob('retained')).thenAnswer(
      (_) async => ServerMutationResult<void>(
        outcome: ServerMutationOutcome.rejected,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    final results = await connection.jobs.removeAllFinished();
    expect(results.keys, ['removed', 'retained']);
    expect(connection.jobs.store.value.data, [retained]);
  });

  test(
    'late move completion cannot publish into a detached connection',
    () async {
      final response = Completer<ServerMutationResult<ServerJob>>();
      when(
        () => api.moveService('gitea', 'disk'),
      ).thenAnswer((_) => response.future);
      final future = connection.services.move('gitea', 'disk');
      connection.dispose();
      response.complete(confirmed(aServiceMoveJob()));
      expect((await future).outcome, isNot(ServerMutationOutcome.confirmed));
      expect(connection.jobs.store.value.data, isNull);
    },
  );

  test(
    'terminal jobs read invalidates effects after accepted work completes',
    () async {
      final running = aServiceMoveJob(status: 'RUNNING');
      connection.jobs.store.push([running]);
      await Future<void>.delayed(Duration.zero);
      connection.services.store.push([]);
      connection.users.store.push([]);
      when(
        api.getServerJobs,
      ).thenAnswer((_) async => [aServiceMoveJob(status: 'FINISHED')]);
      await connection.jobs.refresh(force: true);
      await Future<void>.delayed(Duration.zero);
      expect(connection.services.store.value.needsReconciliation, isTrue);
      expect(connection.users.store.value.needsReconciliation, isFalse);
    },
  );
}
