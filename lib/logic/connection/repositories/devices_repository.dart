import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

class DevicesRepository {
  DevicesRepository({required this.commands, required this.reader}) {
    if (!commands.owns(_store)) {
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

  final ServerCommandCoordinator commands;
  final DomainReader<List<ApiToken>> reader;
  DomainStore<List<ApiToken>> get _store => reader.store;
  CachedValue<List<ApiToken>> get value => reader.value;
  Stream<CachedValue<List<ApiToken>>> get changes => reader.changes;

  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

  Future<ServerMutationResult<String>> createAuthorizationKey() =>
      commands.mutate(
        domains: [_store],
        send: (final api) => api.createDeviceToken(),
        applyConfirmed: (_) => [_store],
      );

  /// Returns null when the device cannot be revoked or a revocation is pending.
  Future<CommandCompletion<void>?> revoke(final String name) async {
    if (!commands.isAttached ||
        commands.isReserved(_store) ||
        value.support != DomainSupport.supported ||
        !(value.data?.any(
              (final device) => device.name == name && !device.isCaller,
            ) ??
            false)) {
      return null;
    }
    return commands.submit<void>(
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
    );
  }
}
