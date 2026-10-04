import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/repositories/jobs_repository.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:selfprivacy/logic/operations/configuration/apply_changes_operation.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

export 'package:provider/provider.dart';

part 'client_jobs_state.dart';

typedef AdmitConfigurationOperation =
    Future<OperationResult<void>> Function(
      OperationKind kind,
      Future<void> Function(ApplyChangesOperation) action,
    );

class JobsCubit extends Cubit<JobsState> {
  JobsCubit({
    required final Stream<JobsSnapshot?> jobs,
    required final Stream<CachedValue<SystemSettings>?> settings,
    required final AdmitConfigurationOperation admitOperation,
    required final void Function(String) showMessage,
  }) : _admitOperation = admitOperation,
       _showMessage = showMessage,
       super(JobsStateEmpty()) {
    _jobsSubscription = jobs.listen(_observeJobs);
    _settingsSubscription = settings.listen((final observation) {
      _settings = observation;
    });
  }

  final AdmitConfigurationOperation _admitOperation;
  final void Function(String) _showMessage;
  late final StreamSubscription<JobsSnapshot?> _jobsSubscription;
  late final StreamSubscription<CachedValue<SystemSettings>?>
  _settingsSubscription;
  JobsSnapshot? _jobs;
  CachedValue<SystemSettings>? _settings;
  bool _submitting = false;

  bool get _isActive => !isClosed && _jobs != null;

  void _observeJobs(final JobsSnapshot? observation) {
    if (observation == null) {
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
    final job = _jobs?.jobs.firstWhereOrNull(
      (final job) => job.uid == current.rebuildJobUid,
    );
    if (job?.status == JobStatusEnum.error ||
        job?.status == JobStatusEnum.finished) {
      emit(
        current
            .copyWith(
              steps: [
                for (final step in current.steps)
                  if (step.jobId == job!.uid)
                    step.withStatus(
                      job.status == JobStatusEnum.finished
                          ? OperationStatus.succeeded
                          : OperationStatus.failed,
                    )
                  else
                    step,
              ],
            )
            .finished(),
      );
    }
  }

  void addJob(final JobDraft job) {
    if (!_isActive) {
      return;
    }
    final settings = _settings?.data;
    final previous = state;
    final next = previous.addJob(job, settings: settings);
    if (identical(next, previous)) {
      return;
    }
    emit(next);
    _showMessage(
      (job is ReplaceableJobDraft && job.matchesSettings(settings)
              ? 'jobs.job_removed'
              : previous is JobsStateLoading
              ? 'jobs.job_postponed'
              : 'jobs.job_added')
          .tr(),
    );
  }

  void removeJob(final String id) {
    final draft = state.draft.where((final job) => job.id != id).toList();
    emit(switch (state) {
      final JobsStateLoading current => current.copyWith(postponedJobs: draft),
      _ => _draftState(draft),
    });
  }

  Future<void> _perform(
    final OperationKind kind,
    final Future<void> Function(ApplyChangesOperation) action, {
    required final void Function() onNotSent,
  }) async {
    _submitting = true;
    try {
      final result = await _admitOperation(kind, action);
      if (_isActive &&
          (result.status == OperationStatus.notSent ||
              result.status == OperationStatus.cancelled)) {
        onNotSent();
        _showMessage(result.status.translationKey.tr());
      }
    } catch (_) {
      if (_isActive) {
        _failUnfinished('server_mutation.outcome_unknown');
      }
    } finally {
      _submitting = false;
    }
  }

  void _failUnfinished(final String messageKey) {
    if (state case final JobsStateLoading current) {
      emit(
        JobsStateFinished(
          current.steps
              .map(
                (final job) => job.status.isPending
                    ? job.withStatus(
                        OperationStatus.unknown,
                        messageKey: messageKey,
                      )
                    : job,
              )
              .toList(),
          current.rebuildJobUid,
          current.postponedJobs,
          rebuildRequired: current.rebuildRequired,
        ),
      );
      _showMessage(messageKey.tr());
    }
  }

  Future<void> rebootServer() => _single(RebootServerJob());
  Future<void> upgradeServer() => _single(UpgradeServerJob());
  Future<void> collectNixGarbage() => _single(CollectNixGarbageJob());

  Future<void> _single(final JobDraft job) async {
    if (!_isActive || _submitting || state.draft.isNotEmpty) {
      return;
    }
    emit(
      JobsStateLoading(
        [configurationStep(job, status: OperationStatus.running)],
        null,
        const [],
        rebuildRequired: job.requiresRebuild,
      ),
    );
    final kind = switch (job) {
      RebootServerJob() => OperationKind.rebootServer,
      UpgradeServerJob() => OperationKind.upgradeServer,
      CollectNixGarbageJob() => OperationKind.collectGarbage,
      _ => throw ArgumentError('Unsupported maintenance action'),
    };
    await _perform(kind, (final operation) async {
      final result = await operation.execute(job);
      if (!_isActive) {
        return;
      }
      final current = state as JobsStateLoading;
      final feedback = ConfigurationProgress.fromResult(
        ConfigurationStage.change,
        result,
      );
      final updated = current.updateStep(
        job.id,
        feedback.status,
        messageKey: feedback.messageKey,
        jobId: feedback.jobId,
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
    }, onNotSent: () => emit(JobsStateEmpty()));
  }

  Future<void> applyAll() async {
    final previous = _draftState(state.draft);
    if (!_isActive || _submitting || previous is! JobsStateWithJobs) {
      return;
    }
    final jobs = List<JobDraft>.unmodifiable(previous.clientJobList);
    emit(
      JobsStateLoading(
        [
          ...jobs.map(configurationStep),
          if (previous.dnsUpdateRequired)
            configurationStep(UpdateDnsRecordsJob()),
        ],
        null,
        const [],
        rebuildRequired: previous.rebuildRequired,
      ),
    );
    await _perform(
      OperationKind.applyChanges,
      (final operation) => operation.run(
        jobs,
        onProgress: (final progress) {
          if (!_isActive || state is! JobsStateLoading) {
            return;
          }
          final current = state as JobsStateLoading;
          switch (progress.stage) {
            case ConfigurationStage.change:
            case ConfigurationStage.dns:
              emit(
                current.updateStep(
                  progress.changeId ?? UpdateDnsRecordsJob.jobId,
                  progress.status,
                  messageKey: progress.messageKey,
                  jobId: progress.jobId,
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
      onNotSent: () {
        final current = state;
        var restored = previous as JobsState;
        if (current is JobsStateLoading) {
          for (final change in current.postponedJobs) {
            restored = restored.addJob(change, settings: _settings?.data);
          }
        }
        emit(restored);
      },
    );
    if (_isActive && state is JobsStateLoading) {
      final current = state as JobsStateLoading;
      if (current.rebuildJobUid == null) {
        emit(current.finished());
      }
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
