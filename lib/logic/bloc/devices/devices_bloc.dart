import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/sync/operation_execution.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/connection/sync/secret_recipient.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  DevicesBloc() : super(DevicesInitial()) {
    on<DevicesListChanged>(
      _mapDevicesListChangedToState,
      transformer: sequential(),
    );
    on<DeleteDevice>(_mapDeleteDeviceToState, transformer: droppable());

    final apiConnectionRepository = getIt<ApiConnectionRepository>();
    _devicesSubscription = apiConnectionRepository.devicesStream.listen((
      final snapshot,
    ) {
      add(DevicesListChanged(snapshot));
    });
    add(DevicesListChanged(apiConnectionRepository.devicesSnapshot));
  }

  StreamSubscription<CachedValue<List<ApiToken>>>? _devicesSubscription;

  Future<void> _mapDevicesListChangedToState(
    final DevicesListChanged event,
    final Emitter<DevicesState> emit,
  ) async {
    emit(_fromSnapshot(event.snapshot));
  }

  String? _pendingDeviceName;

  DevicesState _fromSnapshot(final CachedValue<List<ApiToken>> snapshot) {
    final devices = snapshot.data;
    if (devices == null) {
      return snapshot.lastError == null &&
              snapshot.support != DomainSupport.unsupported
          ? DevicesInitial()
          : DevicesError();
    }
    if (_pendingDeviceName case final String name) {
      return DevicesDeleting(
        devices: devices,
        pendingDeviceName: name,
        hasError: snapshot.lastError != null,
      );
    }
    return DevicesLoaded(
      devices: devices,
      hasError: snapshot.lastError != null,
      isRefreshing: snapshot.isRefreshing,
    );
  }

  Future<void> refresh() => getIt<ApiConnectionRepository>().refreshDevices();

  Future<void> _mapDeleteDeviceToState(
    final DeleteDevice event,
    final Emitter<DevicesState> emit,
  ) async {
    if (!state.devices.any(
      (final device) => device.name == event.device.name && !device.isCaller,
    )) {
      return;
    }
    final repository = getIt<ApiConnectionRepository>();
    _pendingDeviceName = event.device.name;
    emit(_fromSnapshot(repository.devicesSnapshot));
    final completion = await repository.revokeDevice(event.device.name);
    _pendingDeviceName = null;
    if (emit.isDone) {
      return;
    }
    final response = completion?.result;
    if (completion?.application != CommandApplication.detached &&
        response != null &&
        response.outcome != ServerMutationOutcome.confirmed) {
      getIt<NavigationService>().showSnackBar(serverMutationMessage(response));
    }
    emit(_fromSnapshot(repository.devicesSnapshot));
  }

  Future<String?> getNewDeviceKey({final SecretRecipient? recipient}) async {
    final target = recipient ?? SecretRecipient();
    final response = await target.receive(
      getIt<ApiConnectionRepository>().hub.submit(
        OperationKind.generateDeviceKey,
        (final owner) => target.protect(() async {
          final response = await owner.api.createDeviceToken();
          OperationExecution.current?.record(response);
          return response;
        }),
      ),
    );
    if (response == null) {
      return null;
    }
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
  Future<void> close() async {
    await _devicesSubscription?.cancel();
    return super.close();
  }
}
