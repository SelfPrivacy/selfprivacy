import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/repositories/devices_repository.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import '../../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../../helpers/fixtures/json_fixture.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  late _Api api;
  late ServerConnection connection;
  late ServerStateOrigin? currentOrigin;
  late DomainStore<List<String>> groups;
  late List<ApiToken> tokens;
  late List<String> groupNames;
  final confirmed = ServerMutationResult<void>(
    outcome: ServerMutationOutcome.confirmed,
    payload: const ServerMutationPayload.notExpected(),
  );

  setUp(() {
    api = _Api();
    final fixture = loadJsonFixture('graphql/domain_reads.json');
    tokens = Query$GetApiTokens.fromJson(
      fixture['GetApiTokens'] as Map<String, dynamic>,
    ).api.devices.map(ApiToken.fromGraphQL).toList();
    groupNames = Query$AllGroups.fromJson(
      fixture['AllGroups'] as Map<String, dynamic>,
    ).groups.allGroups.map((final group) => group.name).toList();
    when(api.fetchApiVersion).thenAnswer((_) async => '3.6.0');
    when(api.getApiTokens).thenAnswer((_) async => tokens);
    when(api.getAllGroups).thenAnswer((_) async => groupNames);
    currentOrigin = ServerStateOrigin('server');
    connection = ServerConnection(
      api: api,
      origin: currentOrigin!,
      currentOrigin: () => currentOrigin,
    );
    groups = connection.cache.groups;
  });
  tearDown(() => connection.dispose());

  test(
    'explicit reads use the observable dispatcher without starting passive reads',
    () async {
      connection.setVersion(Version(3, 6, 0));
      final pending = Completer<List<String>>();
      when(api.getAllGroups).thenAnswer((_) => pending.future);
      final reading = connection.refresh(groups, force: true);
      await pumpEventQueue();
      expect(connection.scheduler.poolStatus.whereType<Object>(), hasLength(1));
      expect(
        connection.scheduler.poolStatus
            .singleWhere((final slot) => slot != null)
            ?.domain,
        'groups',
      );
      verifyNever(api.getAllUsers);
      pending.complete(groupNames);
      expect(await reading, RefreshResult.applied);
      expect(await connection.refresh(groups), RefreshResult.current);
      verify(api.getAllGroups).called(1);
      when(api.getAllGroups).thenAnswer((_) async => groupNames);
      expect(
        await connection.refresh(groups, force: true),
        RefreshResult.applied,
      );
      verify(api.getAllGroups).called(1);
    },
  );

  test(
    'repository observations exclude unrelated domains but include prerequisite errors',
    () async {
      connection.setVersion(Version(3, 6, 0));
      await pumpEventQueue();
      final seen = <Object>[];
      final subscription = connection.users.changes.listen(seen.add);
      groups.push(groupNames);
      await pumpEventQueue();
      expect(seen, isEmpty);
      when(api.fetchApiVersion).thenThrow(StateError('version unavailable'));
      await connection.cache.apiVersion.refresh(force: true);
      await pumpEventQueue();
      expect(seen, hasLength(1));
      expect(connection.users.value.lastError, isA<StateError>());
      groups.push(groupNames);
      await pumpEventQueue();
      expect(seen, hasLength(1));
      await subscription.cancel();
    },
  );

  test(
    'initial apply orders settings writes after version discovery',
    () async {
      final pending = Completer<ServerMutationResult<ServerJob>>();
      when(api.apply).thenAnswer((_) => pending.future);
      var timezoneSent = false;
      when(() => api.setTimezone('UTC')).thenAnswer((_) async {
        timezoneSent = true;
        return ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('UTC'),
        );
      });
      final applying = connection.jobs.apply();
      await pumpEventQueue();
      final changing = connection.settings.setServerTimezone('UTC');
      await pumpEventQueue();
      expect(timezoneSent, isFalse);
      pending.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(aServiceMoveJob()),
        ),
      );
      await applying;
      expect((await changing).outcome, ServerMutationOutcome.confirmed);
      expect(timezoneSent, isTrue);
    },
  );

  test(
    'local publication failure preserves the confirmed remote receipt',
    () async {
      connection.setVersion(Version(3, 6, 0));
      final result = await connection.commands.mutate<void>(
        domains: [groups],
        send: (_) async => confirmed,
        applyConfirmed: (_) => throw StateError('local projection failed'),
      );
      expect(result, same(confirmed));
      expect(groups.value.needsReconciliation, isTrue);
    },
  );

  test(
    'construction is inert and shares version discovery across domains',
    () async {
      verifyZeroInteractions(api);
      expect(connection.stores, connection.cache.stores);
      expect(connection.users.store, same(connection.cache.users));
      expect(connection.jobs.store, same(connection.cache.serverJobs));
      expect(connection.backups.store, same(connection.cache.backups));
      final version = Completer<String>();
      when(api.fetchApiVersion).thenAnswer((_) => version.future);
      final devicesRead = connection.devices.refresh();
      final groupsRead = connection.refresh(groups);
      version.complete('3.6.0');
      expect(await devicesRead, RefreshResult.applied);
      expect(await groupsRead, RefreshResult.applied);
      verify(api.fetchApiVersion).called(1);
      expect(connection.groups.value.data, groupNames);
    },
  );

  test(
    'commands share a version read already running in the canonical store',
    () async {
      final version = Completer<String>();
      when(api.fetchApiVersion).thenAnswer((_) => version.future);
      when(() => api.setTimezone('UTC')).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('UTC'),
        ),
      );
      final reading = connection.cache.apiVersion.refresh();
      final command = connection.settings.setServerTimezone('UTC');
      await pumpEventQueue();
      verifyNever(api.getApiVersion);
      verifyNever(() => api.setTimezone(any()));
      version.complete('3.6.0');
      expect(await reading, RefreshResult.applied);
      expect((await command).outcome, ServerMutationOutcome.confirmed);
      verify(api.fetchApiVersion).called(1);
    },
  );

  test(
    'one command reserves both domains and orders overlapping work',
    () async {
      connection.setVersion(Version(3, 6, 0));
      await connection.devices.refresh();
      await connection.refresh(groups);
      final both = Completer<ServerMutationResult<void>>();
      final first = connection.commands.submit<void>(
        domains: connection.stores,
        send: (final boundApi) {
          expect(identical(boundApi, api), isTrue);
          return both.future;
        },
        applyConfirmed: (_) => connection.stores,
      );
      var secondStarted = false;
      final second = connection.commands.submit<void>(
        domains: [groups],
        send: (_) async {
          secondStarted = true;
          return confirmed;
        },
        applyConfirmed: (_) => [groups],
      );
      final name = tokens.firstWhere((final token) => !token.isCaller).name;
      expect(await connection.devices.revoke(name), isNull);
      expect(await connection.devices.refresh(), RefreshResult.deferred);
      expect(await connection.refresh(groups), RefreshResult.deferred);
      expect(secondStarted, isFalse);
      both.complete(confirmed);
      expect((await first).application, CommandApplication.applied);
      expect((await second).application, CommandApplication.applied);
      expect(secondStarted, isTrue);
      verify(api.getApiTokens).called(1);
      verify(api.getAllGroups).called(1);
      verifyNever(() => api.deleteApiToken(any()));
    },
  );

  test('disjoint domain commands can run concurrently', () async {
    connection.setVersion(Version(3, 6, 0));
    await connection.devices.refresh();
    final pendingGroups = Completer<ServerMutationResult<void>>();
    final first = connection.commands.submit<void>(
      domains: [groups],
      send: (_) => pendingGroups.future,
    );
    final name = tokens.firstWhere((final token) => !token.isCaller).name;
    when(() => api.deleteApiToken(name)).thenAnswer((_) async => confirmed);
    expect(
      (await connection.devices.revoke(name))!.application,
      CommandApplication.applied,
    );
    expect(connection.commands.isReserved(groups), isTrue);
    pendingGroups.complete(confirmed);
    await first;
  });

  test(
    'disposal detaches all command waiters before destroying stores',
    () async {
      connection.setVersion(Version(3, 6, 0));
      final pending = Completer<ServerMutationResult<void>>();
      final first = connection.commands.submit<void>(
        domains: connection.stores,
        send: (_) => pending.future,
      );
      var queuedSent = false;
      final second = connection.commands.submit<void>(
        domains: [groups],
        send: (_) async {
          queuedSent = true;
          return confirmed;
        },
      );
      connection.dispose();
      expect((await first).application, CommandApplication.detached);
      expect((await second).application, CommandApplication.detached);
      expect(queuedSent, isFalse);
      expect(
        connection.stores.every((final store) => store.isDisposed),
        isTrue,
      );
      pending.complete(confirmed);
    },
  );

  for (final fails in [false, true]) {
    test('all domains reject detached read results: fails=$fails', () async {
      await connection.refresh(groups);
      final before = connection.groups.value;
      final pending = Completer<List<String>>();
      when(api.getAllGroups).thenAnswer((_) => pending.future);
      final reading = connection.refresh(groups, force: true);
      await pumpEventQueue();
      currentOrigin = null;
      if (fails) {
        pending.completeError(StateError('late'));
      } else {
        pending.complete([]);
      }
      expect(await reading, RefreshResult.disposed);
      expect(connection.groups.value.data, before.data);
      expect(connection.groups.value.lastError, isNull);
    });
  }

  test('domain support uses each registered requirement', () async {
    connection.setVersion(Version(3, 5, 0));
    expect(await connection.devices.refresh(), RefreshResult.applied);
    expect(await connection.refresh(groups), RefreshResult.unsupported);
    expect(groups.value.support, DomainSupport.unsupported);
    verifyNever(api.getAllGroups);
  });

  test('foreign stores cannot be used by a connection or repository', () {
    final foreign = DomainStore<List<ApiToken>>(
      name: 'foreign',
      fetch: api.getApiTokens,
      refreshInterval: const Duration(seconds: 60),
    );
    addTearDown(foreign.dispose);
    expect(() => connection.refresh(foreign), throwsArgumentError);
    expect(
      () => DevicesRepository(
        commands: connection.commands,
        reader: DomainReader(
          store: foreign,
          apiVersion: connection.cache.apiVersion,
          dispatcher: connection.scheduler,
        ),
      ),
      throwsArgumentError,
    );
  });

  test('disposal resolves a command waiting for version discovery', () async {
    final version = Completer<String>();
    when(api.fetchApiVersion).thenAnswer((_) => version.future);
    final pending = connection.settings.setServerTimezone('UTC');
    connection.dispose();
    final result = await pending.timeout(const Duration(seconds: 1));
    expect(result.outcome, ServerMutationOutcome.indeterminate);
    version.complete('3.6.0');
    await pumpEventQueue();
    verifyNever(() => api.setTimezone(any()));
  });
}
