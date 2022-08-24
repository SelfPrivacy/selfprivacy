part of 'jobs_cubit.dart';

abstract class JobsState extends Equatable {
  const JobsState(this.serverJobList);
  final List<ServerJob> serverJobList;
  @override
  List<Object?> get props => [serverJobList];
}

class JobsStateLoading extends JobsState {
  const JobsStateLoading(super.serverJobList);
}

class JobsStateEmpty extends JobsState {
  const JobsStateEmpty(super.serverJobList);
}

class JobsStateWithJobs extends JobsState {
  const JobsStateWithJobs(this.clientJobList, super.serverJobList);
  final List<ClientJob> clientJobList;

  JobsState removeById(final String id) {
    final List<ClientJob> newJobsList =
        clientJobList.where((final element) => element.id != id).toList();

    if (newJobsList.isEmpty) {
      return JobsStateEmpty(serverJobList);
    }
    return JobsStateWithJobs(newJobsList, serverJobList);
  }

  @override
  List<Object?> get props => [...super.props, clientJobList];
}
