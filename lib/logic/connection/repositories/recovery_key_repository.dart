import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';

class RecoveryKeyRepository {
  RecoveryKeyRepository({required this.commands, required this.reader}) {
    if (!commands.owns(reader.store)) {
      throw ArgumentError('Recovery key store belongs to another connection.');
    }
  }

  final ServerCommandCoordinator commands;
  final DomainReader<RecoveryKeyStatus> reader;
  CachedValue<RecoveryKeyStatus> get value => reader.value;
  Stream<CachedValue<RecoveryKeyStatus>> get changes => reader.changes;

  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

  Future<ServerMutationResult<String>> generate({
    final DateTime? expirationDate,
    final int? numberOfUses,
  }) => commands.mutate(
    domains: [reader.store],
    send: (final api) =>
        api.generateRecoveryToken(expirationDate, numberOfUses),
  );
}
