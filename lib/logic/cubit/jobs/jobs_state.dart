part of 'jobs_cubit.dart';

abstract class JobsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class JobsStateLoading extends JobsState {}

class JobsStateEmpty extends JobsState {}

class JobsStateWithJobs extends JobsState {
  JobsStateWithJobs(this.jobList);
  final List<Job> jobList;

  JobsState removeById(String id) {
    var newJobsList = jobList.where((element) => element.id != id).toList();

    if (newJobsList.isEmpty) {
      return JobsStateEmpty();
    }
    return JobsStateWithJobs(newJobsList);
  }

  @override
  List<Object?> get props => jobList;
}
