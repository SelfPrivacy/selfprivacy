part of 'client_jobs_cubit.dart';

sealed class JobsState extends Equatable {
  String? get rebuildJobUid => null;
  JobsState addJob(final JobDraft change, {final SystemSettings? settings});
  @override
  List<Object?> get props => [];
}

List<JobDraft> _updatedDraft(
  final List<JobDraft> draft,
  final JobDraft change,
  final SystemSettings? settings,
) {
  if (change is ReplaceableJobDraft) {
    return [
      ...draft.where(
        (final existing) => change.shouldReplaceOnlyIfSameId
            ? existing.runtimeType != change.runtimeType ||
                  existing.id != change.id
            : existing.runtimeType != change.runtimeType,
      ),
      if (!change.matchesSettings(settings)) change,
    ];
  }
  return change.canAddTo(draft) ? [...draft, change] : draft;
}

JobsState _draftState(final List<JobDraft> changes) =>
    changes.isEmpty ? JobsStateEmpty() : JobsStateWithJobs(changes);

class JobsStateEmpty extends JobsState {
  @override
  JobsState addJob(
    final JobDraft change, {
    final SystemSettings? settings,
  }) => _draftState(_updatedDraft(const [], change, settings));
}

class JobsStateWithJobs extends JobsState {
  JobsStateWithJobs(final List<JobDraft> changes)
    : clientJobList = List.unmodifiable(changes);
  final List<JobDraft> clientJobList;
  bool get rebuildRequired =>
      clientJobList.any((final change) => change.requiresRebuild);
  bool get dnsUpdateRequired =>
      clientJobList.any((final change) => change.requiresDnsUpdate);

  JobsState removeById(final String id) => _draftState(
    clientJobList.where((final change) => change.id != id).toList(),
  );

  @override
  JobsState addJob(final JobDraft change, {final SystemSettings? settings}) {
    final updated = _updatedDraft(clientJobList, change, settings);
    return identical(updated, clientJobList) ? this : _draftState(updated);
  }

  @override
  List<Object?> get props => [clientJobList];
}

sealed class JobsStateWithProgress extends JobsState {
  JobsStateWithProgress(
    final List<OperationStep> steps,
    this.rebuildJobUid,
    final List<JobDraft> postponedJobs, {
    required this.rebuildRequired,
  }) : steps = List.unmodifiable(steps),
       postponedJobs = List.unmodifiable(postponedJobs);

  final List<OperationStep> steps;
  @override
  final String? rebuildJobUid;
  final List<JobDraft> postponedJobs;
  final bool rebuildRequired;

  @override
  List<Object?> get props => [
    steps,
    rebuildJobUid,
    postponedJobs,
    rebuildRequired,
  ];
}

class JobsStateLoading extends JobsStateWithProgress {
  JobsStateLoading(
    super.steps,
    super.rebuildJobUid,
    super.postponedJobs, {
    super.rebuildRequired = true,
  });

  JobsStateLoading updateStep(
    final String id,
    final OperationStatus status, {
    final String? messageKey,
    final String? jobId,
  }) => copyWith(
    steps: [
      for (final step in steps)
        if (step.id == id)
          step.withStatus(status, messageKey: messageKey, jobId: jobId)
        else
          step,
    ],
  );

  JobsStateLoading copyWith({
    final List<OperationStep>? steps,
    final String? rebuildJobUid,
    final List<JobDraft>? postponedJobs,
  }) => JobsStateLoading(
    steps ?? this.steps,
    rebuildJobUid ?? this.rebuildJobUid,
    postponedJobs ?? this.postponedJobs,
    rebuildRequired: rebuildRequired,
  );

  JobsStateFinished finished() => JobsStateFinished(
    steps,
    rebuildJobUid,
    postponedJobs,
    rebuildRequired: rebuildRequired,
  );

  @override
  JobsState addJob(
    final JobDraft change, {
    final SystemSettings? settings,
  }) => copyWith(postponedJobs: _updatedDraft(postponedJobs, change, settings));
}

class JobsStateFinished extends JobsStateWithProgress {
  JobsStateFinished(
    super.steps,
    super.rebuildJobUid,
    super.postponedJobs, {
    super.rebuildRequired = true,
  });

  @override
  JobsState addJob(
    final JobDraft change, {
    final SystemSettings? settings,
  }) => _draftState(_updatedDraft(postponedJobs, change, settings));
}
