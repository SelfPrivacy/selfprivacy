import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  GroupsBloc() : super(GroupsInitial()) {
    on<GroupsListChanged>(_updateList, transformer: sequential());
    on<GroupsListRefresh>(_reload, transformer: droppable());
    on<GroupsConnectionStatusChanged>(
      _mapConnectionStatusChangedToState,
      transformer: sequential(),
    );

    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiConnectionStatusSubscription = apiConnectionRepository
        .connectionStatusStream
        .listen((final ConnectionStatus connectionStatus) {
          add(GroupsConnectionStatusChanged(connectionStatus));
        });
    _apiDataSubscription = apiConnectionRepository.dataStream.listen((
      final ApiData apiData,
    ) {
      add(GroupsListChanged(apiData.groups.data ?? []));
    });
  }

  Future<void> _updateList(
    final GroupsListChanged event,
    final Emitter<GroupsState> emit,
  ) async {
    if (event.groups.isEmpty) {
      emit(GroupsInitial());
      return;
    }
    final newState = GroupsLoaded(groups: event.groups);
    emit(newState);
  }

  Future<void> refresh() async {
    getIt<ApiConnectionRepository>().apiData.groups.invalidate();
    await getIt<ApiConnectionRepository>().reload(null);
  }

  Future<void> _reload(
    final GroupsListRefresh event,
    final Emitter<GroupsState> emit,
  ) async {
    emit(GroupsRefreshing(groups: state.groups));
    await refresh();
  }

  Future<void> _mapConnectionStatusChangedToState(
    final GroupsConnectionStatusChanged event,
    final Emitter<GroupsState> emit,
  ) async {
    switch (event.connectionStatus) {
      case ConnectionStatus.nonexistent:
        emit(GroupsInitial());
      case ConnectionStatus.reconnecting:
      case ConnectionStatus.connected:
        if (state is! GroupsLoaded) {
          emit(GroupsRefreshing(groups: state.groups));
        }
      case ConnectionStatus.offline:
      case ConnectionStatus.unauthorized:
        break;
    }
  }

  StreamSubscription? _apiDataSubscription;
  StreamSubscription? _apiConnectionStatusSubscription;

  @override
  void onChange(final Change<GroupsState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    await _apiDataSubscription?.cancel();
    await _apiConnectionStatusSubscription?.cancel();
    return super.close();
  }
}
