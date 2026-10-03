part of 'groups_bloc.dart';

sealed class GroupsEvent extends Equatable {
  const GroupsEvent();
}

class _GroupsObserved extends GroupsEvent {
  const _GroupsObserved(this.observation);

  final ConnectionObservation<CachedValue<List<String>>> observation;

  @override
  List<Object> get props => [observation];
}

class GroupsListRefresh extends GroupsEvent {
  const GroupsListRefresh();

  @override
  List<Object> get props => [];
}
