import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

export 'package:provider/provider.dart';

part 'server_jobs_event.dart';
part 'server_jobs_state.dart';

class ServerJobsBloc extends Bloc<ServerJobsEvent, ServerJobsState> {
  ServerJobsBloc({
    required final Stream<JobsSnapshot?> jobs,
    required final Future<ServerMutationResult<void>?> Function(String)
    removeJob,
    required final Future<Map<String, ServerMutationResult<void>>?> Function()
    removeFinished,
    required final Future<ServerMutationResult<ServerJob>?> Function(
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
    on<RemoveServerJob>(_act, transformer: sequential());
    on<RemoveAllFinishedJobs>(_act, transformer: droppable());
    _subscription = jobs.listen((final observation) {
      _latest = observation;
      add(_JobsObserved(observation));
    });
  }

  final Future<ServerMutationResult<void>?> Function(String) _removeJob;
  final Future<Map<String, ServerMutationResult<void>>?> Function()
  _removeFinished;
  final Future<ServerMutationResult<ServerJob>?> Function(Map<String, String>)
  _migrate;
  final void Function(String, {SnackBarBehavior? behavior}) _showMessage;
  late final StreamSubscription<JobsSnapshot?> _subscription;
  JobsSnapshot? _latest;

  void _observe(
    final _JobsObserved event,
    final Emitter<ServerJobsState> emit,
  ) {
    final snapshot = event.observation;
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

  bool get _isActive => !isClosed && _latest != null;

  Future<void> _act(
    final ServerJobsEvent action,
    final Emitter<ServerJobsState> emit,
  ) async {
    if (!_isActive) {
      return;
    }
    switch (action) {
      case RemoveServerJob(:final uid):
        final result = await _removeJob(uid);
        if (_isActive) {
          _report(result);
        }
      case RemoveAllFinishedJobs():
        final results = await _removeFinished();
        if (!_isActive) {
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

  Future<void> migrateToBinds(final Map<String, String> serviceToDisk) async {
    if (!_isActive) {
      return;
    }
    final result = await _migrate(Map.unmodifiable(serviceToDisk));
    if (_isActive) {
      _report(
        result,
        requirePayload: true,
        behavior: SnackBarBehavior.floating,
      );
    }
  }

  @override
  Future<void> close() async {
    _latest = null;
    await _subscription.cancel();
    return super.close();
  }
}
