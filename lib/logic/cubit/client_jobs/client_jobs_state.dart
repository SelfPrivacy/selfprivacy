part of 'client_jobs_cubit.dart';

abstract class JobsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class JobsStateLoading extends JobsState {}

class JobsStateEmpty extends JobsState {}

class JobsComplated extends JobsState {}

class JobsStateWithJobs extends JobsState {
  JobsStateWithJobs(this.clientJobList);
  final List<ClientJob> clientJobList;
  JobsState removeById(final String id) {
    final List<ClientJob> newJobsList =
        clientJobList.where((final element) => element.id != id).toList();
    if (newJobsList.isEmpty) {
      return JobsStateEmpty();
    }
    return JobsStateWithJobs(newJobsList);
  }

  @override
  List<Object?> get props => clientJobList;
}
