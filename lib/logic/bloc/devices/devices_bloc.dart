import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/operations/secret_recipient.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  DevicesBloc({
    required final Stream<CachedValue<List<ApiToken>>?> devices,
    required final Future<void> Function() refresh,
    required final Future<CommandCompletion<void>?> Function(String) revoke,
    required final Future<ServerMutationResult<String>?> Function(
      SecretRecipient,
    )
    generateKey,
    required final void Function(String) showMessage,
    required this.rotationChanges,
    required this.cancelRotation,
    required final Future<RotationOutcome> Function() rotateToken,
  }) : _rotateToken = rotateToken,
       _refresh = refresh,
       _revoke = revoke,
       _generateKey = generateKey,
       _showMessage = showMessage,
       super(DevicesInitial()) {
    on<_DevicesObserved>(_observe, transformer: sequential());
    on<DeleteDevice>(_delete, transformer: droppable());
    on<RotateDeviceToken>(_rotate, transformer: droppable());
    _subscription = devices.listen((final observation) {
      _latest = observation;
      add(_DevicesObserved(observation));
    });
  }

  final Future<void> Function() _refresh;
  final Future<RotationOutcome> Function() _rotateToken;
  final Future<CommandCompletion<void>?> Function(String) _revoke;
  final Future<ServerMutationResult<String>?> Function(SecretRecipient)
  _generateKey;
  final void Function(String) _showMessage;
  final Stream<RotationStatus> rotationChanges;
  final bool Function() cancelRotation;
  final _recipients = <SecretRecipient>{};
  late final StreamSubscription<CachedValue<List<ApiToken>>?> _subscription;
  CachedValue<List<ApiToken>>? _latest;

  void _observe(
    final _DevicesObserved event,
    final Emitter<DevicesState> emit,
  ) {
    emit(
      event.observation == null
          ? DevicesInitial()
          : _fromSnapshot(event.observation!),
    );
  }

  bool get _isActive => !isClosed && _latest != null;

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

  Future<void> refresh() => _refresh();

  Future<void> _rotate(
    final RotateDeviceToken event,
    final Emitter<DevicesState> emit,
  ) async {
    if (!_isActive) {
      return;
    }
    final outcome = await _rotateToken();
    if (!_isActive || emit.isDone) {
      return;
    }
    final message = switch (outcome) {
      RotationOutcome.succeeded =>
        'devices.refresh_token_alert.success_refresh_token',
      RotationOutcome.rejected => 'server_mutation.rejected',
      RotationOutcome.cancelled ||
      RotationOutcome.detached => 'server_mutation.not_sent',
      _ => 'server_mutation.outcome_unknown',
    };
    _showMessage(message.tr());
  }

  Future<void> _delete(
    final DeleteDevice event,
    final Emitter<DevicesState> emit,
  ) async {
    if (!_isActive ||
        !(_latest?.data?.any(
              (final device) =>
                  device.name == event.device.name && !device.isCaller,
            ) ??
            false)) {
      return;
    }
    _pendingDeviceName = event.device.name;
    emit(_fromSnapshot(_latest!));
    final completion = await _revoke(event.device.name);
    if (!_isActive || emit.isDone) {
      return;
    }
    _pendingDeviceName = null;
    final response = completion?.result;
    if (completion?.application != CommandApplication.detached &&
        response != null &&
        response.outcome != ServerMutationOutcome.confirmed) {
      _showMessage(serverMutationMessage(response));
    }
    emit(_fromSnapshot(_latest!));
  }

  Future<String?> getNewDeviceKey({final SecretRecipient? recipient}) async {
    if (!_isActive) {
      return null;
    }
    final target = recipient ?? SecretRecipient();
    if (recipient == null) {
      _recipients.add(target);
    }
    try {
      final response = await _generateKey(target);
      if (response == null || !_isActive) {
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
    _latest = null;
    for (final recipient in _recipients) {
      recipient.dispose();
    }
    _recipients.clear();
    await _subscription.cancel();
    return super.close();
  }
}
