import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

export 'package:provider/provider.dart';

part 'server_jobs_state.dart';
part 'server_jobs_event.dart';

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
    await getIt<ApiConnectionRepository>().removeServerJob(event.uid);
  }

  Future<void> _mapRemoveAllFinishedJobsToState(
    final RemoveAllFinishedJobs event,
    final Emitter<ServerJobsState> emit,
  ) async {
    await getIt<ApiConnectionRepository>().removeAllFinishedServerJobs();
  }

  Future<void> migrateToBinds(final Map<String, String> serviceToDisk) async {
    final fallbackDrive =
        getIt<ApiConnectionRepository>().apiData.volumes.data
            ?.where((final drive) => drive.root)
            .first
            .name ??
        'sda1';
    final result = await getIt<ApiConnectionRepository>().api.migrateToBinds(
      serviceToDisk,
      fallbackDrive,
    );
    if (result.data == null) {
      getIt<NavigationService>().showSnackBar(
        result.message!,
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
