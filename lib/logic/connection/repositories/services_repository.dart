import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';

class ServicesRepository {
  ServicesRepository({required this.connection, required this.store});

  final ServerConnection connection;
  final DomainStore<List<Service>> store;
  CachedValue<List<Service>> get value => connection.snapshot(store);
  Future<RefreshResult> refresh({final bool force = false}) =>
      connection.refresh(store, force: force);

  Future<ServerMutationResult<void>> restart(final String id) => connection
      .mutate(domains: [store], send: (final api) => api.restartService(id));
  Future<ServerMutationResult<void>> switchService({
    required final String serviceId,
    required final bool needTurnOn,
  }) => connection.mutate(
    domains: [store],
    send: (final api) =>
        api.switchService(serviceId: serviceId, needTurnOn: needTurnOn),
  );
  Future<ServerMutationResult<void>> setConfiguration(
    final String id,
    final Map<String, dynamic> settings,
  ) {
    final submitted = Map<String, dynamic>.unmodifiable(settings);
    return connection.mutate(
      domains: [store],
      send: (final api) => api.setServiceConfiguration(id, submitted),
    );
  }

  Future<ServerMutationResult<ServerJob>> move(
    final String id,
    final String destination,
  ) => connection.mutate(
    domains: [store, connection.jobs.store, connection.volumesStore],
    send: (final api) => api.moveService(id, destination),
    applyConfirmed: (final result) {
      final job = result.payload.value;
      if (job == null) {
        return [];
      }
      connection.jobs.applyConfirmed(
        job,
        affectedDomains: [store, connection.volumesStore],
      );
      return [connection.jobs.store];
    },
  );
}
