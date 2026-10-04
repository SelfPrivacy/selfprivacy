import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  GroupsBloc({
    required final Stream<CachedValue<List<String>>?> groups,
    required final Future<void> Function() refresh,
  }) : _refresh = refresh,
       super(GroupsInitial()) {
    on<_GroupsObserved>(_observe, transformer: sequential());
    on<GroupsListRefresh>(_reload, transformer: droppable());
    _subscription = groups.listen((final observation) {
      _latest = observation;
      add(_GroupsObserved(observation));
    });
  }

  final Future<void> Function() _refresh;
  late final StreamSubscription<CachedValue<List<String>>?> _subscription;
  CachedValue<List<String>>? _latest;

  void _observe(final _GroupsObserved event, final Emitter<GroupsState> emit) {
    final value = _latest == null ? null : event.observation;
    if (value == null) {
      emit(GroupsInitial());
    } else if (value.support == DomainSupport.unsupported) {
      emit(GroupsUnsupported());
    } else if (value.data case final groups?) {
      emit(GroupsLoaded(groups: groups));
    } else if (value.lastError != null) {
      emit(GroupsError());
    } else {
      emit(GroupsRefreshing(groups: const []));
    }
  }

  Future<void> refresh() => _refresh();

  Future<void> _reload(
    final GroupsListRefresh event,
    final Emitter<GroupsState> emit,
  ) async {
    if (isClosed || _latest == null) {
      return;
    }
    emit(GroupsRefreshing(groups: state.groups));
    await refresh();
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
