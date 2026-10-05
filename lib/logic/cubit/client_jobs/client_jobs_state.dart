part of 'client_jobs_cubit.dart';

sealed class JobsState extends Equatable {
  List<JobDraft> get draft => const [];
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
  JobsState addJob(final JobDraft change, {final SystemSettings? settings}) =>
      _draftState(_updatedDraft(const [], change, settings));
}

class JobsStateWithJobs extends JobsState {
  JobsStateWithJobs(final List<JobDraft> changes)
    : clientJobList = List.unmodifiable(changes);
  final List<JobDraft> clientJobList;
  @override
  List<JobDraft> get draft => clientJobList;

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
