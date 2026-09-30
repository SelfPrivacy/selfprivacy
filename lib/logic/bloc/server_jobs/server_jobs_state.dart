part of 'server_jobs_bloc.dart';

sealed class ServerJobsState extends Equatable {
  ServerJobsState({final List<ServerJob> serverJobList = const []})
    : serverJobList = List.unmodifiable(
        <ServerJob>[...serverJobList]
          ..sort((final a, final b) => b.createdAt.compareTo(a.createdAt)),
      );

  final List<ServerJob> serverJobList;

  List<ServerJob> get backupJobList => serverJobList
      .where(
        // The backup jobs has the format of 'service.<service_id>.backup'
        (final job) =>
            job.typeId.contains('backup') || job.typeId.contains('restore'),
      )
      .toList();

  List<String> get busyServices => backupJobList
      .where(
        (final ServerJob job) =>
            job.status == JobStatusEnum.running ||
            job.status == JobStatusEnum.created,
      )
      .map((final ServerJob job) => job.typeId.split('.')[1])
      .toList();

  bool get hasRemovableJobs => serverJobList.any(
    (final job) =>
        job.status == JobStatusEnum.finished ||
        job.status == JobStatusEnum.error,
  );

  bool get hasJobsBlockingRebuild => serverJobList.any(
    (final job) =>
        (job.status == JobStatusEnum.running ||
            job.status == JobStatusEnum.created) &&
        (job.typeId.contains('system.nixos.rebuild') ||
            job.typeId.contains('system.nixos.upgrade') ||
            job.typeId.contains('move')),
  );

  @override
  List<Object?> get props => [serverJobList];
}

class ServerJobsInitialState extends ServerJobsState {
  ServerJobsInitialState();
}

class ServerJobsListEmptyState extends ServerJobsState {
  ServerJobsListEmptyState();
}

class ServerJobsListWithJobsState extends ServerJobsState {
  ServerJobsListWithJobsState({required super.serverJobList});
}
