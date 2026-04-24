import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<UsersListChanged>(_updateList, transformer: sequential());
    on<UsersListRefresh>(_reload, transformer: droppable());
    on<UsersConnectionStatusChanged>(
      _mapConnectionStatusChangedToState,
      transformer: sequential(),
    );

    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiConnectionStatusSubscription = apiConnectionRepository
        .connectionStatusStream
        .listen((final ConnectionStatus connectionStatus) {
          add(UsersConnectionStatusChanged(connectionStatus));
        });
    _apiDataSubscription = apiConnectionRepository.dataStream.listen((
      final ApiData apiData,
    ) {
      add(UsersListChanged(apiData.users.data ?? []));
    });
  }

  Future<void> _updateList(
    final UsersListChanged event,
    final Emitter<UsersState> emit,
  ) async {
    if (event.users.isEmpty) {
      emit(UsersInitial());
      return;
    }
    final newState = UsersLoaded(users: event.users);
    emit(newState);
  }

  Future<void> refresh() async {
    getIt<ApiConnectionRepository>().apiData.users.invalidate();
    await getIt<ApiConnectionRepository>().reload(null);
  }

  Future<void> _reload(
    final UsersListRefresh event,
    final Emitter<UsersState> emit,
  ) async {
    emit(UsersRefreshing(users: state.users));
    await refresh();
  }

  Future<void> _mapConnectionStatusChangedToState(
    final UsersConnectionStatusChanged event,
    final Emitter<UsersState> emit,
  ) async {
    switch (event.connectionStatus) {
      case ConnectionStatus.nonexistent:
        emit(UsersInitial());
      case ConnectionStatus.reconnecting:
      case ConnectionStatus.connected:
        if (state is! UsersLoaded) {
          emit(UsersRefreshing(users: state.users));
        }
      case ConnectionStatus.offline:
      case ConnectionStatus.unauthorized:
        break;
    }
  }

  StreamSubscription? _apiDataSubscription;
  StreamSubscription? _apiConnectionStatusSubscription;

  @override
  void onChange(final Change<UsersState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    await _apiDataSubscription?.cancel();
    await _apiConnectionStatusSubscription?.cancel();
    return super.close();
  }
}
