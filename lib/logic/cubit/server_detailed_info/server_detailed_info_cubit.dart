import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';

part 'server_detailed_info_state.dart';

class ServerDetailsCubit extends Cubit<ServerDetailsState> {
  ServerDetailsCubit({
    required final Stream<CachedValue<SystemSettings>?> settings,
    required final Future<List<ServerMetadataEntity>> Function() loadMetadata,
    required final void Function() onMetadataFailure,
  }) : _loadMetadata = loadMetadata,
       _onMetadataFailure = onMetadataFailure,
       super(ServerDetailsInitial()) {
    _subscription = settings.listen(_observe);
  }

  final Future<List<ServerMetadataEntity>> Function() _loadMetadata;
  final void Function() _onMetadataFailure;
  late final StreamSubscription<CachedValue<SystemSettings>?> _subscription;
  bool _attached = false;
  bool _metadataRequested = false;

  void _observe(final CachedValue<SystemSettings>? observation) {
    _attached = observation != null;
    if (!_attached) {
      emit(ServerDetailsNotReady());
      return;
    }
    final settings = observation?.data;
    if (settings != null) {
      emit(
        Loaded(
          metadata: state.metadata,
          serverTimezone: TimeZoneSettings.fromString(settings.timezone),
          autoUpgradeSettings: settings.autoUpgradeSettings,
          sshSettings: settings.sshSettings,
        ),
      );
      if (state.metadata.isEmpty && !_metadataRequested) {
        unawaited(check());
      }
    } else if (observation?.support == DomainSupport.unsupported ||
        observation?.lastError != null) {
      emit(
        ServerDetailsUnavailable(
          isUnsupported: observation?.support == DomainSupport.unsupported,
          metadata: state.metadata,
        ),
      );
    } else {
      emit(ServerDetailsLoading());
    }
  }

  Future<void> check() async {
    if (!_attached || isClosed) {
      return;
    }
    _metadataRequested = true;
    try {
      final metadata = await _loadMetadata();
      if (!isClosed && _attached) {
        emit(state.copyWith(metadata: metadata));
      }
    } catch (_) {
      if (!isClosed && _attached) {
        _onMetadataFailure();
      }
    }
  }

  @override
  Future<void> close() async {
    _attached = false;
    await _subscription.cancel();
    return super.close();
  }
}
