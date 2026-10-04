import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc({
    required final Stream<ConnectionObservation<CachedValue<List<Service>>>>
    services,
    required final Future<void> Function() refresh,
    required final Future<ServerMutationResult<void>?> Function(
      ServerStateOrigin,
      String,
    )
    restart,
    required final Future<ServerMutationResult<ServerJob>?> Function(
      ServerStateOrigin,
      String,
      String,
    )
    move,
    required final void Function(String) showMessage,
  }) : _refresh = refresh,
       _restart = restart,
       _move = move,
       _showMessage = showMessage,
       super(ServicesInitial()) {
    on<_ServicesObserved>(_observe, transformer: sequential());
    on<_ServiceAction<ServicesReload>>(_act, transformer: droppable());
    on<_ServiceAction<ServiceRestart>>(_act, transformer: sequential());
    on<_ServiceAction<ServiceMove>>(_act, transformer: sequential());
    _subscription = services.listen((final observation) {
      _latest = observation;
      add(_ServicesObserved(observation));
    });
  }

  final Future<void> Function() _refresh;
  final Future<ServerMutationResult<void>?> Function(ServerStateOrigin, String)
  _restart;
  final Future<ServerMutationResult<ServerJob>?> Function(
    ServerStateOrigin,
    String,
    String,
  )
  _move;
  final void Function(String) _showMessage;
  late final StreamSubscription<
    ConnectionObservation<CachedValue<List<Service>>>
  >
  _subscription;
  ConnectionObservation<CachedValue<List<Service>>>? _latest;
  ConnectionContinuity? _presentedContinuity;
  ServerStateOrigin? _presentedOrigin;

  @override
  void add(final ServicesEvent event) {
    super.add(switch (event) {
      ServicesReload() => _ServiceAction(event, _presentedOrigin),
      ServiceRestart() => _ServiceAction(event, _presentedOrigin),
      ServiceMove() => _ServiceAction(
        event,
        identical(event.continuity, _presentedOrigin?.continuity)
            ? _presentedOrigin
            : null,
      ),
      _ => event,
    });
  }

  void _observe(
    final _ServicesObserved event,
    final Emitter<ServicesState> emit,
  ) {
    if (!identical(event.observation.origin, _latest?.origin)) {
      return;
    }
    final continuity = event.observation.origin?.continuity;
    _presentedOrigin = event.observation.origin;
    final locks = identical(continuity, _presentedContinuity)
        ? state._lockedServices
        : <ServiceLock>[];
    _presentedContinuity = continuity;
    final value = event.observation.value;
    if (value == null) {
      emit(ServicesInitial());
    } else if (value.support == DomainSupport.unsupported) {
      emit(ServicesUnsupported());
    } else if (value.data case final services?) {
      emit(
        ServicesLoaded(
          services: services,
          lockedServices: locks,
          continuity: continuity,
        ),
      );
    } else if (value.lastError != null) {
      emit(ServicesError());
    } else {
      emit(ServicesLoading());
    }
  }

  bool _isCurrent(final ServerStateOrigin? origin) =>
      !isClosed &&
      origin != null &&
      identical(origin.continuity, _latest?.origin?.continuity);

  Future<void> _act(
    final _ServiceAction<ServicesEvent> action,
    final Emitter<ServicesState> emit,
  ) async {
    if (!_isCurrent(action.origin)) {
      return;
    }
    switch (action.event) {
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
        final result = await _restart(action.origin!, service.id);
        if (!_isCurrent(action.origin) || emit.isDone) {
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
      case ServiceMove(:final service, :final destination):
        final result = await _move(action.origin!, service.id, destination);
        if (_isCurrent(action.origin) &&
            (result?.outcome != ServerMutationOutcome.confirmed ||
                result?.payload.value == null)) {
          _report(result);
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
    await _subscription.cancel();
    return super.close();
  }
}
