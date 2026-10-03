import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';

class VolumesRepository {
  VolumesRepository({
    required this.commands,
    required this.reader,
    required this.servicesStore,
  });

  final ServerCommandCoordinator commands;
  final DomainReader<List<ServerDiskVolume>> reader;
  DomainStore<List<ServerDiskVolume>> get store => reader.store;
  final DomainStore<Object> servicesStore;

  CachedValue<List<ServerDiskVolume>> get value => reader.value;
  Stream<CachedValue<List<ServerDiskVolume>>> get changes => reader.changes;
  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

  void invalidate() {
    if (commands.isAttached) {
      store.invalidate();
    }
  }

  Future<ServerMutationResult<void>> resize(final String name) => commands
      .mutate(domains: [store], send: (final api) => api.resizeVolume(name));

  Future<ServerMutationResult<void>> reboot() => commands.mutate(
    domains: [store, servicesStore],
    send: (final api) => api.reboot(),
  );
}
