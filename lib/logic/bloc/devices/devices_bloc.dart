import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/utils/fake_data.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  DevicesBloc() : super(DevicesInitial()) {
    on<DevicesListChanged>(
      _mapDevicesListChangedToState,
      transformer: sequential(),
    );
    on<DeleteDevice>(_mapDeleteDeviceToState, transformer: sequential());

    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _apiDataSubscription = apiConnectionRepository.dataStream.listen((
      final ApiData apiData,
    ) {
      add(DevicesListChanged(apiData.devices.data));
    });
  }

  StreamSubscription? _apiDataSubscription;

  Future<void> _mapDevicesListChangedToState(
    final DevicesListChanged event,
    final Emitter<DevicesState> emit,
  ) async {
    if (state is DevicesDeleting) {
      return;
    }
    if (event.devices == null) {
      emit(DevicesError());
      return;
    }
    emit(DevicesLoaded(devices: event.devices!));
  }

  Future<void> refresh() async {
    getIt<ApiConnectionRepository>().apiData.devices.invalidate();
    await getIt<ApiConnectionRepository>().reload(null);
  }

  Future<void> _mapDeleteDeviceToState(
    final DeleteDevice event,
    final Emitter<DevicesState> emit,
  ) async {
    // Optimistically remove the device from the list
    emit(
      DevicesDeleting(
        devices:
            state.devices
                .where((final d) => d.name != event.device.name)
                .toList(),
      ),
    );

    final GenericResult<void> response = await getIt<ApiConnectionRepository>()
        .api
        .deleteApiToken(event.device.name);
    if (response.success) {
      getIt<ApiConnectionRepository>().apiData.devices.invalidate();
      emit(
        DevicesLoaded(
          devices:
              state.devices
                  .where((final d) => d.name != event.device.name)
                  .toList(),
        ),
      );
    } else {
      getIt<NavigationService>().showSnackBar(
        response.message ?? 'Error deleting device',
      );
      emit(DevicesLoaded(devices: state.devices));
    }
  }

  Future<String?> getNewDeviceKey() async {
    final GenericResult<String> response =
        await getIt<ApiConnectionRepository>().api.createDeviceToken();
    if (response.success) {
      return response.data;
    } else {
      getIt<NavigationService>().showSnackBar(
        response.message ?? 'Error getting new device key',
      );
      return null;
    }
  }

  @override
  void onChange(final Change<DevicesState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    await _apiDataSubscription?.cancel();
    return super.close();
  }
}
