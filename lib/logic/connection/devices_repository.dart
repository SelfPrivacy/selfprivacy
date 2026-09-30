import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/cached_value.dart';
import 'package:selfprivacy/logic/connection/domain_store.dart';
import 'package:selfprivacy/logic/connection/server_command_coordinator.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

class DevicesRepository {
  DevicesRepository({
    required this.connection,
    required final DomainStore<List<ApiToken>> store,
  }) : _store = store {
    if (!connection.commands.owns(store)) {
      throw ArgumentError('Device store belongs to another connection.');
    }
  }

  static Future<List<ApiToken>> fetch(final ServerApi api) async {
    final values = await api.getApiTokens();
    if (!values.any((final device) => device.isCaller)) {
      throw StateError('Device snapshot has no current device.');
    }
    return List.unmodifiable(values);
  }

  final ServerConnection connection;
  final DomainStore<List<ApiToken>> _store;
  CachedValue<List<ApiToken>> get value => connection.snapshot(_store);
  Stream<CachedValue<List<ApiToken>>> get changes =>
      connection.changes.map((_) => value);

  Future<RefreshResult> refresh({final bool force = false}) =>
      connection.refresh(_store, force: force);

  /// Returns null when the device cannot be revoked or a revocation is pending.
  Future<CommandCompletion<void>?> revoke(final String name) async {
    final commands = connection.commands;
    if (!connection.isAttached ||
        commands.isReserved(_store) ||
        value.support != DomainSupport.supported ||
        !(value.data?.any(
              (final device) => device.name == name && !device.isCaller,
            ) ??
            false)) {
      return null;
    }
    return commands
        .submit<void>(
          domains: [_store],
          send: (final api) => api.deleteApiToken(name),
          applyConfirmed: (_) {
            _store.patch(
              (final devices) => List.unmodifiable(
                devices.where((final device) => device.name != name),
              ),
            );
            return [_store];
          },
        )
        .completion;
  }

  void invalidate() {
    if (connection.isAttached) {
      _store.invalidate();
    }
  }
}
