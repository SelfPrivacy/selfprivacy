part of 'server_jobs_cubit.dart';

class ServerJobsState extends ServerInstallationDependendState {
  const ServerJobsState({this.serverJobList = const []});
  final List<ServerJob> serverJobList;

  @override
  List<Object?> get props => serverJobList;

  ServerJobsState copyWith({
    final List<ServerJob>? serverJobList,
  }) =>
      ServerJobsState(
        serverJobList: serverJobList ?? this.serverJobList,
      );
}
