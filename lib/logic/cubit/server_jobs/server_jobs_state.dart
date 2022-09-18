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

  List<ServerJob> get serverJobList =>
      _serverJobList.where((final ServerJob job) => !job.isHidden).toList();

  @override
  List<Object?> get props => [migrationJobUid, ..._serverJobList];

  ServerJobsState copyWith({
    final List<ServerJob>? serverJobList,
    final String? migrationJobUid,
  }) =>
      ServerJobsState(
        serverJobList: serverJobList ?? _serverJobList,
        migrationJobUid: migrationJobUid ?? this.migrationJobUid,
      );
}
