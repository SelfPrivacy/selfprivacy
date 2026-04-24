import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';

import 'package:selfprivacy/logic/models/service.dart';

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
      getIt<ApiConnectionRepository>().apiData.services.invalidate();
      await getIt<ApiConnectionRepository>().reload(null);
    }
  }

  Future<void> awaitReload() async {
    final currentState = state;
    if (currentState is ServicesLoaded) {
      getIt<ApiConnectionRepository>().apiData.services.invalidate();
      await getIt<ApiConnectionRepository>().reload(null);
    }
  }

  Future<void> _restart(
    final ServiceRestart event,
    final Emitter<ServicesState> emit,
  ) async {
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
    final result = await getIt<ApiConnectionRepository>().api.restartService(
      event.service.id,
    );
    if (!result.success) {
      getIt<NavigationService>().showSnackBar('jobs.generic_error'.tr());
      return;
    }
    if (!result.data) {
      getIt<NavigationService>().showSnackBar(
        result.message ?? 'jobs.generic_error'.tr(),
      );
      return;
    }
  }

  Future<void> _move(
    final ServiceMove event,
    final Emitter<ServicesState> emit,
  ) async {
    final migrationJob = await getIt<ApiConnectionRepository>().api.moveService(
      event.service.id,
      event.destination,
    );
    if (!migrationJob.success) {
      getIt<NavigationService>().showSnackBar(
        migrationJob.message ?? 'jobs.generic_error'.tr(),
      );
    }
    if (migrationJob.data != null) {
      getIt<ApiConnectionRepository>().apiData.serverJobs.data?.add(
        migrationJob.data!,
      );
      getIt<ApiConnectionRepository>().emitData();
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
