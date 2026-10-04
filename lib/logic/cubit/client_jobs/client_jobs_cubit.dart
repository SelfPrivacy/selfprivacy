import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:selfprivacy/logic/operations/configuration/apply_changes_operation.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

export 'package:provider/provider.dart';

part 'client_jobs_state.dart';

typedef AdmitConfigurationOperation =
    Future<OperationResult<void>> Function(
      ServerStateOrigin origin,
      OperationKind kind,
      Future<void> Function(ApplyChangesOperation) action,
    );

class JobsCubit extends Cubit<JobsState> {
  JobsCubit({
    required final Stream<ConnectionObservation<JobsSnapshot>> jobs,
    required final Stream<ConnectionObservation<CachedValue<SystemSettings>>>
    settings,
    required final AdmitConfigurationOperation admitOperation,
    required final Future<void> Function(ServerStateOrigin, String)
    removeServerJob,
    required final void Function(String) showMessage,
  }) : _admitOperation = admitOperation,
       _removeServerJob = removeServerJob,
       _showMessage = showMessage,
       super(JobsStateEmpty()) {
    _jobsSubscription = jobs.listen(_observeJobs);
    _settingsSubscription = settings.listen((final observation) {
      _settings = observation;
    });
  }

  final AdmitConfigurationOperation _admitOperation;
  final Future<void> Function(ServerStateOrigin, String) _removeServerJob;
  final void Function(String) _showMessage;
  late final StreamSubscription<ConnectionObservation<JobsSnapshot>>
  _jobsSubscription;
  late final StreamSubscription<
    ConnectionObservation<CachedValue<SystemSettings>>
  >
  _settingsSubscription;
  ConnectionObservation<JobsSnapshot>? _jobs;
  ConnectionObservation<CachedValue<SystemSettings>>? _settings;

  bool _isCurrent(final ServerStateOrigin? origin) =>
      !isClosed &&
      origin != null &&
      identical(origin.continuity, _jobs?.origin?.continuity);

  void _observeJobs(final ConnectionObservation<JobsSnapshot> observation) {
    if (!identical(_jobs?.origin?.continuity, observation.origin?.continuity)) {
      emit(JobsStateEmpty());
    }
    _jobs = observation;
    _handleServerJobs();
  }

  void _handleServerJobs() {
    final current = state;
    if (current is! JobsStateLoading || current.rebuildJobUid == null) {
      return;
    }
    final job = _jobs?.value?.jobs.firstWhereOrNull(
      (final job) => job.uid == current.rebuildJobUid,
    );
    if (job?.status == JobStatusEnum.error ||
        job?.status == JobStatusEnum.finished) {
      emit(current.finished());
    }
  }

  void addJob(final ClientJob job) {
    final origin = _jobs?.origin;
    if (!_isCurrent(origin)) {
      return;
    }
    final settings =
        identical(_settings?.origin?.continuity, origin?.continuity)
        ? _settings?.value?.data
        : null;
    final previous = state;
    final next = previous.addJob(job, settings: settings);
    if (identical(next, previous)) {
      return;
    }
    emit(next);
    _showMessage(
      (job is ReplaceableJob && job.matchesSettings(settings)
              ? 'jobs.job_removed'
              : previous is JobsStateLoading
              ? 'jobs.job_postponed'
              : 'jobs.job_added')
          .tr(),
    );
  }

  void removeJob(final String id) {
    if (state case final JobsStateWithJobs current) {
      emit(current.removeById(id));
    }
  }

  Future<void> _perform(
    final ServerStateOrigin origin,
    final OperationKind kind,
    final Future<void> Function(ApplyChangesOperation) action,
  ) async {
    try {
      final result = await _admitOperation(origin, kind, (
        final operation,
      ) async {
        await action(operation);
      });
      if (_isCurrent(origin) &&
          (result.status == OperationStatus.notSent ||
              result.status == OperationStatus.cancelled)) {
        _failUnfinished(result.status.translationKey.tr());
      }
    } catch (_) {
      if (_isCurrent(origin)) {
        _failUnfinished('server_mutation.outcome_unknown'.tr());
      }
    }
  }

  void _failUnfinished(final String message) {
    if (state case final JobsStateLoading current) {
      emit(
        JobsStateFinished(
          current.clientJobList
              .map(
                (final job) =>
                    job.status == JobStatusEnum.created ||
                        job.status == JobStatusEnum.running
                    ? job.copyWithNewStatus(
                        status: JobStatusEnum.error,
                        message: message,
                      )
                    : job,
              )
              .toList(),
          current.rebuildJobUid,
          current.postponedJobs,
        ),
      );
      _showMessage(message);
    }
  }

  Future<void> rebootServer() => _single(RebootServerJob());
  Future<void> upgradeServer() => _single(UpgradeServerJob());
  Future<void> collectNixGarbage() => _single(CollectNixGarbageJob());

  Future<void> _single(final ClientJob job) async {
    final origin = _jobs?.origin;
    if (!_isCurrent(origin) || state is! JobsStateEmpty) {
      return;
    }
    emit(
      JobsStateLoading(
        [job.copyWithNewStatus(status: JobStatusEnum.running)],
        null,
        const [],
      ),
    );
    await _perform(origin!, OperationKind.manageJobs, (final operation) async {
      final result = await operation.execute(job);
      if (!_isCurrent(origin)) {
        return;
      }
      final current = state as JobsStateLoading;
      final updated = current.updateJobStatus(
        job.id,
        result.outcome == ServerMutationOutcome.confirmed
            ? JobStatusEnum.finished
            : JobStatusEnum.error,
        message: serverMutationMessage(result),
      );
      if (result.outcome == ServerMutationOutcome.confirmed &&
          result.payload.value is ServerJob) {
        emit(
          updated.copyWith(
            rebuildJobUid: (result.payload.value! as ServerJob).uid,
          ),
        );
        _handleServerJobs();
      } else {
        emit(updated.finished());
      }
    });
  }

  Future<void> applyAll() async {
    final origin = _jobs?.origin;
    final previous = state;
    if (!_isCurrent(origin) || previous is! JobsStateWithJobs) {
      return;
    }
    final jobs = List<ClientJob>.unmodifiable(previous.clientJobList);
    emit(
      JobsStateLoading(
        [...jobs, if (previous.dnsUpdateRequired) UpdateDnsRecordsJob()],
        null,
        const [],
      ),
    );
    await _perform(
      origin!,
      OperationKind.applyChanges,
      (final operation) => operation.run(
        jobs,
        onProgress: (final progress) {
          if (!_isCurrent(origin) || state is! JobsStateLoading) {
            return;
          }
          final current = state as JobsStateLoading;
          switch (progress.stage) {
            case ConfigurationStage.change:
            case ConfigurationStage.dns:
              emit(
                current.updateJobStatus(
                  progress.changeId ?? UpdateDnsRecordsJob.jobId,
                  switch (progress.status) {
                    OperationStatus.running => JobStatusEnum.running,
                    OperationStatus.succeeded ||
                    OperationStatus.accepted => JobStatusEnum.finished,
                    _ => JobStatusEnum.error,
                  },
                  message: progress.messageKey?.tr(),
                ),
              );
            case ConfigurationStage.rebuild:
              if (progress.status == OperationStatus.running) {
                return;
              }
              if (progress.jobId case final uid?) {
                emit(current.copyWith(rebuildJobUid: uid));
                _handleServerJobs();
              } else {
                if (progress.status != OperationStatus.succeeded) {
                  _showMessage(progress.messageKey!.tr());
                }
                emit(current.finished());
              }
          }
        },
      ),
    );
    if (_isCurrent(origin) && state is JobsStateLoading) {
      final current = state as JobsStateLoading;
      if (current.rebuildJobUid == null) {
        emit(current.finished());
      }
    }
  }

  Future<void> acknowledgeFinished() async {
    final origin = _jobs?.origin;
    final current = state;
    if (current is! JobsStateFinished) {
      return;
    }
    emit(
      current.postponedJobs.isEmpty
          ? JobsStateEmpty()
          : JobsStateWithJobs(current.postponedJobs),
    );
    if (origin != null && current.rebuildJobUid != null) {
      await _removeServerJob(origin, current.rebuildJobUid!);
    }
  }

  @override
  Future<void> close() async {
    _jobs = null;
    _settings = null;
    await _jobsSubscription.cancel();
    await _settingsSubscription.cancel();
    return super.close();
  }
}
