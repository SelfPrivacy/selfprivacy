import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

export 'package:provider/provider.dart';

part 'server_jobs_state.dart';
part 'server_jobs_event.dart';

class ServerJobsBloc extends Bloc<ServerJobsEvent, ServerJobsState> {
  ServerJobsBloc()
      : super(
          ServerJobsInitialState(),
        ) {
    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiDataSubscription = apiConnectionRepository.dataStream.listen(
      (final ApiData apiData) {
        add(
          ServerJobsListChanged([...apiData.serverJobs.data ?? []]),
        );
      },
    );

    on<ServerJobsListChanged>(
      _mapServerJobsListChangedToState,
    );
    on<RemoveServerJob>(
      _mapRemoveServerJobToState,
    );
    on<RemoveAllFinishedJobs>(
      _mapRemoveAllFinishedJobsToState,
    );
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
    final newState =
        ServerJobsListWithJobsState(serverJobList: event.serverJobList);
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

  @override
  void onChange(final Change<ServerJobsState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() {
    _apiDataSubscription?.cancel();
    return super.close();
  }
}
