import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

export 'package:provider/provider.dart';

part 'server_jobs_event.dart';
part 'server_jobs_state.dart';

class ServerJobsBloc extends Bloc<ServerJobsEvent, ServerJobsState> {
  ServerJobsBloc() : super(ServerJobsInitialState()) {
    on<ServerJobsListChanged>(
      _mapServerJobsListChangedToState,
      transformer: sequential(),
    );
    on<RemoveServerJob>(_mapRemoveServerJobToState, transformer: sequential());
    on<RemoveAllFinishedJobs>(
      _mapRemoveAllFinishedJobsToState,
      transformer: droppable(),
    );

    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiDataSubscription = apiConnectionRepository.dataStream.listen((
      final ApiData apiData,
    ) {
      add(ServerJobsListChanged([...apiData.serverJobs.data ?? []]));
    });
  }

  StreamSubscription? _apiDataSubscription;

  Future<void> _mapServerJobsListChangedToState(
    final ServerJobsListChanged event,
    final Emitter<ServerJobsState> emit,
  ) async {
    if (event.serverJobList.isEmpty) {
      emit(ServerJobsListEmptyState());
      return;
    }
    final newState = ServerJobsListWithJobsState(
      serverJobList: event.serverJobList,
    );
    emit(newState);
  }

  Future<void> _mapRemoveServerJobToState(
    final RemoveServerJob event,
    final Emitter<ServerJobsState> emit,
  ) async {
    final result = await getIt<ApiConnectionRepository>().removeServerJob(
      event.uid,
    );
    if (result.outcome != ServerMutationOutcome.confirmed) {
      getIt<NavigationService>().showSnackBar(serverMutationMessage(result));
    }
  }

  Future<void> _mapRemoveAllFinishedJobsToState(
    final RemoveAllFinishedJobs event,
    final Emitter<ServerJobsState> emit,
  ) async {
    final results = await getIt<ApiConnectionRepository>()
        .removeAllFinishedServerJobs();
    for (final result in results.values) {
      if (result.outcome != ServerMutationOutcome.confirmed) {
        getIt<NavigationService>().showSnackBar(serverMutationMessage(result));
      }
    }
  }

  Future<void> migrateToBinds(final Map<String, String> serviceToDisk) async {
    final destinations = Map<String, String>.unmodifiable(serviceToDisk);
    await getIt<ApiConnectionRepository>().run<void>(
      OperationKind.manageJobs,
      (final owner) => _migrateToBinds(destinations, owner),
    );
  }

  Future<void> _migrateToBinds(
    final Map<String, String> serviceToDisk,
    final ServerConnection connection,
  ) async {
    final fallbackDrive =
        connection.volumes.store.value.data
            ?.where((final drive) => drive.root)
            .firstOrNull
            ?.name ??
        'sda1';
    final result = await connection.jobs.migrateToBinds(
      serviceToDisk,
      fallbackDrive,
    );
    if (result.outcome != ServerMutationOutcome.confirmed ||
        result.payload.value == null) {
      getIt<NavigationService>().showSnackBar(
        serverMutationMessage(result),
        behavior: SnackBarBehavior.floating,
      );
      return;
    }
  }

  @override
  void onChange(final Change<ServerJobsState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    await _apiDataSubscription?.cancel();
    return super.close();
  }
}
