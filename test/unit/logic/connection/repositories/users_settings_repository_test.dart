import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';

import '../../../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../../../helpers/fixtures/json_fixture.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      AutoUpgradeSettings(enable: false, allowReboot: false),
    );
    registerFallbackValue(SshSettings(enable: false));
  });
  late _Api api;
  late ServerConnection connection;
  setUp(() {
    api = _Api();
    final origin = ServerStateOrigin('server');
    connection = ServerConnection(
      api: api,
      origin: origin,
      currentOrigin: () => origin,
    )..cache.setVersion(Version(3, 6, 0));
  });
  tearDown(() => connection.dispose());

  test(
    'a complete user read replaces the pre-load projection and freezes rows',
    () async {
      final user = aMutationUser('CreateUser');
      when(
        () => api.createUser(user.login, user.displayName, user.directmemberof),
      ).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(user),
        ),
      );
      await connection.users.createUser(user);
      when(api.getAllUsers).thenAnswer((_) async => []);
      await connection.users.refresh(force: true);
      expect(connection.users.knownUsers, isEmpty);
      when(api.getAllUsers).thenAnswer((_) async => [user]);
      await connection.users.refresh(force: true);
      expect(connection.users.knownUsers, [user]);
      expect(
        connection.users.value.data!.single.directmemberof!.clear,
        throwsUnsupportedError,
      );
    },
  );

  test('email deletion updates a pre-load confirmed user projection', () async {
    final user = aUserWithEmailPasswords();
    when(
      () => api.createUser(user.login, user.displayName, user.directmemberof),
    ).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(user),
      ),
    );
    await connection.users.createUser(user);
    final uuid = user.emailPasswordMetadata!.first.uuid;
    when(() => api.deleteEmailPassword(user.login, uuid)).thenAnswer(
      (_) async => ServerMutationResult<void>(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    await connection.users.deleteEmailPassword(user, uuid);
    expect(
      connection.users.knownUsers.single.emailPasswordMetadata!.any(
        (final metadata) => metadata.uuid == uuid,
      ),
      isFalse,
    );
    expect(connection.users.value.data, isNull);
  });

  for (final outcome in [
    ServerMutationOutcome.rejected,
    ServerMutationOutcome.indeterminate,
  ]) {
    test('user deletion preserves rows on $outcome', () async {
      final user = aMutationUser('CreateUser');
      connection.users.store.push([user]);
      when(() => api.deleteUser(user.login)).thenAnswer(
        (_) async => ServerMutationResult<void>(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await connection.users.deleteUser(user);
      expect(connection.users.value.data, [user]);
    });
  }

  test('confirmed user deletion removes only that identity', () async {
    final user = aMutationUser('CreateUser');
    connection.users.store.push([user]);
    when(() => api.deleteUser(user.login)).thenAnswer(
      (_) async => ServerMutationResult<void>(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    await connection.users.deleteUser(user);
    expect(connection.users.value.data, isEmpty);
  });

  for (final add in [true, false]) {
    test('SSH command uses returned user: add=$add', () async {
      final user = aMutationUser('CreateUser');
      final returned = aMutationUser(add ? 'AddSshKey' : 'RemoveSshKey');
      connection.users.store.push([user]);
      final call = add ? api.addSshKey : api.removeSshKey;
      when(() => call(user.login, 'submitted-key')).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(returned),
        ),
      );
      if (add) {
        await connection.users.addSshKey(user, 'submitted-key');
      } else {
        await connection.users.deleteSshKey(user, 'submitted-key');
      }
      expect(connection.users.value.data, [returned]);
    });
  }

  test(
    'missing user payload requests reconciliation without fabricating success data',
    () async {
      final user = aMutationUser('CreateUser');
      connection.users.store.push([user]);
      when(
        () => api.updateUser(user.login, user.displayName, user.directmemberof),
      ).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.missing(),
        ),
      );
      await connection.users.updateUser(user);
      expect(connection.users.value.data, [user]);
      expect(connection.users.value.needsReconciliation, isTrue);
    },
  );

  test(
    'password reset secret is returned only to caller without entering user state',
    () async {
      final user = aMutationUser('CreateUser');
      connection.users.store.push([user]);
      final before = connection.users.value;
      when(() => api.generatePasswordResetLink(user.login)).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available(
            'https://example.org/reset/secret',
          ),
        ),
      );
      final result = await connection.users.generatePasswordResetLink(user);
      expect(result.confirmedSecret, 'https://example.org/reset/secret');
      expect(connection.users.value.data, same(before.data));
      expect(connection.users.value.needsReconciliation, isFalse);
    },
  );

  test('returned SSH and upgrade settings override submitted values', () async {
    final fixture = loadJsonFixture('graphql/domain_reads.json');
    final settings = SystemSettings.fromGraphQL(
      Query$SystemSettings.fromJson(
        fixture['SystemSettings'] as Map<String, dynamic>,
      ).system,
    );
    connection.settings.store.push(settings);
    final before = connection.settings.value;
    when(() => api.setSshSettings(any())).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(SshSettings(enable: false)),
      ),
    );
    when(() => api.setAutoUpgradeSettings(any())).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(
          AutoUpgradeSettings(enable: false, allowReboot: false),
        ),
      ),
    );
    await connection.settings.setSshSettings(enable: true);
    await connection.settings.setAutoUpgradeSettings(
      enable: true,
      allowReboot: true,
    );
    expect(connection.settings.value.data!.sshSettings.enable, isFalse);
    expect(connection.settings.value.data!.autoUpgradeSettings.enable, isFalse);
    expect(
      connection.settings.value.data!.autoUpgradeSettings.allowReboot,
      isFalse,
    );
    expect(connection.settings.value.updatedAt, before.updatedAt);
  });

  test('pre-load timezone does not invent complete settings', () async {
    when(() => api.setTimezone('UTC')).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available('UTC'),
      ),
    );
    await connection.settings.setServerTimezone('UTC');
    expect(connection.settings.value.data, isNull);
    expect(connection.settings.value.needsReconciliation, isTrue);
  });

  test(
    'duplicate creation and protected root commands never reach transport',
    () async {
      final user = aMutationUser('CreateUser');
      connection.users.store.push([user]);
      expect(
        (await connection.users.createUser(user)).outcome,
        ServerMutationOutcome.rejected,
      );
      final root = user.copyWith(login: 'root', type: UserType.root);
      expect(
        (await connection.users.deleteUser(root)).outcome,
        ServerMutationOutcome.rejected,
      );
      expect(
        (await connection.users.generatePasswordResetLink(root)).outcome,
        ServerMutationOutcome.rejected,
      );
      verifyZeroInteractions(api);
    },
  );

  test(
    'timezone response patches only its field and preserves full snapshot age',
    () async {
      final fixture = loadJsonFixture('graphql/domain_reads.json');
      final settings = SystemSettings.fromGraphQL(
        Query$SystemSettings.fromJson(
          fixture['SystemSettings'] as Map<String, dynamic>,
        ).system,
      );
      connection.settings.store.push(settings);
      final before = connection.settings.value;
      when(() => api.setTimezone('Etc/UTC')).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('UTC'),
        ),
      );
      await connection.settings.setServerTimezone('Etc/UTC');
      expect(connection.settings.value.data!.timezone, 'UTC');
      expect(
        connection.settings.value.data!.sshSettings,
        same(settings.sshSettings),
      );
      expect(connection.settings.value.updatedAt, before.updatedAt);
    },
  );

  test('returned user replaces one row without renewing list age', () async {
    final user = aMutationUser('CreateUser');
    final updated = aMutationUser('UpdateUser');
    final other = User.fromGraphQL(
      Query$AllUsers.fromJson(
        loadJsonFixture('graphql/domain_reads.json')['AllUsers']
            as Map<String, dynamic>,
      ).users.allUsers.first,
    );
    connection.users.store.push([user, other]);
    final before = connection.users.value;
    when(
      () => api.updateUser(user.login, user.displayName, user.directmemberof),
    ).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(updated),
      ),
    );
    await connection.users.updateUser(user);
    expect(connection.users.value.data, [updated, other]);
    expect(before.data, [user, other]);
    expect(connection.users.value.updatedAt, before.updatedAt);
    expect(() => connection.users.value.data!.clear(), throwsUnsupportedError);
  });

  test(
    'pre-load creation retains an entity without inventing a complete list',
    () async {
      final user = aMutationUser('CreateUser');
      when(
        () => api.createUser(user.login, user.displayName, user.directmemberof),
      ).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(user),
        ),
      );
      await connection.users.createUser(user);
      expect(connection.users.value.data, isNull);
      expect(connection.users.knownUsers, [user]);
      expect(connection.users.value.needsReconciliation, isTrue);
    },
  );

  test('email credential deletion changes only confirmed metadata', () async {
    final user = aUserWithEmailPasswords();
    connection.users.store.push([user]);
    final uuid = user.emailPasswordMetadata!.first.uuid;
    when(() => api.deleteEmailPassword(user.login, uuid)).thenAnswer(
      (_) async => ServerMutationResult<void>(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.notExpected(),
      ),
    );
    await connection.users.deleteEmailPassword(user, uuid);
    expect(
      connection.users.value.data!.single.emailPasswordMetadata!.any(
        (final item) => item.uuid == uuid,
      ),
      isFalse,
    );
    expect(
      user.emailPasswordMetadata!.any((final item) => item.uuid == uuid),
      isTrue,
    );
  });

  final userCalls = <String, Future<ServerMutationResult<User>> Function(User)>{
    'CreateUser': (final user) => connection.users.createUser(user),
    'UpdateUser': (final user) => connection.users.updateUser(user),
    'AddSshKey': (final user) =>
        connection.users.addSshKey(user, 'fixture-key'),
    'RemoveSshKey': (final user) =>
        connection.users.deleteSshKey(user, 'fixture-key'),
  };
  for (final call in userCalls.entries) {
    for (final outcome in [
      ServerMutationOutcome.rejected,
      ServerMutationOutcome.indeterminate,
    ]) {
      test('${call.key} never applies a $outcome payload', () async {
        final user = aMutationUser(call.key);
        final response = Future.value(
          ServerMutationResult<User>(
            outcome: outcome,
            payload: ServerMutationPayload.available(user),
          ),
        );
        when(
          () => api.createUser(any(), any(), any()),
        ).thenAnswer((_) => response);
        when(
          () => api.updateUser(any(), any(), any()),
        ).thenAnswer((_) => response);
        when(() => api.addSshKey(any(), any())).thenAnswer((_) => response);
        when(() => api.removeSshKey(any(), any())).thenAnswer((_) => response);
        connection.users.store.push([]);
        expect((await call.value(user)).outcome, outcome);
        expect(connection.users.knownUsers, isEmpty);
        expect(connection.users.value.needsReconciliation, isTrue);
      });
    }
  }

  test('in-flight user update upserts against the latest snapshot', () async {
    final user = aMutationUser('UpdateUser');
    final response = Completer<ServerMutationResult<User>>();
    when(
      () => api.updateUser(any(), any(), any()),
    ).thenAnswer((_) => response.future);
    connection.users.store.push([]);
    final pending = connection.users.updateUser(user);
    final other = User.fake(login: 'other');
    connection.users.store.push([aMutationUser('CreateUser'), other]);
    final changed = connection.users.changes.firstWhere(
      (final value) => value.data?.first == user,
    );
    response.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(user),
      ),
    );
    await pending;
    expect((await changed).data, [user, other]);
  });

  test('detached user completion cannot publish into its old store', () async {
    final user = aMutationUser('UpdateUser');
    final response = Completer<ServerMutationResult<User>>();
    when(
      () => api.updateUser(any(), any(), any()),
    ).thenAnswer((_) => response.future);
    final pending = connection.users.updateUser(user);
    connection.dispose();
    response.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(user),
      ),
    );
    expect((await pending).outcome, ServerMutationOutcome.indeterminate);
    expect(connection.users.knownUsers, isEmpty);
  });

  for (final outcome in [
    ServerMutationOutcome.rejected,
    ServerMutationOutcome.indeterminate,
  ]) {
    test('$outcome settings payload never changes the cache', () async {
      final original = SystemSettings.fromGraphQL(
        Query$SystemSettings.fromJson(
          loadJsonFixture('graphql/domain_reads.json')['SystemSettings']
              as Map<String, dynamic>,
        ).system,
      );
      connection.settings.store.push(original);
      when(() => api.setTimezone(any())).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: outcome,
          payload: const ServerMutationPayload.available('UTC'),
        ),
      );
      await connection.settings.setServerTimezone('UTC');
      expect(connection.settings.value.data, same(original));
      expect(connection.settings.value.needsReconciliation, isTrue);
    });

    test('$outcome email-password deletion preserves metadata', () async {
      final user = aUserWithEmailPasswords();
      connection.users.store.push([user]);
      when(() => api.deleteEmailPassword(user.login, 'remove')).thenAnswer(
        (_) async => ServerMutationResult<void>(
          outcome: outcome,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await connection.users.deleteEmailPassword(user, 'remove');
      expect(
        connection.users.value.data!.single.emailPasswordMetadata,
        user.emailPasswordMetadata,
      );
    });
  }
}
