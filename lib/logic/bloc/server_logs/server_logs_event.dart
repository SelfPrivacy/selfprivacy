part of 'server_logs_bloc.dart';

sealed class ServerLogsEvent extends Equatable {
  const ServerLogsEvent();
}

final class ServerLogsFetch extends ServerLogsEvent {
  const ServerLogsFetch({this.serviceId, this.unitId});

  final String? serviceId;
  final String? unitId;

  @override
  List<Object> get props => [];
}

final class ServerLogsFetchMore extends ServerLogsEvent {
  @override
  List<Object> get props => [];
}

final class _LogReceived extends ServerLogsEvent {
  const _LogReceived(this.entry, this.view);

  final ServerLogEntry entry;
  final Object view;

  @override
  List<Object> get props => [entry, view];
}

final class _ReadLogs extends ServerLogsEvent {
  const _ReadLogs(this.event, this.view);
  final ServerLogsEvent event;

  final Object view;
  @override
  List<Object?> get props => [event, view];
}

final class _ResetLogs extends ServerLogsEvent {
  const _ResetLogs(this.view);
  final Object view;
  @override
  List<Object> get props => [view];
}

final class ServerLogsDisconnect extends ServerLogsEvent {
  @override
  List<Object> get props => [];
}
