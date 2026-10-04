import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import '../../../../helpers/fixtures/backup_fixtures.dart';
import '../../../../helpers/fixtures/json_fixture.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  late _Api api;
  late ServerConnection connection;
  late ServerStateOrigin? origin;
  late List<Backup> backups;

  setUp(() {
    api = _Api();
    origin = ServerStateOrigin('server');
    connection = ServerConnection(
      api: api,
      origin: origin!,
      currentOrigin: () => origin,
    )..cache.setVersion(Version(3, 6, 0));
    backups = Query$AllBackupSnapshots.fromJson(
      loadJsonFixture('graphql/domain_reads.json')['AllBackupSnapshots']
          as Map<String, dynamic>,
    ).backup.allSnapshots.map(Backup.fromGraphQL).toList();
  });
  tearDown(() => connection.dispose());

  test(
    'backup observations include configuration but exclude unrelated domains',
    () async {
      final changes = <Object>[];
      final subscription = connection.backups.changes.listen(changes.add);
      connection.backups.configStore.push(aBackupConfiguration());
      await pumpEventQueue();
      expect(changes, hasLength(1));
      connection.cache.groups.push(['gitea']);
      await pumpEventQueue();
      expect(changes, hasLength(1));
      await subscription.cancel();
    },
  );

  test('configuration response replaces the complete configuration', () async {
    final repository = connection.backups;
    repository.configStore.push(aBackupConfiguration());
    final json =
        loadJsonFixture('graphql/domain_reads.json')['BackupConfiguration']
            as Map<String, dynamic>;
    ((json['backup'] as Map<String, dynamic>)['configuration']
            as Map<String, dynamic>)['autobackupPeriod'] =
        null;
    final returned = BackupConfiguration.fromGraphQL(
      Query$BackupConfiguration.fromJson(json).backup.configuration,
    );
    when(() => api.setAutobackupPeriod(period: 15)).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(returned),
      ),
    );
    await repository.setAutobackupPeriod(period: 15);
    expect(repository.configValue.data!.autobackupPeriod, isNull);
    expect(repository.configValue.needsReconciliation, isFalse);
    verifyNever(api.getBackupsConfiguration);
  });

  for (final outcome in ServerMutationOutcome.values) {
    for (final loaded in [false, true]) {
      test(
        'delete ${outcome.name}, loaded=$loaded preserves completeness and age',
        () async {
          final repository = connection.backups;
          if (loaded) {
            repository.store.push(List.unmodifiable(backups));
          }
          final before = repository.value;
          final id = backups.first.id;
          when(() => api.forgetSnapshot(id)).thenAnswer(
            (_) async => ServerMutationResult<void>(
              outcome: outcome,
              payload: const ServerMutationPayload.notExpected(),
            ),
          );
          await repository.forgetSnapshot(id);
          expect(repository.value.updatedAt, before.updatedAt);
          expect(before.data, loaded ? backups : null);
          if (loaded) {
            expect(
              repository.value.data!.any((final backup) => backup.id == id),
              outcome != ServerMutationOutcome.confirmed,
            );
            expect(
              () => repository.value.data!.clear(),
              throwsUnsupportedError,
            );
          } else {
            expect(repository.value.data, isNull);
          }
          verifyNever(api.getBackups);
        },
      );
    }
  }

  test('late confirmation cannot change a detached snapshot', () async {
    final repository = connection.backups;
    repository.store.push(List.unmodifiable(backups));
    final pending = Completer<ServerMutationResult<void>>();
    when(
      () => api.forgetSnapshot(backups.first.id),
    ).thenAnswer((_) => pending.future);
    final command = repository.forgetSnapshot(backups.first.id);
    await pumpEventQueue();
    origin = null;
    pending.complete(
      ServerMutationResult<void>(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    await command;
    expect(repository.value.data, backups);
  });

  test('a pre-command read cannot restore a deleted snapshot', () async {
    final repository = connection.backups;
    repository.store.push(List.unmodifiable(backups));
    final pending = Completer<List<Backup>>();
    when(api.getBackups).thenAnswer((_) => pending.future);
    final reading = connection.refresh(repository.store, force: true);
    when(() => api.forgetSnapshot(backups.first.id)).thenAnswer(
      (_) async => ServerMutationResult<void>(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    await repository.forgetSnapshot(backups.first.id);
    pending.complete(backups);
    expect(await reading, RefreshResult.superseded);
    expect(
      repository.value.data!.map((final backup) => backup.id),
      isNot(contains(backups.first.id)),
    );
  });

  test('returned job preserves list age and reserves affected reads', () async {
    final repository = connection.backups;
    final job = aBackupJob();
    repository.store.push(List.unmodifiable(backups));
    connection.jobs.store.push([job]);
    final before = connection.jobs.value.updatedAt;
    final pending = Completer<ServerMutationResult<ServerJob>>();
    when(() => api.startBackup(job.uid)).thenAnswer((_) => pending.future);
    final command = repository.startBackup(job.uid);
    expect(await connection.refresh(repository.store), RefreshResult.deferred);
    expect(await connection.jobs.refresh(), RefreshResult.deferred);
    pending.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(job),
      ),
    );
    await command;
    expect(connection.jobs.value.data, [job]);
    expect(connection.jobs.value.updatedAt, before);
    expect(repository.value.data, backups);
    expect(repository.value.needsReconciliation, isTrue);
  });
}
