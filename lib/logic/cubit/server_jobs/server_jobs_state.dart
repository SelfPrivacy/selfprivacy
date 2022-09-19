part of 'server_jobs_cubit.dart';

class ServerJobsState extends ServerInstallationDependendState {
  ServerJobsState({
    final serverJobList = const <ServerJob>[],
    this.migrationJobUid,
  }) {
    _serverJobList = serverJobList;
  }

  late final List<ServerJob> _serverJobList;
  final String? migrationJobUid;

  List<ServerJob> get serverJobList {
    final List<ServerJob> list = _serverJobList;
    list.sort((final a, final b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  bool get hasRemovableJobs => serverJobList.any(
        (final job) =>
            job.status == JobStatusEnum.finished ||
            job.status == JobStatusEnum.error,
      );

  @override
  List<Object?> get props => [migrationJobUid, _serverJobList];

  ServerJobsState copyWith({
    final List<ServerJob>? serverJobList,
    final String? migrationJobUid,
  }) =>
      ServerJobsState(
        serverJobList: serverJobList ?? _serverJobList,
        migrationJobUid: migrationJobUid ?? this.migrationJobUid,
      );
}
