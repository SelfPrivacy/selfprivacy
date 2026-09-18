import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/utils/fake_data.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

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
    emit(
      DevicesDeleting(
        devices: state.devices
            .where((final d) => d.name != event.device.name)
            .toList(),
      ),
    );

    final response = await getIt<ApiConnectionRepository>().api.deleteApiToken(
      event.device.name,
    );
    if (response.outcome == ServerMutationOutcome.confirmed) {
      getIt<ApiConnectionRepository>().apiData.devices.invalidate();
      emit(
        DevicesLoaded(
          devices: state.devices
              .where((final d) => d.name != event.device.name)
              .toList(),
        ),
      );
    } else {
      getIt<NavigationService>().showSnackBar(serverMutationMessage(response));
      emit(DevicesLoaded(devices: state.devices));
    }
  }

  Future<String?> getNewDeviceKey() async {
    final response = await getIt<ApiConnectionRepository>().api
        .createDeviceToken();
    final secret = response.confirmedSecret;
    if (secret != null) {
      return secret;
    } else {
      getIt<NavigationService>().showSnackBar(
        serverMutationMessage(response, sensitive: true),
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
