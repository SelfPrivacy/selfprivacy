import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/cache/domain_reader.dart';
import 'package:selfprivacy/logic/connection/cache/domain_store.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';

class ServicesRepository {
  ServicesRepository({
    required this.commands,
    required this.reader,
    required this.jobs,
    required this.volumesStore,
  });

  final ServerCommandCoordinator commands;
  final DomainReader<List<Service>> reader;
  DomainStore<List<Service>> get store => reader.store;
  final JobsRepository jobs;
  final DomainStore<Object> volumesStore;

  CachedValue<List<Service>> get value => reader.value;
  Stream<CachedValue<List<Service>>> get changes => reader.changes;
  Future<RefreshResult> refresh({final bool force = false}) =>
      reader.refresh(force: force);

  Future<ServerMutationResult<void>> restart(final String id) => commands
      .mutate(domains: [store], send: (final api) => api.restartService(id));
  Future<ServerMutationResult<void>> switchService({
    required final String serviceId,
    required final bool needTurnOn,
  }) => commands.mutate(
    domains: [store],
    send: (final api) =>
        api.switchService(serviceId: serviceId, needTurnOn: needTurnOn),
  );
  Future<ServerMutationResult<void>> setConfiguration(
    final String id,
    final Map<String, dynamic> settings,
  ) {
    final submitted = Map<String, dynamic>.unmodifiable(settings);
    return commands.mutate(
      domains: [store],
      send: (final api) => api.setServiceConfiguration(id, submitted),
    );
  }

  Future<ServerMutationResult<ServerJob>> move(
    final String id,
    final String destination,
  ) => commands.mutate(
    domains: [store, jobs.store, volumesStore],
    send: (final api) => api.moveService(id, destination),
    applyConfirmed: (final result) {
      final job = result.payload.value;
      if (job == null) {
        return [];
      }
      jobs.applyConfirmed(job, affectedDomains: [store, volumesStore]);
      return [jobs.store];
    },
  );
}
