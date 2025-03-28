part of 'groups_bloc.dart';

sealed class GroupsEvent extends Equatable {
  const GroupsEvent();
}

class GroupsListChanged extends GroupsEvent {
  const GroupsListChanged(this.groups);

  final List<String> groups;

  @override
  List<Object> get props => [groups];
}

class GroupsListRefresh extends GroupsEvent {
  const GroupsListRefresh();

  @override
  List<Object> get props => [];
}

class GroupsConnectionStatusChanged extends GroupsEvent {
  const GroupsConnectionStatusChanged(this.connectionStatus);

  final ConnectionStatus connectionStatus;

  @override
  List<Object?> get props => [connectionStatus];
}
