part of 'server_jobs_bloc.dart';

sealed class ServerJobsEvent extends Equatable {
  const ServerJobsEvent();

  @override
  List<Object?> get props => [];
}

class ServerJobsListChanged extends ServerJobsEvent {
  const ServerJobsListChanged(this.serverJobList);

  final List<ServerJob> serverJobList;

  @override
  List<Object?> get props => [serverJobList];
}

class RemoveServerJob extends ServerJobsEvent {
  const RemoveServerJob(this.uid);

  final String uid;

  @override
  List<Object?> get props => [uid];
}

class RemoveAllFinishedJobs extends ServerJobsEvent {}
