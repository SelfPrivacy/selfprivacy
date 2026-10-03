import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';

part 'server_detailed_info_state.dart';

class ServerDetailsCubit extends Cubit<ServerDetailsState> {
  ServerDetailsCubit({
    required final Stream<ConnectionObservation<CachedValue<SystemSettings>>>
    settings,
    required final Future<List<ServerMetadataEntity>> Function(
      ServerStateOrigin,
    )
    loadMetadata,
    required final void Function() onMetadataFailure,
  }) : _loadMetadata = loadMetadata,
       _onMetadataFailure = onMetadataFailure,
       super(ServerDetailsInitial()) {
    _subscription = settings.listen(_observe);
  }

  final Future<List<ServerMetadataEntity>> Function(ServerStateOrigin)
  _loadMetadata;
  final void Function() _onMetadataFailure;
  late final StreamSubscription<
    ConnectionObservation<CachedValue<SystemSettings>>
  >
  _subscription;
  ServerStateOrigin? _origin;
  ServerStateOrigin? _requestedOrigin;

  void _observe(
    final ConnectionObservation<CachedValue<SystemSettings>> observation,
  ) {
    final origin = observation.origin;
    if (origin == null) {
      _origin = null;
      _requestedOrigin = null;
      emit(ServerDetailsNotReady());
      return;
    }
    if (!identical(origin.continuity, _origin?.continuity)) {
      emit(ServerDetailsLoading(continuity: origin.continuity));
    }
    _origin = origin;
    final settings = observation.value?.data;
    if (settings != null) {
      emit(
        Loaded(
          continuity: origin.continuity,
          metadata: state.metadata,
          serverTimezone: TimeZoneSettings.fromString(settings.timezone),
          autoUpgradeSettings: settings.autoUpgradeSettings,
          sshSettings: settings.sshSettings,
        ),
      );
      if (state.metadata.isEmpty && !identical(_requestedOrigin, origin)) {
        unawaited(check());
      }
    } else if (observation.value?.support == DomainSupport.unsupported ||
        observation.value?.lastError != null) {
      emit(
        ServerDetailsUnavailable(
          isUnsupported:
              observation.value?.support == DomainSupport.unsupported,
          continuity: origin.continuity,
          metadata: state.metadata,
        ),
      );
    } else {
      emit(ServerDetailsLoading(continuity: origin.continuity));
    }
  }

  Future<void> check() async {
    final origin = _origin;
    if (origin == null || isClosed) {
      return;
    }
    _requestedOrigin = origin;
    try {
      final metadata = await _loadMetadata(origin);
      if (!isClosed && identical(origin, _origin)) {
        emit(state.copyWith(metadata: metadata));
      }
    } catch (_) {
      if (!isClosed && identical(origin, _origin)) {
        _onMetadataFailure();
      }
    }
  }

  @override
  Future<void> close() async {
    _origin = null;
    await _subscription.cancel();
    return super.close();
  }
}
