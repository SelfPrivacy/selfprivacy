part of 'client_jobs_cubit.dart';

sealed class JobsState extends Equatable {
  List<JobDraft> get draft => const [];
  @override
  List<Object?> get props => [];
}

JobsState _draftState(final List<JobDraft> changes) =>
    changes.isEmpty ? JobsStateEmpty() : JobsStateWithJobs(changes);

class JobsStateEmpty extends JobsState {}

class JobsStateWithJobs extends JobsState {
  JobsStateWithJobs(final List<JobDraft> changes)
    : clientJobList = List.unmodifiable(changes);
  final List<JobDraft> clientJobList;
  @override
  List<JobDraft> get draft => clientJobList;

  @override
  List<Object?> get props => [clientJobList];
}
