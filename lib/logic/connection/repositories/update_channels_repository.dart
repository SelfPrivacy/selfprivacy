import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/update_channels.dart';

class UpdateChannelsRepository {
  UpdateChannelsRepository({required this.reader, required this.commands}) {
    if (!commands.owns(reader.store)) {
      throw ArgumentError('Channels store belongs to another connection.');
    }
  }

  final DomainReader<UpdateChannels> reader;
  final ServerCommandCoordinator commands;

  CachedValue<UpdateChannels> get value => reader.value;
  Stream<CachedValue<UpdateChannels>> get changes => reader.changes;
  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

  Future<ServerMutationResult<void>> setChannel(final String channelId) =>
      commands.mutate(
        domains: [reader.store],
        send: (final api) => api.setUpdateChannel(channelId),
      );
}
