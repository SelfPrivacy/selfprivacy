import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
import 'package:selfprivacy/logic/models/hive/email_password_metadata.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../../helpers/fixtures/json_fixture.dart';

void main() {
  test('GraphQL construction detaches and freezes lists', () {
    final source = aUserWithEmailPasswords();
    final fragment = Fragment$userFields.fromJson(
      loadJsonFixture('graphql/user_with_email_passwords.json'),
    );
    final user = User.fromGraphQL(fragment);
    fragment.sshKeys!.add('another-key');
    fragment.directmemberof!.clear();
    fragment.memberof!.clear();
    fragment.emailPasswordMetadata!.clear();
    expect(user.sshKeys, source.sshKeys);
    expect(user.directmemberof, source.directmemberof);
    expect(user.memberof, source.memberof);
    expect(user.emailPasswordMetadata, source.emailPasswordMetadata);
    expect(user.sshKeys.clear, throwsUnsupportedError);
    expect(user.directmemberof!.clear, throwsUnsupportedError);
    expect(user.memberof!.clear, throwsUnsupportedError);
    expect(user.emailPasswordMetadata!.clear, throwsUnsupportedError);
  });

  group('Hive', () {
    setUp(setUpInMemoryHive);
    tearDown(tearDownInMemoryHive);

    test('restores immutable users without changing stored values', () async {
      Hive.registerAdapter(EmailPasswordMetadataAdapter());
      final source = aUserWithEmailPasswords();
      final box = await Hive.openBox<User>('immutable_users');
      await box.put('user', source);
      await box.close();
      final restoredBox = await Hive.openBox<User>('immutable_users');
      final restored = restoredBox.get('user')!;
      expect(restored, source);
      expect(restored, isNot(same(source)));
      expect(restored.sshKeys.clear, throwsUnsupportedError);
      expect(restored.directmemberof!.clear, throwsUnsupportedError);
      expect(restored.memberof!.clear, throwsUnsupportedError);
      expect(restored.emailPasswordMetadata!.clear, throwsUnsupportedError);
    });
  });

  for (final constructor in ['default', 'fake', 'copyWith']) {
    test('$constructor detaches and freezes nested lists', () {
      final source = aUserWithEmailPasswords();
      final keys = List.of(source.sshKeys);
      final directGroups = List.of(source.directmemberof!);
      final groups = List.of(source.memberof!);
      final passwords = List.of(source.emailPasswordMetadata!);
      final copy = switch (constructor) {
        'default' => User(
          login: source.login,
          type: source.type,
          sshKeys: keys,
          directmemberof: directGroups,
          memberof: groups,
          emailPasswordMetadata: passwords,
        ),
        'fake' => User.fake(
          sshKeys: keys,
          directmemberof: directGroups,
          memberof: groups,
          emailPasswordMetadata: passwords,
        ),
        _ => source.copyWith(
          sshKeys: keys,
          directmemberof: directGroups,
          memberof: groups,
          emailPasswordMetadata: passwords,
        ),
      };
      keys.add('another-key');
      directGroups.add('another-direct-group');
      groups.add('another-group');
      passwords.clear();
      expect(copy.sshKeys, source.sshKeys);
      expect(copy.directmemberof, source.directmemberof);
      expect(copy.memberof, source.memberof);
      expect(copy.emailPasswordMetadata, source.emailPasswordMetadata);
      expect(copy.sshKeys.clear, throwsUnsupportedError);
      expect(copy.directmemberof!.clear, throwsUnsupportedError);
      expect(copy.memberof!.clear, throwsUnsupportedError);
      expect(copy.emailPasswordMetadata!.clear, throwsUnsupportedError);
    });
  }

  test('constructor preserves absent optional lists', () {
    final copy = User.fake();
    expect(copy.directmemberof, isNull);
    expect(copy.memberof, isNull);
    expect(copy.emailPasswordMetadata, isNull);
    expect(copy.sshKeys, isEmpty);
    expect(copy.sshKeys.clear, throwsUnsupportedError);
  });

  test('server-visible fields participate in equality', () {
    final base = User.fake(
      email: 'alice@example.test',
      displayName: 'Alice',
      directmemberof: const ['sp.full_users'],
      memberof: const ['sp.full_users'],
    );

    expect(
      base,
      isNot(
        User.fake(
          email: 'alice@example.test',
          displayName: 'Alice',
          directmemberof: const [],
          memberof: const [],
        ),
      ),
    );
    expect(
      base,
      isNot(
        User.fake(
          email: 'alice@example.test',
          displayName: 'Alice Cooper',
          directmemberof: const ['sp.full_users'],
          memberof: const ['sp.full_users'],
        ),
      ),
    );
  });
}
