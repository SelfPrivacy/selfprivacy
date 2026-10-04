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
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_job_workflow.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

export 'package:provider/provider.dart';

part 'client_jobs_state.dart';

typedef AdmitClientJobWorkflow =
    Future<OperationResult<void>> Function(
      ServerStateOrigin origin,
      OperationKind kind,
      Future<void> Function(ClientJobWorkflow) action,
    );

class JobsCubit extends Cubit<JobsState> {
  JobsCubit({
    required final Stream<ConnectionObservation<JobsSnapshot>> jobs,
    required final Stream<ConnectionObservation<CachedValue<SystemSettings>>>
    settings,
    required final AdmitClientJobWorkflow admitWorkflow,
    required final Future<void> Function(ServerStateOrigin, String)
    removeServerJob,
    required final void Function(String) showMessage,
  }) : _admitWorkflow = admitWorkflow,
       _removeServerJob = removeServerJob,
       _showMessage = showMessage,
       super(JobsStateEmpty()) {
    _jobsSubscription = jobs.listen(_observeJobs);
    _settingsSubscription = settings.listen((final observation) {
      _settings = observation;
    });
  }

  final AdmitClientJobWorkflow _admitWorkflow;
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
    final Future<void> Function(ClientJobWorkflow) action,
  ) async {
    try {
      final result = await _admitWorkflow(origin, kind, (final workflow) async {
        if (!_isCurrent(origin)) {
          throw const OperationNotSent();
        }
        await action(workflow);
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
    await _perform(origin!, OperationKind.manageJobs, (final workflow) async {
      final result = await workflow.execute(job);
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
    final jobs = previous.clientJobList;
    final dnsRequired = previous.dnsUpdateRequired;
    emit(
      JobsStateLoading(
        [...jobs, if (dnsRequired) UpdateDnsRecordsJob()],
        null,
        const [],
      ),
    );
    await _perform(origin!, OperationKind.applyChanges, (final workflow) async {
      final oldDns = dnsRequired ? await workflow.readDns() : null;
      if (!_isCurrent(origin)) {
        return;
      }
      for (final job in jobs) {
        emit(
          (state as JobsStateLoading).updateJobStatus(
            job.id,
            JobStatusEnum.running,
          ),
        );
        final result = await workflow.execute(job);
        if (!_isCurrent(origin)) {
          return;
        }
        emit(
          (state as JobsStateLoading).updateJobStatus(
            job.id,
            result.outcome == ServerMutationOutcome.confirmed
                ? JobStatusEnum.finished
                : JobStatusEnum.error,
            message: serverMutationMessage(
              result,
              sensitive: job is ChangeServiceConfiguration,
            ),
          ),
        );
      }
      if ((state as JobsStateLoading).clientJobList.any(
        (final job) => job.status == JobStatusEnum.error,
      )) {
        if (dnsRequired) {
          emit(
            (state as JobsStateLoading).updateJobStatus(
              UpdateDnsRecordsJob.jobId,
              JobStatusEnum.error,
              message: 'jobs.ignored_due_to_failures'.tr(),
            ),
          );
        }
        emit((state as JobsStateLoading).finished());
        return;
      }
      if (oldDns != null) {
        emit(
          (state as JobsStateLoading).updateJobStatus(
            UpdateDnsRecordsJob.jobId,
            JobStatusEnum.running,
          ),
        );
        final dns = await workflow.updateDns(oldDns);
        if (!_isCurrent(origin)) {
          return;
        }
        emit(
          (state as JobsStateLoading).updateJobStatus(
            UpdateDnsRecordsJob.jobId,
            dns == DnsUpdateOutcome.updated || dns == DnsUpdateOutcome.unchanged
                ? JobStatusEnum.finished
                : JobStatusEnum.error,
            message: switch (dns) {
              DnsUpdateOutcome.updated => 'jobs.dns_records_changed'.tr(),
              DnsUpdateOutcome.unchanged =>
                'jobs.dns_records_did_not_change'.tr(),
              DnsUpdateOutcome.unavailable ||
              DnsUpdateOutcome.failed => 'jobs.failed_to_load_dns_records'.tr(),
            },
          ),
        );
      }
      if (!previous.rebuildRequired) {
        emit((state as JobsStateLoading).finished());
        return;
      }
      final result = await workflow.apply();
      if (!_isCurrent(origin)) {
        return;
      }
      final job = result.payload.value;
      if (result.outcome == ServerMutationOutcome.confirmed && job != null) {
        emit((state as JobsStateLoading).copyWith(rebuildJobUid: job.uid));
        _handleServerJobs();
      } else {
        if (result.outcome != ServerMutationOutcome.confirmed ||
            result.payload.status != ServerMutationPayloadStatus.notExpected) {
          _showMessage(serverMutationMessage(result));
        }
        emit((state as JobsStateLoading).finished());
      }
    });
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
