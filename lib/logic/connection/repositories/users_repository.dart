import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

class UsersRepository {
  UsersRepository({required this.connection, required this.store}) {
    if (!connection.commands.owns(store)) {
      throw ArgumentError('User store belongs to another connection.');
    }
  }

  final ServerConnection connection;
  final DomainStore<List<User>> store;
  final Map<String, User> _known = {};
  int _knownReadRevision = 0;

  static Future<List<User>> fetch(final ServerApi api) async =>
      List.unmodifiable(await api.getAllUsers());

  CachedValue<List<User>> get value => connection.snapshot(store);
  Stream<CachedValue<List<User>>> get changes =>
      connection.changes.map((_) => value);
  List<User> get knownUsers {
    _clearReconciled();
    return List.unmodifiable(value.data ?? _known.values);
  }

  void _clearReconciled() {
    if (_knownReadRevision != store.readRevision) {
      _known.clear();
      _knownReadRevision = store.readRevision;
    }
  }

  Future<RefreshResult> refresh({final bool force = false}) =>
      connection.refresh(store, force: force);

  void invalidate() {
    if (connection.isAttached) {
      store.invalidate();
    }
  }

  Future<ServerMutationResult<User>> createUser(final User user) => _upsert(
    (final api) =>
        knownUsers.any(
          (final current) =>
              current.login == user.login && current.isFoundOnServer,
        )
        ? Future.value(_rejected<User>('users.user_already_exists'))
        : api.createUser(user.login, user.displayName, user.directmemberof),
  );

  ServerMutationResult<T> _rejected<T>(final String message) =>
      ServerMutationResult(
        outcome: ServerMutationOutcome.rejected,
        payload: const ServerMutationPayload.notExpected(),
        message: message,
      );
  Future<ServerMutationResult<User>> updateUser(final User user) => _upsert(
    (final api) =>
        api.updateUser(user.login, user.displayName, user.directmemberof),
  );
  Future<ServerMutationResult<User>> addSshKey(
    final User user,
    final String key,
  ) => _upsert((final api) => api.addSshKey(user.login, key));
  Future<ServerMutationResult<User>> deleteSshKey(
    final User user,
    final String key,
  ) => _upsert((final api) => api.removeSshKey(user.login, key));

  Future<ServerMutationResult<User>> _upsert(
    final Future<ServerMutationResult<User>> Function(ServerApi) send,
  ) => connection.mutate(
    domains: [store],
    send: send,
    applyConfirmed: (final result) {
      final user = result.payload.value;
      if (user == null) {
        return [];
      }
      _clearReconciled();
      final applied = store.patch(
        (final users) => List.unmodifiable([
          for (final current in users)
            if (current.login != user.login) current else user,
          if (!users.any((final current) => current.login == user.login)) user,
        ]),
      );
      if (!applied) {
        _known[user.login] = user;
      }
      return applied ? [store] : [];
    },
  );

  Future<ServerMutationResult<void>> deleteUser(final User user) =>
      connection.mutate(
        domains: [store],
        send: (final api) => user.type == UserType.root
            ? Future.value(_rejected<void>('users.user_delete_protected'))
            : api.deleteUser(user.login),
        applyConfirmed: (_) {
          _clearReconciled();
          _known.remove(user.login);
          return store.patch(
                (final users) => List.unmodifiable(
                  users.where((final current) => current.login != user.login),
                ),
              )
              ? [store]
              : [];
        },
      );

  Future<ServerMutationResult<void>> deleteEmailPassword(
    final User user,
    final String uuid,
  ) => connection.mutate(
    domains: [store],
    send: (final api) => api.deleteEmailPassword(user.login, uuid),
    applyConfirmed: (_) {
      _clearReconciled();
      var covered = false;
      User removeCredential(final User current) {
        if (current.login != user.login ||
            current.emailPasswordMetadata == null) {
          return current;
        }
        covered = true;
        return current.copyWith(
          emailPasswordMetadata: current.emailPasswordMetadata!
              .where((final metadata) => metadata.uuid != uuid)
              .toList(),
        );
      }

      final known = _known[user.login];
      if (known != null) {
        _known[user.login] = removeCredential(known);
      }
      covered = false;
      store.patch(
        (final users) => List.unmodifiable(users.map(removeCredential)),
      );
      return covered ? [store] : [];
    },
  );

  Future<ServerMutationResult<String>> generatePasswordResetLink(
    final User user,
  ) => connection.mutate(
    domains: [store],
    send: (final api) => user.type == UserType.root
        ? Future.value(_rejected<String>('users.user_modify_protected'))
        : api.generatePasswordResetLink(user.login),
    applyConfirmed: (_) => [store],
  );
}
