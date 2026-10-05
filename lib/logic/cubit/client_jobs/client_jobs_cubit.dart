import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
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
    required final Stream<CachedValue<SystemSettings>?> settings,
    required final AdmitConfigurationOperation admitOperation,
    required final void Function(String) showMessage,
  }) : _admitOperation = admitOperation,
       _showMessage = showMessage,
       super(JobsStateEmpty()) {
    _settingsSubscription = settings.listen((final observation) {
      _settings = observation;
      if (observation == null) {
        emit(JobsStateEmpty());
      }
    });
  }

  final AdmitConfigurationOperation _admitOperation;
  final void Function(String) _showMessage;
  late final StreamSubscription<CachedValue<SystemSettings>?>
  _settingsSubscription;
  CachedValue<SystemSettings>? _settings;
  bool _submitting = false;

  bool get _isActive => !isClosed && _settings != null;

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
              : 'jobs.job_added')
          .tr(),
    );
  }

  void removeJob(final String id) => emit(
    _draftState(state.draft.where((final job) => job.id != id).toList()),
  );

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
    final previous = state;
    if (!_isActive || _submitting || previous.draft.isEmpty) {
      return;
    }
    final jobs = List<JobDraft>.unmodifiable(previous.draft);
    emit(JobsStateEmpty());
    await _perform(
      OperationKind.applyChanges,
      (final operation) => operation.run(
        jobs,
        onProgress: (final progress) {
          if (_isActive &&
              progress.stage == ConfigurationStage.rebuild &&
              !progress.status.isPending &&
              progress.status != OperationStatus.succeeded) {
            _showMessage(progress.messageKey!.tr());
          }
        },
      ),
      onNotSent: () {
        var restored = previous;
        for (final change in state.draft) {
          restored = restored.addJob(change, settings: _settings?.data);
        }
        emit(restored);
      },
    );
  }

  @override
  Future<void> close() async {
    _settings = null;
    await _settingsSubscription.cancel();
    return super.close();
  }
}
