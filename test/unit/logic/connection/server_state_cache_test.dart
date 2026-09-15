import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/cached_value.dart';
import 'package:selfprivacy/logic/connection/server_state_cache.dart';

import '../../../fakes/graphql/link_transport.dart';
import '../../../helpers/fixtures/json_fixture.dart';

void main() {
  late Map<String, dynamic> responses;
  late List<String> requests;
  Stream<Response> Function(String)? intercept;

  setUp(() {
    responses = loadJsonFixture('graphql/domain_reads.json');
    requests = [];
    intercept = null;
  });

  ServerApi api() => ServerApi(
    transport: transportWithLink(
      Link.function((final request, [final forward]) {
        final name = request.operation.document.definitions
            .whereType<OperationDefinitionNode>()
            .single
            .name!
            .value;
        requests.add(name);
        return intercept?.call(name) ??
            Stream.value(
              Response(
                response: const {},
                data: responses[name] as Map<String, dynamic>,
              ),
            );
      }),
    ),
  );

  ServerStateCache cache(final WidgetTester tester) {
    final result = ServerStateCache(api: api(), now: tester.binding.clock.now);
    addTearDown(result.dispose);
    return result;
  }

  void version(final String value) {
    final data = responses['GetApiVersion'] as Map<String, dynamic>;
    (data['api'] as Map<String, dynamic>)['version'] = value;
  }

  testWidgets('construction and unknown domains do not request data', (
    final tester,
  ) async {
    final state = cache(tester);
    expect(requests, isEmpty);
    expect(state.apiVersion.value.support, DomainSupport.supported);
    for (final store in state.stores.skip(1)) {
      expect(store.value.support, DomainSupport.unknown);
      await store.refresh(force: true);
      expect(store.value.data, isNull);
    }
    expect(requests, isEmpty);
    state.dispose();
  });

  testWidgets('loads every typed domain through the API parsers', (
    final tester,
  ) async {
    final state = cache(tester);
    await state.apiVersion.refresh();
    expect(state.apiVersion.value.data, Version(3, 9, 0));
    for (final store in state.stores.skip(1)) {
      expect(store.value.support, DomainSupport.supported);
      await store.refresh();
      expect(store.value.lastError, isNull, reason: store.name);
      expect(store.value.data, isNotNull, reason: store.name);
      expect(store.value.freshness, Freshness.fresh);
    }
    expect(
      requests.toSet(),
      responses.keys.where((final name) => name != 'JobUpdates').toSet(),
    );
    expect(
      state.users.value.data!.map((final user) => user.login),
      contains('alice'),
    );
    expect(state.groups.value.data, contains('sp.nextcloud.users'));
    expect(state.services.value.data, hasLength(3));
    expect(state.volumes.value.data, hasLength(2));
    expect(state.devices.value.data, hasLength(2));
    expect(state.backups.value.data, hasLength(1));
    expect(state.serverJobs.value.data, hasLength(1));
    state.dispose();
  });

  testWidgets('registry preserves refresh policies and is immutable', (
    final tester,
  ) async {
    final state = cache(tester);
    const intervals = {
      'apiVersion': 60,
      'serverJobs': 10,
      'backupConfig': 120,
      'backups': 120,
      'services': 60,
      'volumes': 60,
      'recoveryKeyStatus': 300,
      'devices': 60,
      'users': 60,
      'groups': 60,
      'settings': 600,
    };
    expect(state.stores.map((final store) => store.name), intervals.keys);
    for (final store in state.stores) {
      expect(store.refreshInterval, Duration(seconds: intervals[store.name]!));
      expect(store.staleAfter, store.refreshInterval * 2);
    }
    expect(state.stores.clear, throwsUnsupportedError);
    state.dispose();
  });

  test('validates and applies per-domain stale deadlines', () {
    final state = ServerStateCache(
      api: api(),
      staleAfterOverrides: const {
        'apiVersion': Duration(minutes: 5),
        'serverJobs': Duration(seconds: 45),
      },
    );
    expect(state.apiVersion.staleAfter, const Duration(minutes: 5));
    expect(state.serverJobs.staleAfter, const Duration(seconds: 45));
    state.dispose();
    expect(
      () => ServerStateCache(
        api: api(),
        staleAfterOverrides: const {'typo': Duration(minutes: 5)},
      ),
      throwsArgumentError,
    );
    expect(
      () => ServerStateCache(
        api: api(),
        staleAfterOverrides: const {'users': Duration(seconds: 60)},
      ),
      throwsArgumentError,
    );
  });

  for (final entry in <String, Set<String>>{
    '2.2.9': {},
    '2.3.0': {
      'serverJobs',
      'volumes',
      'recoveryKeyStatus',
      'devices',
      'users',
      'settings',
    },
    '2.4.2': {
      'serverJobs',
      'volumes',
      'recoveryKeyStatus',
      'devices',
      'users',
      'settings',
      'backups',
      'backupConfig',
    },
    '2.4.3': {
      'serverJobs',
      'volumes',
      'recoveryKeyStatus',
      'devices',
      'users',
      'settings',
      'backups',
      'backupConfig',
      'services',
    },
    '3.6.0': {
      'serverJobs',
      'volumes',
      'recoveryKeyStatus',
      'devices',
      'users',
      'settings',
      'backups',
      'backupConfig',
      'services',
      'groups',
    },
  }.entries) {
    testWidgets('applies capability boundaries at ${entry.key}', (
      final tester,
    ) async {
      version(entry.key);
      final state = cache(tester);
      await state.apiVersion.refresh();
      for (final store in state.stores.skip(1)) {
        expect(
          store.value.support,
          entry.value.contains(store.name)
              ? DomainSupport.supported
              : DomainSupport.unsupported,
          reason: store.name,
        );
        if (!entry.value.contains(store.name)) {
          await store.refresh(force: true);
        }
      }
      expect(requests, ['GetApiVersion']);
      state.dispose();
    });
  }

  testWidgets('invalid initial version keeps support unknown and can recover', (
    final tester,
  ) async {
    version('invalid');
    final state = cache(tester);
    await state.apiVersion.refresh();
    expect(state.apiVersion.value.lastError, isNotNull);
    expect(state.apiVersion.value.data, isNull);
    expect(state.users.value.support, DomainSupport.unknown);
    version('3.9.0');
    await state.apiVersion.refresh();
    expect(state.apiVersion.value.lastError, isNull);
    expect(state.users.value.support, DomainSupport.supported);
    state.dispose();
  });

  testWidgets('same version and failed version refresh retain domain state', (
    final tester,
  ) async {
    final state = cache(tester);
    await state.apiVersion.refresh();
    await state.users.refresh();
    final users = state.users.value;
    await state.apiVersion.refresh(force: true);
    expect(state.users.value, same(users));
    intercept = (final name) => Stream.error(StateError('offline'));
    await state.apiVersion.refresh(force: true);
    expect(state.apiVersion.value.lastError, isNotNull);
    expect(state.apiVersion.value.data, Version(3, 9, 0));
    expect(state.users.value, same(users));
    state.dispose();
  });

  testWidgets('downgrade supersedes an in-flight domain fetch', (
    final tester,
  ) async {
    final state = cache(tester);
    await state.apiVersion.refresh();
    final pending = Completer<Response>();
    intercept = (final name) => name == 'AllGroups'
        ? Stream.fromFuture(pending.future)
        : Stream.value(
            Response(
              response: const {},
              data: responses[name] as Map<String, dynamic>,
            ),
          );
    final refresh = state.groups.refresh();
    await tester.pump();
    version('3.5.0');
    await state.apiVersion.refresh(force: true);
    expect(state.groups.value.support, DomainSupport.unsupported);
    pending.complete(
      Response(
        response: const {},
        data: responses['AllGroups'] as Map<String, dynamic>,
      ),
    );
    await refresh;
    expect(state.groups.value.data, isNull);
    version('3.6.0');
    await state.apiVersion.refresh(force: true);
    await state.groups.refresh();
    expect(state.groups.value.data, isNotEmpty);
    state.dispose();
  });

  testWidgets('instances are isolated and disposal does not close their API', (
    final tester,
  ) async {
    final sharedApi = api();
    final first = ServerStateCache(
      api: sharedApi,
      now: tester.binding.clock.now,
    );
    final second = ServerStateCache(
      api: sharedApi,
      now: tester.binding.clock.now,
    );
    addTearDown(first.dispose);
    addTearDown(second.dispose);
    await first.apiVersion.refresh();
    await second.apiVersion.refresh();
    await first.users.refresh();
    expect(second.users.value.data, isNull);
    first
      ..dispose()
      ..dispose();
    await second.users.refresh();
    expect(second.users.value.data, isNotEmpty);
    expect(await sharedApi.fetchApiVersion(), '3.9.0');
    for (final store in first.stores) {
      expect(store.refresh, throwsStateError);
    }
    second.dispose();
  });

  testWidgets(
    'disposal resolves pending version refresh and ignores its result',
    (final tester) async {
      final pending = Completer<Response>();
      intercept = (final name) => Stream.fromFuture(pending.future);
      final state = cache(tester);
      final refresh = state.apiVersion.refresh();
      await tester.pump();
      state.dispose();
      await refresh;
      pending.complete(
        Response(
          response: const {},
          data: responses['GetApiVersion'] as Map<String, dynamic>,
        ),
      );
      await tester.pump();
      expect(state.apiVersion.value.data, isNull);
      expect(state.users.value.support, DomainSupport.unknown);
    },
  );
}
