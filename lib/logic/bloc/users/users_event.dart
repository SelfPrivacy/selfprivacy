part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();
}

class _UsersObserved extends UsersEvent {
  const _UsersObserved(this.observation);

  final ConnectionObservation<CachedValue<List<User>>> observation;

  @override
  List<Object> get props => [observation];
}

class UsersListRefresh extends UsersEvent {
  const UsersListRefresh();

  @override
  List<Object> get props => [];
}
