import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc({
    required final Stream<CachedValue<List<Service>>?> services,
    required final Future<void> Function() refresh,
    required final Future<ServerMutationResult<void>?> Function(String) restart,
    required final Future<List<ServerMutationResult<ServerJob>>?> Function(
      Map<String, String>,
    )
    move,
    required final void Function(String) showMessage,
  }) : _refresh = refresh,
       _restart = restart,
       _move = move,
       _showMessage = showMessage,
       super(ServicesInitial()) {
    on<_ServicesObserved>(_observe, transformer: sequential());
    on<ServicesReload>(_act, transformer: droppable());
    on<ServiceRestart>(_act, transformer: sequential());
    on<ServicesMove>(_act, transformer: sequential());
    _subscription = services.listen((final observation) {
      _latest = observation;
      add(_ServicesObserved(observation));
    });
  }

  final Future<void> Function() _refresh;
  final Future<ServerMutationResult<void>?> Function(String) _restart;
  final Future<List<ServerMutationResult<ServerJob>>?> Function(
    Map<String, String>,
  )
  _move;
  final void Function(String) _showMessage;
  late final StreamSubscription<CachedValue<List<Service>>?> _subscription;
  CachedValue<List<Service>>? _latest;

  void _observe(
    final _ServicesObserved event,
    final Emitter<ServicesState> emit,
  ) {
    final locks = state._lockedServices;
    final value = event.observation;
    if (value == null) {
      emit(ServicesInitial());
    } else if (value.support == DomainSupport.unsupported) {
      emit(ServicesUnsupported());
    } else if (value.data case final services?) {
      emit(ServicesLoaded(services: services, lockedServices: locks));
    } else if (value.lastError != null) {
      emit(ServicesError());
    } else {
      emit(ServicesLoading());
    }
  }

  bool get _isActive => !isClosed && _latest != null;

  Future<void> _act(
    final ServicesEvent action,
    final Emitter<ServicesState> emit,
  ) async {
    if (!_isActive) {
      return;
    }
    switch (action) {
      case ServicesReload():
        if (state case final ServicesLoaded loaded) {
          emit(ServicesReloading.fromState(loaded));
        }
        await _refresh();
      case ServiceRestart(:final service):
        emit(
          state.copyWith(
            lockedServices: [
              ...state._lockedServices,
              ServiceLock(
                serviceId: service.id,
                lockDuration: const Duration(seconds: 15),
              ),
            ],
          ),
        );
        final result = await _restart(service.id);
        if (!_isActive || emit.isDone) {
          return;
        }
        if (result?.outcome != ServerMutationOutcome.confirmed) {
          emit(
            state.copyWith(
              lockedServices: state._lockedServices
                  .where((final lock) => lock.serviceId != service.id)
                  .toList(),
            ),
          );
          _report(result);
        }
      case ServicesMove(:final destinations):
        final results = await _move(destinations);
        if (!_isActive) {
          return;
        }
        if (results == null) {
          _report<ServerJob>(null);
          return;
        }
        for (final result in results) {
          if (result.outcome != ServerMutationOutcome.confirmed ||
              result.payload.value == null) {
            _report(result);
          }
        }
      case _:
        throw StateError('Unsupported service action');
    }
  }

  void _report<T>(final ServerMutationResult<T>? result) => _showMessage(
    result == null
        ? OperationStatus.notSent.translationKey.tr()
        : serverMutationMessage(result),
  );

  Future<void> awaitReload() => _refresh();

  @override
  Future<void> close() async {
    _latest = null;
    await _subscription.cancel();
    return super.close();
  }
}
