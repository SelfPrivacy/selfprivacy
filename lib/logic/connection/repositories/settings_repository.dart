import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';

class SettingsRepository {
  SettingsRepository({required this.commands, required this.reader}) {
    if (!commands.owns(store)) {
      throw ArgumentError('Settings store belongs to another connection.');
    }
  }

  final ServerCommandCoordinator commands;
  final DomainReader<SystemSettings> reader;
  DomainStore<SystemSettings> get store => reader.store;

  CachedValue<SystemSettings> get value => reader.value;
  Stream<CachedValue<SystemSettings>> get changes => reader.changes;
  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

  Future<ServerMutationResult<AutoUpgradeSettings>> setAutoUpgradeSettings({
    required final bool enable,
    required final bool allowReboot,
  }) => _patch(
    (final api) => api.setAutoUpgradeSettings(
      AutoUpgradeSettings(enable: enable, allowReboot: allowReboot),
    ),
    (final current, final returned) =>
        current.copyWith(autoUpgradeSettings: returned),
  );

  Future<ServerMutationResult<String>> setServerTimezone(
    final String timezone,
  ) => _patch(
    (final api) => api.setTimezone(timezone),
    (final current, final returned) => current.copyWith(timezone: returned),
  );

  Future<ServerMutationResult<SshSettings>> setSshSettings({
    required final bool enable,
  }) => _patch(
    (final api) => api.setSshSettings(SshSettings(enable: enable)),
    (final current, final returned) => current.copyWith(sshSettings: returned),
  );

  Future<ServerMutationResult<T>> _patch<T>(
    final Future<ServerMutationResult<T>> Function(ServerApi) send,
    final SystemSettings Function(SystemSettings, T) reduce,
  ) => commands.mutate(
    domains: [store],
    send: send,
    applyConfirmed: (final result) {
      final returned = result.payload.value;
      if (returned == null) {
        return [];
      }
      final applied = store.patch((final current) => reduce(current, returned));
      return applied ? [store] : [];
    },
  );
}
