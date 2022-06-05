// ignore_for_file: always_specify_types

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

  JobsState removeById(final String id) {
    final List<Job> newJobsList = jobList.where((final element) => element.id != id).toList();

    if (newJobsList.isEmpty) {
      return JobsStateEmpty();
    }
    return JobsStateWithJobs(newJobsList);
  }

  @override
  List<Object?> get props => jobList;
}
