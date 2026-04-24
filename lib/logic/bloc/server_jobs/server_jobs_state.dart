part of 'server_jobs_bloc.dart';

sealed class ServerJobsState extends Equatable {
  ServerJobsState({final int? hashCode})
    : _hashCode = hashCode ?? Object.hashAll([]);

  final int? _hashCode;

  final apiConnectionRepository = getIt<ApiConnectionRepository>();

  List<ServerJob> get _serverJobList =>
      apiConnectionRepository.apiData.serverJobs.data ?? [];

  List<ServerJob> get serverJobList {
    try {
      final List<ServerJob> list =
          _serverJobList
            ..sort((final a, final b) => b.createdAt.compareTo(a.createdAt));
      return list;
    } on UnsupportedError {
      return _serverJobList;
    }
  }

  List<ServerJob> get backupJobList =>
      serverJobList
          .where(
            // The backup jobs has the format of 'service.<service_id>.backup'
            (final job) =>
                job.typeId.contains('backup') || job.typeId.contains('restore'),
          )
          .toList();

  List<String> get busyServices =>
      backupJobList
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
  List<Object?> get props => [_hashCode];
}

class ServerJobsInitialState extends ServerJobsState {
  ServerJobsInitialState() : super(hashCode: Object.hashAll([]));
}

class ServerJobsListEmptyState extends ServerJobsState {
  ServerJobsListEmptyState() : super(hashCode: Object.hashAll([]));
}

class ServerJobsListWithJobsState extends ServerJobsState {
  ServerJobsListWithJobsState({required final List<ServerJob> serverJobList})
    : super(hashCode: Object.hashAll([...serverJobList]));
}
