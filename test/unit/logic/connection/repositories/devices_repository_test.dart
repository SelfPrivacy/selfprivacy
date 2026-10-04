import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/connection/repositories/devices_repository.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

import '../../../../helpers/fixtures/json_fixture.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  late _Api api;
  late DevicesRepository repository;
  late ServerConnection connection;
  late List<ApiToken> tokens;
  late ServerStateOrigin? origin;

  ServerMutationResult<void> result(final ServerMutationOutcome outcome) =>
      ServerMutationResult(
        outcome: outcome,
        payload: const ServerMutationPayload.notExpected(),
      );

  setUp(() {
    api = _Api();
    tokens = Query$GetApiTokens.fromJson(
      loadJsonFixture('graphql/domain_reads.json')['GetApiTokens']
          as Map<String, dynamic>,
    ).api.devices.map(ApiToken.fromGraphQL).toList();
    origin = ServerStateOrigin('server');
    connection = ServerConnection(
      api: api,
      origin: origin!,
      currentOrigin: () => origin,
    );
    repository = connection.devices;
    when(api.fetchApiVersion).thenAnswer((_) async => '3.6.0');
    when(api.getApiTokens).thenAnswer((_) async => tokens);
  });
  tearDown(() => connection.dispose());

  test('loads once, validates support and owns immutable values', () async {
    expect(await repository.refresh(), RefreshResult.applied);
    expect(repository.value.support, DomainSupport.supported);
    expect(repository.value.data, tokens);
    expect(() => repository.value.data!.clear(), throwsUnsupportedError);
    expect(await repository.refresh(), RefreshResult.current);
    verify(api.getApiTokens).called(1);
    verify(api.fetchApiVersion).called(1);
  });

  for (final loaded in [false, true]) {
    for (final empty in [false, true]) {
      test('missing caller fails: loaded=$loaded empty=$empty', () async {
        if (loaded) {
          await repository.refresh();
        }
        final before = repository.value;
        when(api.getApiTokens).thenAnswer(
          (_) async => empty
              ? []
              : tokens.where((final token) => !token.isCaller).toList(),
        );
        expect(await repository.refresh(force: true), RefreshResult.failed);
        expect(repository.value.data, before.data);
        expect(repository.value.updatedAt, before.updatedAt);
        expect(repository.value.lastError, isNotNull);
      });
    }
  }

  test('the current device alone is valid', () async {
    when(api.getApiTokens).thenAnswer(
      (_) async => tokens.where((final token) => token.isCaller).toList(),
    );
    expect(await repository.refresh(), RefreshResult.applied);
    expect(repository.value.data, hasLength(1));
  });

  for (final outcome in ServerMutationOutcome.values) {
    test(
      '${outcome.name} changes only confirmed state without another read',
      () async {
        await repository.refresh();
        final before = repository.value;
        final name = tokens.firstWhere((final token) => !token.isCaller).name;
        final pending = Completer<ServerMutationResult<void>>();
        when(() => api.deleteApiToken(name)).thenAnswer((_) => pending.future);
        final command = repository.revoke(name);
        expect(repository.value.data, before.data);
        expect(await repository.revoke(name), isNull);
        expect(await repository.refresh(), RefreshResult.deferred);
        pending.complete(result(outcome));
        final completion = await command;
        expect(completion!.result!.outcome, outcome);
        expect(
          repository.value.data,
          outcome == ServerMutationOutcome.confirmed
              ? tokens.where((final token) => token.name != name).toList()
              : tokens,
        );
        expect(repository.value.updatedAt, before.updatedAt);
        expect(before.data, tokens);
        expect(
          repository.value.needsReconciliation,
          outcome != ServerMutationOutcome.confirmed,
        );
        verify(api.getApiTokens).called(1);
        verify(() => api.deleteApiToken(name)).called(1);
      },
    );
  }

  for (final fails in [false, true]) {
    test(
      'pre-command read cannot restore data or errors: fails=$fails',
      () async {
        await repository.refresh();
        final read = Completer<List<ApiToken>>();
        when(api.getApiTokens).thenAnswer((_) => read.future);
        final reading = repository.refresh(force: true);
        await pumpEventQueue();
        final name = tokens.firstWhere((final token) => !token.isCaller).name;
        when(
          () => api.deleteApiToken(name),
        ).thenAnswer((_) async => result(ServerMutationOutcome.confirmed));
        await repository.revoke(name);
        if (fails) {
          read.completeError(StateError('old read'));
        } else {
          read.complete(tokens);
        }
        expect(await reading, RefreshResult.superseded);
        expect(
          repository.value.data!.any((final token) => token.name == name),
          isFalse,
        );
        expect(repository.value.lastError, isNull);
        expect(repository.value.needsReconciliation, isTrue);
      },
    );
  }

  test(
    'coalesces reads and carries a refresh requested during a command',
    () async {
      await repository.refresh();
      final name = tokens.firstWhere((final token) => !token.isCaller).name;
      final pending = Completer<ServerMutationResult<void>>();
      when(() => api.deleteApiToken(name)).thenAnswer((_) => pending.future);
      final command = repository.revoke(name);
      expect(await repository.refresh(force: true), RefreshResult.deferred);
      pending.complete(result(ServerMutationOutcome.confirmed));
      await command;
      final read = Completer<List<ApiToken>>();
      when(api.getApiTokens).thenAnswer((_) => read.future);
      final first = repository.refresh();
      final second = repository.refresh();
      read.complete(tokens.where((final token) => token.name != name).toList());
      expect(await first, RefreshResult.applied);
      expect(await second, RefreshResult.applied);
      expect(repository.value.needsReconciliation, isFalse);
      verify(api.getApiTokens).called(2);
    },
  );

  test('unknown, current and unloaded devices cannot be revoked', () async {
    expect(await repository.revoke(tokens.last.name), isNull);
    await repository.refresh();
    expect(await repository.revoke('absent'), isNull);
    expect(
      await repository.revoke(
        tokens.firstWhere((final token) => token.isCaller).name,
      ),
      isNull,
    );
    verifyNever(() => api.deleteApiToken(any()));
  });

  test('version failure is observable and retry recovers', () async {
    when(api.fetchApiVersion).thenThrow(StateError('Version unavailable'));
    expect(await repository.refresh(), RefreshResult.failed);
    expect(repository.value.lastError, isNotNull);
    when(api.fetchApiVersion).thenAnswer((_) async => '3.6.0');
    expect(await repository.refresh(), RefreshResult.applied);
    expect(repository.value.lastError, isNull);
  });

  test('unsupported versions do not fetch or revoke', () async {
    connection.cache.setVersion(Version(2, 2, 0));
    expect(await repository.refresh(force: true), RefreshResult.unsupported);
    expect(await repository.revoke(tokens.last.name), isNull);
    verifyNever(api.getApiTokens);
  });

  test('a failed version probe after loading can be retried', () async {
    await repository.refresh();
    when(api.fetchApiVersion).thenThrow(StateError('Version unavailable'));
    await connection.cache.apiVersion.refresh(force: true);
    when(api.fetchApiVersion).thenAnswer((_) async => '3.6.0');
    expect(repository.value.lastError, isNotNull);
    expect(repository.value.data, tokens);
    expect(await repository.refresh(force: true), RefreshResult.applied);
    expect(repository.value.lastError, isNull);
  });

  for (final fails in [false, true]) {
    test(
      'a detached read cannot publish data or errors: fails=$fails',
      () async {
        await repository.refresh();
        final before = repository.value;
        final pending = Completer<List<ApiToken>>();
        when(api.getApiTokens).thenAnswer((_) => pending.future);
        final reading = repository.refresh(force: true);
        await pumpEventQueue();
        origin = null;
        if (fails) {
          pending.completeError(StateError('old failure'));
        } else {
          pending.complete(tokens);
        }
        expect(await reading, RefreshResult.disposed);
        expect(repository.value.data, before.data);
        expect(repository.value.updatedAt, before.updatedAt);
        expect(repository.value.lastError, isNull);
      },
    );
  }

  test(
    'disposing resolves version waiters and prevents a late fetch',
    () async {
      final version = Completer<String>();
      when(api.fetchApiVersion).thenAnswer((_) => version.future);
      final reading = repository.refresh();
      connection.dispose();
      expect(await reading, RefreshResult.disposed);
      version.complete('3.6.0');
      await pumpEventQueue();
      verifyNever(api.getApiTokens);
    },
  );

  test(
    'detachment preserves remote confirmation without applying it',
    () async {
      await repository.refresh();
      final name = tokens.firstWhere((final token) => !token.isCaller).name;
      final pending = Completer<ServerMutationResult<void>>();
      when(() => api.deleteApiToken(name)).thenAnswer((_) => pending.future);
      final command = repository.revoke(name);
      origin = ServerStateOrigin('replacement');
      pending.complete(result(ServerMutationOutcome.confirmed));
      final completion = (await command)!;
      expect(completion.application, CommandApplication.detached);
      expect(completion.result!.outcome, ServerMutationOutcome.confirmed);
      expect(repository.value.data, tokens);
      expect(await repository.refresh(), RefreshResult.disposed);
    },
  );
}
