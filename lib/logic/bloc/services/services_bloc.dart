import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/models/service.dart';

import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<ServicesListUpdate>(_updateList, transformer: sequential());
    on<ServicesReload>(_reload, transformer: droppable());
    on<ServiceRestart>(_restart, transformer: sequential());
    on<ServiceMove>(_move, transformer: sequential());

    final connectionRepository = getIt<ApiConnectionRepository>();

    _apiDataSubscription = connectionRepository.dataStream.listen((
      final ApiData apiData,
    ) {
      add(ServicesListUpdate([...apiData.services.data ?? []]));
    });

    if (connectionRepository.connectionStatus == ConnectionStatus.connected) {
      add(
        ServicesListUpdate([
          ...connectionRepository.apiData.services.data ?? [],
        ]),
      );
    }
  }

  Future<void> _updateList(
    final ServicesListUpdate event,
    final Emitter<ServicesState> emit,
  ) async {
    if (event.services.isEmpty) {
      emit(ServicesInitial());
      return;
    }
    final newState = ServicesLoaded(
      services: event.services,
      lockedServices: state._lockedServices,
    );
    emit(newState);
  }

  Future<void> _reload(
    final ServicesReload event,
    final Emitter<ServicesState> emit,
  ) async {
    final currentState = state;
    if (currentState is ServicesLoaded) {
      emit(ServicesReloading.fromState(currentState));
      await getIt<ApiConnectionRepository>().connection?.services.refresh(
        force: true,
      );
    }
  }

  Future<void> awaitReload() async {
    final currentState = state;
    if (currentState is ServicesLoaded) {
      await getIt<ApiConnectionRepository>().connection?.services.refresh(
        force: true,
      );
    }
  }

  Future<void> _restart(
    final ServiceRestart event,
    final Emitter<ServicesState> emit,
  ) async {
    final connection = getIt<ApiConnectionRepository>().connection;
    if (connection == null) {
      return;
    }
    emit(
      state.copyWith(
        lockedServices: [
          ...state._lockedServices,
          ServiceLock(
            serviceId: event.service.id,
            lockDuration: const Duration(seconds: 15),
          ),
        ],
      ),
    );
    final result = await connection.services.restart(event.service.id);
    if (result.outcome != ServerMutationOutcome.confirmed) {
      emit(
        state.copyWith(
          lockedServices: state._lockedServices
              .where((final lock) => lock.serviceId != event.service.id)
              .toList(),
        ),
      );
      getIt<NavigationService>().showSnackBar(serverMutationMessage(result));
      return;
    }
  }

  Future<void> _move(
    final ServiceMove event,
    final Emitter<ServicesState> emit,
  ) async {
    final connection = getIt<ApiConnectionRepository>().connection;
    if (connection == null) {
      return;
    }
    final result = await connection.services.move(
      event.service.id,
      event.destination,
    );
    if (result.outcome != ServerMutationOutcome.confirmed) {
      getIt<NavigationService>().showSnackBar(serverMutationMessage(result));
      return;
    }
    if (result.payload.value == null) {
      getIt<NavigationService>().showSnackBar(serverMutationMessage(result));
    }
  }

  late StreamSubscription _apiDataSubscription;

  @override
  void onChange(final Change<ServicesState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    await _apiDataSubscription.cancel();
    return super.close();
  }
}
