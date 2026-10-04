import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({
    required final Stream<CachedValue<List<User>>?> users,
    required final Future<void> Function() refresh,
    required final Future<ServerMutationResult<User>?> Function(
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

  bool get _isActive => !isClosed && _latest != null;

  final Future<void> Function() _refresh;
  final Future<ServerMutationResult<User>?> Function(
    User, {
    required bool create,
  })
  _save;
  late final StreamSubscription<CachedValue<List<User>>?> _subscription;
  CachedValue<List<User>>? _latest;

  void _observe(final _UsersObserved event, final Emitter<UsersState> emit) {
    final value = _latest == null ? null : event.observation;
    if (value == null) {
      emit(UsersInitial());
    } else if (value.data case final users?) {
      emit(UsersLoaded(users: users));
    } else if (value.lastError != null) {
      emit(UsersError());
    } else {
      emit(UsersRefreshing(users: const []));
    }
  }

  Future<void> refresh() => _refresh();

  Future<ServerMutationResult<User>?> saveUser(
    final User user, {
    required final bool create,
  }) async {
    if (!_isActive) {
      return null;
    }
    final result = await _save(user, create: create);
    return _isActive ? result : null;
  }

  Future<void> _reload(
    final UsersListRefresh event,
    final Emitter<UsersState> emit,
  ) async {
    if (!_isActive) {
      return;
    }
    emit(UsersRefreshing(users: state.users));
    await refresh();
  }

  @override
  Future<void> close() async {
    _latest = null;
    await _subscription.cancel();
    return super.close();
  }
}
