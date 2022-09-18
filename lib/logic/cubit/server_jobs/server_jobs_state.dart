part of 'server_jobs_cubit.dart';

class ServerJobsState extends ServerInstallationDependendState {
  const ServerJobsState({
    this.serverJobList = const [],
    this.migrationJobUid,
  });
  final List<ServerJob> serverJobList;
  final String? migrationJobUid;

  @override
  List<Object?> get props => [migrationJobUid, ...serverJobList];

  ServerJobsState copyWith({
    final List<ServerJob>? serverJobList,
    final String? migrationJobUid,
  }) =>
      ServerJobsState(
        serverJobList: serverJobList ?? this.serverJobList,
        migrationJobUid: migrationJobUid ?? this.migrationJobUid,
      );
}
