import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';

class VolumesRepository {
  VolumesRepository({required this.connection, required this.store});

  final ServerConnection connection;
  final DomainStore<List<ServerDiskVolume>> store;

  void invalidate() {
    if (connection.isAttached) {
      store.invalidate();
    }
  }

  Future<ServerMutationResult<void>> resize(final String name) => connection
      .mutate(domains: [store], send: (final api) => api.resizeVolume(name));

  Future<ServerMutationResult<void>> reboot() => connection.mutate(
    domains: [store, connection.services.store],
    send: (final api) => api.reboot(),
  );
}
