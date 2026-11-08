import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/operations/change_draft.dart';
import 'package:selfprivacy/logic/operations/configuration/apply_changes_operation.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

export 'package:provider/provider.dart';

part 'client_jobs_state.dart';

typedef AdmitConfigurationOperation =
    Future<OperationResult<void>> Function(
      OperationKind kind,
      Future<void> Function(ApplyChangesOperation) action,
    );

typedef ApplyChangeDraft =
    Future<OperationResult<void>?> Function(
      void Function(ConfigurationProgress) onProgress,
    );

class JobsCubit extends Cubit<JobsState> {
  JobsCubit({
    required final ChangeDraft draft,
    required final bool Function(JobDraft) stageChange,
    required final ApplyChangeDraft applyDraft,
    required final AdmitConfigurationOperation admitOperation,
    required final void Function(String) showMessage,
  }) : _draft = draft,
       _stageChange = stageChange,
       _applyDraft = applyDraft,
       _admitOperation = admitOperation,
       _showMessage = showMessage,
       super(_draftState(draft.value)) {
    _draftSubscription = draft.changes.listen(
      (final changes) => emit(_draftState(changes)),
    );
  }

  final AdmitConfigurationOperation _admitOperation;
  final void Function(String) _showMessage;
  final ChangeDraft _draft;
  final bool Function(JobDraft) _stageChange;
  final ApplyChangeDraft _applyDraft;
  late final StreamSubscription<List<JobDraft>> _draftSubscription;
  bool _submitting = false;

  bool get _isActive => !isClosed;

  void addJob(final JobDraft job) {
    if (!_isActive) {
      return;
    }
    if (!_stageChange(job)) {
      return;
    }
    _showMessage(
      (_draft.value.contains(job) ? 'jobs.job_added' : 'jobs.job_removed').tr(),
    );
  }

  void removeJob(final String id) => _draft.remove(id);

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
        _showMessage('server_mutation.outcome_unknown'.tr());
      }
    } finally {
      _submitting = false;
    }
  }

  Future<void> rebootServer() => _single(RebootServerJob());
  Future<void> upgradeServer() => _single(UpgradeServerJob());
  Future<void> collectNixGarbage() => _single(CollectNixGarbageJob());

  Future<void> _single(final JobDraft job) async {
    if (!_isActive || _submitting || state.draft.isNotEmpty) {
      return;
    }
    final kind = switch (job) {
      RebootServerJob() => OperationKind.rebootServer,
      UpgradeServerJob() => OperationKind.upgradeServer,
      CollectNixGarbageJob() => OperationKind.collectGarbage,
      _ => throw ArgumentError('Unsupported maintenance action'),
    };
    await _perform(
      kind,
      (final operation) => operation.executeMaintenance(job),
      onNotSent: () {},
    );
  }

  Future<void> applyAll() async {
    if (!_isActive || _submitting) {
      return;
    }
    try {
      final result = await _applyDraft((final progress) {
        if (_isActive &&
            progress.stage == ConfigurationStage.rebuild &&
            !progress.status.isPending &&
            progress.status != OperationStatus.succeeded) {
          _showMessage(progress.messageKey!.tr());
        }
      });
      if (_isActive &&
          result != null &&
          (result.status == OperationStatus.notSent ||
              result.status == OperationStatus.cancelled)) {
        _showMessage(result.status.translationKey.tr());
      }
    } catch (_) {
      if (_isActive) {
        _showMessage('server_mutation.outcome_unknown'.tr());
      }
    }
  }

  @override
  Future<void> close() async {
    await _draftSubscription.cancel();
    return super.close();
  }
}
