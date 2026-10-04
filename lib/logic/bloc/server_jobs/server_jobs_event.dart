part of 'server_jobs_bloc.dart';

sealed class ServerJobsEvent extends Equatable {
  const ServerJobsEvent();

  @override
  List<Object?> get props => [];
}

class _JobsObserved extends ServerJobsEvent {
  const _JobsObserved(this.observation);

  final JobsSnapshot? observation;

  @override
  List<Object?> get props => [observation];
}

class RemoveServerJob extends ServerJobsEvent {
  const RemoveServerJob(this.uid);

  final String uid;

  @override
  List<Object?> get props => [uid];
}

class RemoveAllFinishedJobs extends ServerJobsEvent {}
