import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/sync/secret_recipient.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  DevicesBloc({
    required final Stream<ConnectionObservation<CachedValue<List<ApiToken>>>>
    devices,
    required final Future<void> Function() refresh,
    required final Future<CommandCompletion<void>?> Function(
      ServerStateOrigin,
      String,
    )
    revoke,
    required final Future<ServerMutationResult<String>?> Function(
      ServerStateOrigin,
      SecretRecipient,
    )
    generateKey,
    required final void Function(String) showMessage,
    required this.rotationChanges,
    required this.cancelRotation,
  }) : _refresh = refresh,
       _revoke = revoke,
       _generateKey = generateKey,
       _showMessage = showMessage,
       super(DevicesInitial()) {
    on<_DevicesObserved>(_observe, transformer: sequential());
    on<DeleteDevice>(_delete, transformer: droppable());
    _subscription = devices.listen((final observation) {
      if (!identical(
        _latest?.origin?.continuity,
        observation.origin?.continuity,
      )) {
        _pendingDeviceName = null;
      }
      _latest = observation;
      add(_DevicesObserved(observation));
    });
  }

  final Future<void> Function() _refresh;
  final Future<CommandCompletion<void>?> Function(ServerStateOrigin, String)
  _revoke;
  final Future<ServerMutationResult<String>?> Function(
    ServerStateOrigin,
    SecretRecipient,
  )
  _generateKey;
  final void Function(String) _showMessage;
  final Stream<RotationStatus> rotationChanges;
  final bool Function() cancelRotation;
  final _recipients = <SecretRecipient>{};
  late final StreamSubscription<
    ConnectionObservation<CachedValue<List<ApiToken>>>
  >
  _subscription;
  ConnectionObservation<CachedValue<List<ApiToken>>>? _latest;
  ServerStateOrigin? _presentedOrigin;

  void _observe(
    final _DevicesObserved event,
    final Emitter<DevicesState> emit,
  ) {
    if (!identical(event.observation.origin, _latest?.origin)) {
      return;
    }
    _presentedOrigin = event.observation.origin;
    emit(
      event.observation.value == null
          ? DevicesInitial()
          : _fromSnapshot(event.observation.value!),
    );
  }

  bool _isCurrent(final ServerStateOrigin? origin) =>
      !isClosed &&
      origin != null &&
      identical(origin.continuity, _latest?.origin?.continuity);

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
        origin: _presentedOrigin,
        devices: devices,
        pendingDeviceName: name,
        hasError: snapshot.lastError != null,
      );
    }
    return DevicesLoaded(
      origin: _presentedOrigin,
      devices: devices,
      hasError: snapshot.lastError != null,
      isRefreshing: snapshot.isRefreshing,
    );
  }

  Future<void> refresh() => _refresh();

  Future<void> _delete(
    final DeleteDevice event,
    final Emitter<DevicesState> emit,
  ) async {
    if (!_isCurrent(event.origin) ||
        !(_latest?.value?.data?.any(
              (final device) =>
                  device.name == event.device.name && !device.isCaller,
            ) ??
            false)) {
      return;
    }
    _pendingDeviceName = event.device.name;
    emit(_fromSnapshot(_latest!.value!));
    final completion = await _revoke(event.origin!, event.device.name);
    if (!_isCurrent(event.origin) || emit.isDone) {
      return;
    }
    _pendingDeviceName = null;
    final response = completion?.result;
    if (completion?.application != CommandApplication.detached &&
        response != null &&
        response.outcome != ServerMutationOutcome.confirmed) {
      _showMessage(serverMutationMessage(response));
    }
    emit(_fromSnapshot(_latest!.value!));
  }

  Future<String?> getNewDeviceKey({final SecretRecipient? recipient}) async {
    final origin = _presentedOrigin;
    if (!_isCurrent(origin)) {
      return null;
    }
    final target = recipient ?? SecretRecipient();
    if (recipient == null) {
      _recipients.add(target);
    }
    try {
      final response = await _generateKey(origin!, target);
      if (response == null || !_isCurrent(origin)) {
        return null;
      }
      final secret = response.confirmedSecret;
      if (secret == null) {
        _showMessage(serverMutationMessage(response, sensitive: true));
      }
      return secret;
    } finally {
      if (_recipients.remove(target)) {
        target.dispose();
      }
    }
  }

  @override
  Future<void> close() async {
    for (final recipient in _recipients) {
      recipient.dispose();
    }
    _recipients.clear();
    await _subscription.cancel();
    return super.close();
  }
}
