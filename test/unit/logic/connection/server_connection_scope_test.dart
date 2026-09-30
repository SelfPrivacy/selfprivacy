import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/server_connection_scope.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';

import '../../../helpers/fixtures/server_fixtures.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  late Server? selected;
  late StreamController<void> updates;
  late ServerConnectionScope scope;
  late List<ServerConnectionBinding> bindings;
  late List<void Function()> authFailures;
  var unauthorized = 0;

  setUp(() {
    selected = aServer();
    updates = StreamController<void>.broadcast();
    bindings = [];
    authFailures = [];
    unauthorized = 0;
    scope = ServerConnectionScope(
      selectServer: () => selected,
      serverChanges: updates.stream,
      createApi: (final binding, final onAuthFailure) {
        bindings.add(binding);
        authFailures.add(onAuthFailure);
        return _Api();
      },
      onAuthFailure: () => unauthorized++,
    );
  });
  tearDown(() async {
    scope.dispose();
    await updates.close();
  });

  test(
    'selection is lazy and unchanged resources reuse the connection',
    () async {
      expect(bindings, isEmpty);
      final first = scope.current!;
      selected = aServer(
        hostingDetails: aServerHostingDetails(ip4: '203.0.113.20'),
      );
      updates.add(null);
      await pumpEventQueue();
      expect(scope.current, same(first));
      expect(bindings, hasLength(1));
      expect(
        first.stores.map((final store) => store.name),
        containsAll([
          'devices',
          'users',
          'serverJobs',
          'settings',
          'services',
          'backups',
          'backupConfig',
          'volumes',
        ]),
      );
    },
  );

  for (final field in ['server', 'domain', 'credential']) {
    test(
      '$field replacement disposes stores and fences auth callbacks',
      () async {
        final old = scope.current!;
        selected = switch (field) {
          'server' => aServer(uuid: 'replacement'),
          'domain' => aServer(
            domain: aServerDomain(domainName: 'replacement.example.org'),
          ),
          _ => aServer(
            hostingDetails: aServerHostingDetails(
              apiToken: 'replacement-secret',
            ),
          ),
        };
        authFailures.first();
        expect(unauthorized, 0);
        updates.add(null);
        await pumpEventQueue();
        final replacement = scope.current!;
        expect(replacement, isNot(same(old)));
        expect(old.isAttached, isFalse);
        expect(old.stores.every((final store) => store.isDisposed), isTrue);
        authFailures.last();
        expect(unauthorized, 1);
        expect(bindings.last.toString(), isNot(contains('replacement-secret')));
      },
    );
  }

  test(
    'clear stays detached until explicit resume, even for the same target',
    () async {
      final old = scope.current!;
      scope.clear();
      updates.add(null);
      await pumpEventQueue();
      expect(scope.current, isNull);
      expect(bindings, hasLength(1));
      authFailures.first();
      expect(unauthorized, 0);
      scope.resume();
      expect(scope.current, isNot(same(old)));
      expect(scope.current!.origin, isNot(same(old.origin)));
    },
  );

  test(
    'removal publishes absence without retaining old session data',
    () async {
      final old = scope.current!;
      await pumpEventQueue();
      final change = scope.changes.first;
      selected = null;
      updates.add(null);
      await change;
      expect(scope.current, isNull);
      expect(old.isAttached, isFalse);
      expect(bindings, hasLength(1));
    },
  );

  test('disposal prevents selection, resume and late authentication', () async {
    final old = scope.current!;
    scope.dispose();
    selected = aServer(uuid: 'replacement');
    updates.add(null);
    scope.resume();
    await pumpEventQueue();
    authFailures.first();
    expect(unauthorized, 0);
    expect(scope.current, isNull);
    expect(old.isAttached, isFalse);
    expect(bindings, hasLength(1));
  });
}
