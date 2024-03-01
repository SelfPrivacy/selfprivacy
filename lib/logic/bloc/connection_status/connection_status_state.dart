part of 'connection_status_bloc.dart';

class ConnectionStatusState extends Equatable {
  const ConnectionStatusState({
    required this.connectionStatus,
  });

  final ConnectionStatus connectionStatus;

  @override
  List<Object> get props => [connectionStatus];
}
