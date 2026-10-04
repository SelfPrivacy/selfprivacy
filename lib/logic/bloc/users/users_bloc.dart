import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({
    required final Stream<ConnectionObservation<CachedValue<List<User>>>> users,
    required final Future<void> Function() refresh,
    required final Future<ServerMutationResult<User>?> Function(
      ServerStateOrigin,
      User, {
      required bool create,
    })
    save,
  }) : _refresh = refresh,
       _save = save,
       super(UsersInitial()) {
    on<_UsersObserved>(_observe, transformer: sequential());
    on<UsersListRefresh>(_reload, transformer: droppable());
    _subscription = users.listen((final observation) {
      _latest = observation;
      add(_UsersObserved(observation));
    });
  }

  final Future<void> Function() _refresh;
  final Future<ServerMutationResult<User>?> Function(
    ServerStateOrigin,
    User, {
    required bool create,
  })
  _save;
  ServerStateOrigin? _presentedOrigin;
  late final StreamSubscription<ConnectionObservation<CachedValue<List<User>>>>
  _subscription;
  ConnectionObservation<CachedValue<List<User>>>? _latest;

  void _observe(final _UsersObserved event, final Emitter<UsersState> emit) {
    if (!identical(event.observation.origin, _latest?.origin)) {
      return;
    }
    final value = event.observation.value;
    final origin = event.observation.origin;
    _presentedOrigin = origin;
    if (value == null) {
      emit(UsersInitial());
    } else if (value.data case final users?) {
      emit(UsersLoaded(users: users, continuity: origin?.continuity));
    } else if (value.lastError != null) {
      emit(UsersError(continuity: origin?.continuity));
    } else {
      emit(UsersRefreshing(users: const [], continuity: origin?.continuity));
    }
  }

  Future<void> refresh() => _refresh();

  Future<ServerMutationResult<User>?> saveUser(
    final User user, {
    required final ConnectionContinuity continuity,
    required final bool create,
  }) async {
    final origin = _presentedOrigin;
    if (isClosed ||
        origin == null ||
        !identical(origin.continuity, continuity) ||
        !identical(origin.continuity, _latest?.origin?.continuity)) {
      return null;
    }
    final result = await _save(origin, user, create: create);
    return !isClosed &&
            identical(origin.continuity, _latest?.origin?.continuity)
        ? result
        : null;
  }

  Future<void> _reload(
    final UsersListRefresh event,
    final Emitter<UsersState> emit,
  ) async {
    if (_latest?.origin == null) {
      return;
    }
    emit(UsersRefreshing(users: state.users, continuity: state.continuity));
    await refresh();
  }

  @override
  Future<void> close() async {
    _latest = null;
    _presentedOrigin = null;
    await _subscription.cancel();
    return super.close();
  }
}
