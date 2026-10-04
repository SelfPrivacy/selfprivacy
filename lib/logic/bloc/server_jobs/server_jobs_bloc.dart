import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

export 'package:provider/provider.dart';

part 'server_jobs_event.dart';
part 'server_jobs_state.dart';

class ServerJobsBloc extends Bloc<ServerJobsEvent, ServerJobsState> {
  ServerJobsBloc({
    required final Stream<ConnectionObservation<JobsSnapshot>> jobs,
    required final Future<ServerMutationResult<void>?> Function(
      ServerStateOrigin,
      String,
    )
    removeJob,
    required final Future<Map<String, ServerMutationResult<void>>?> Function(
      ServerStateOrigin,
    )
    removeFinished,
    required final Future<ServerMutationResult<ServerJob>?> Function(
      ServerStateOrigin,
      Map<String, String>,
    )
    migrate,
    required final void Function(String, {SnackBarBehavior? behavior})
    showMessage,
  }) : _removeJob = removeJob,
       _removeFinished = removeFinished,
       _migrate = migrate,
       _showMessage = showMessage,
       super(ServerJobsInitialState()) {
    on<_JobsObserved>(_observe, transformer: sequential());
    on<_JobsAction<RemoveServerJob>>(_act, transformer: sequential());
    on<_JobsAction<RemoveAllFinishedJobs>>(_act, transformer: droppable());
    _subscription = jobs.listen((final observation) {
      _latest = observation;
      add(_JobsObserved(observation));
    });
  }

  final Future<ServerMutationResult<void>?> Function(ServerStateOrigin, String)
  _removeJob;
  final Future<Map<String, ServerMutationResult<void>>?> Function(
    ServerStateOrigin,
  )
  _removeFinished;
  final Future<ServerMutationResult<ServerJob>?> Function(
    ServerStateOrigin,
    Map<String, String>,
  )
  _migrate;
  final void Function(String, {SnackBarBehavior? behavior}) _showMessage;
  late final StreamSubscription<ConnectionObservation<JobsSnapshot>>
  _subscription;
  ConnectionObservation<JobsSnapshot>? _latest;
  ServerStateOrigin? _presentedOrigin;

  @override
  void add(final ServerJobsEvent event) {
    super.add(switch (event) {
      RemoveServerJob() => _JobsAction(event, _presentedOrigin),
      RemoveAllFinishedJobs() => _JobsAction(event, _presentedOrigin),
      _ => event,
    });
  }

  void _observe(
    final _JobsObserved event,
    final Emitter<ServerJobsState> emit,
  ) {
    if (!identical(event.observation.origin, _latest?.origin)) {
      return;
    }
    _presentedOrigin = event.observation.origin;
    final snapshot = event.observation.value;
    if (snapshot == null) {
      emit(ServerJobsInitialState());
    } else if (snapshot.value.support == DomainSupport.unsupported) {
      emit(ServerJobsUnsupportedState());
    } else if (snapshot.jobs.isNotEmpty) {
      emit(
        ServerJobsListWithJobsState(
          serverJobList: snapshot.jobs,
          isComplete: snapshot.isComplete,
          hasError: snapshot.value.lastError != null,
        ),
      );
    } else if (snapshot.isComplete) {
      emit(ServerJobsListEmptyState());
    } else if (snapshot.value.lastError != null) {
      emit(ServerJobsErrorState());
    } else {
      emit(ServerJobsInitialState());
    }
  }

  bool _isCurrent(final ServerStateOrigin? origin) =>
      !isClosed &&
      origin != null &&
      identical(origin.continuity, _latest?.origin?.continuity);

  Future<void> _act(
    final _JobsAction<ServerJobsEvent> action,
    final Emitter<ServerJobsState> emit,
  ) async {
    if (!_isCurrent(action.origin)) {
      return;
    }
    switch (action.event) {
      case RemoveServerJob(:final uid):
        final result = await _removeJob(action.origin!, uid);
        if (_isCurrent(action.origin)) {
          _report(result);
        }
      case RemoveAllFinishedJobs():
        final results = await _removeFinished(action.origin!);
        if (!_isCurrent(action.origin)) {
          return;
        }
        if (results == null) {
          _report<void>(null);
        } else {
          results.values.forEach(_report);
        }
      case _:
        throw StateError('Unsupported jobs action');
    }
  }

  void _report<T>(
    final ServerMutationResult<T>? result, {
    final bool requirePayload = false,
    final SnackBarBehavior? behavior,
  }) {
    if (result == null) {
      _showMessage(
        OperationStatus.notSent.translationKey.tr(),
        behavior: behavior,
      );
    } else if (result.outcome != ServerMutationOutcome.confirmed ||
        (requirePayload && result.payload.value == null)) {
      _showMessage(serverMutationMessage(result), behavior: behavior);
    }
  }

  Future<void> migrateToBinds(
    final Map<String, String> serviceToDisk, {
    required final ConnectionContinuity? continuity,
  }) async {
    final origin = _presentedOrigin;
    if (!_isCurrent(origin) || !identical(continuity, origin?.continuity)) {
      return;
    }
    final result = await _migrate(origin!, Map.unmodifiable(serviceToDisk));
    if (_isCurrent(origin)) {
      _report(
        result,
        requirePayload: true,
        behavior: SnackBarBehavior.floating,
      );
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
