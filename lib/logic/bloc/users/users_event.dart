part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();
}

class UsersListChanged extends UsersEvent {
  const UsersListChanged(this.users);

  final List<User> users;

  @override
  List<Object> get props => [users];
}

class UsersListRefresh extends UsersEvent {
  const UsersListRefresh();

  @override
  List<Object> get props => [];
}

class UsersConnectionStatusChanged extends UsersEvent {
  const UsersConnectionStatusChanged(this.connectionStatus);

  final ConnectionStatus connectionStatus;

  @override
  List<Object> get props => [connectionStatus];
}
