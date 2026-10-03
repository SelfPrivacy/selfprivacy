import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/volumes/volume_resize_workflow.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'volumes_event.dart';
part 'volumes_state.dart';

typedef ResizeVolume =
    Future<OperationResult<ServerMutationResult<void>?>> Function(
      ServerStateOrigin origin,
      DiskVolume volume,
      DiskSize size,
      void Function(VolumeResizeStage) onProgress,
    );

class VolumesBloc extends Bloc<VolumesEvent, VolumesState> {
  VolumesBloc({
    required final Stream<
      ConnectionObservation<CachedValue<List<ServerDiskVolume>>>
    >
    volumes,
    required final Stream<void> providerChanges,
    required final Future<List<ServerProviderVolume>> Function(
      ServerStateOrigin,
    )
    loadProviderVolumes,
    required final Future<Price?> Function(ServerStateOrigin, String?)
    loadPrice,
    required final ResizeVolume resize,
    required final void Function(String) showMessage,
  }) : _loadProviderVolumes = loadProviderVolumes,
       _loadPrice = loadPrice,
       _resize = resize,
       _showMessage = showMessage,
       super(VolumesInitial()) {
    on<_VolumesObserved>(_observe, transformer: sequential());
    on<_LoadProviderVolumes>(_loadProvider, transformer: restartable());
    on<_ResizeVolume>(_resizeVolume, transformer: droppable());
    _subscription = volumes.listen((final observation) {
      _latest = observation;
      add(_VolumesObserved(observation));
    });
    _providerSubscription = providerChanges.listen((_) {
      if (_presentedOrigin case final origin?) {
        add(_LoadProviderVolumes(origin));
      }
    });
  }

  final Future<List<ServerProviderVolume>> Function(ServerStateOrigin)
  _loadProviderVolumes;
  final Future<Price?> Function(ServerStateOrigin, String?) _loadPrice;
  final ResizeVolume _resize;
  final void Function(String) _showMessage;
  late final StreamSubscription<
    ConnectionObservation<CachedValue<List<ServerDiskVolume>>>
  >
  _subscription;
  late final StreamSubscription<void> _providerSubscription;
  ConnectionObservation<CachedValue<List<ServerDiskVolume>>>? _latest;
  ServerStateOrigin? _presentedOrigin;
  bool _resizing = false;

  @override
  void add(final VolumesEvent event) => super.add(
    event is VolumeResize ? _ResizeVolume(event, _presentedOrigin) : event,
  );

  bool _isCurrent(final ServerStateOrigin? origin) =>
      !isClosed &&
      origin != null &&
      identical(origin.continuity, _latest?.origin?.continuity);

  void _observe(
    final _VolumesObserved event,
    final Emitter<VolumesState> emit,
  ) {
    if (!identical(event.observation.origin, _latest?.origin)) {
      return;
    }
    final origin = event.observation.origin;
    final previous = _presentedOrigin;
    if (!identical(previous?.continuity, origin?.continuity)) {
      _resizing = false;
      emit(VolumesInitial());
    }
    _presentedOrigin = origin;
    if (origin == null) {
      emit(VolumesInitial());
      return;
    }
    _publish(emit);
    if (!identical(previous, origin)) {
      add(_LoadProviderVolumes(origin));
    }
  }

  void _publish(
    final Emitter<VolumesState> emit, [
    final List<ServerProviderVolume>? providers,
  ]) {
    final providerVolumes = providers ?? state.providerVolumes;
    final volumes = _latest?.value?.data;
    if (volumes == null) {
      final snapshot = _latest?.value;
      final unsupported = snapshot?.support == DomainSupport.unsupported;
      emit(
        unsupported || snapshot?.lastError != null
            ? VolumesUnavailable(
                isUnsupported: unsupported,
                providerVolumes: providerVolumes,
              )
            : VolumesLoading(providerVolumes: providerVolumes),
      );
      return;
    }
    final diskStatus = DiskStatus.fromVolumes(volumes, providerVolumes);
    final hash = Object.hashAll(volumes);
    emit(
      _resizing
          ? VolumesResizing(
              diskStatus: diskStatus,
              providerVolumes: providerVolumes,
              serverVolumesHashCode: hash,
            )
          : VolumesLoaded(
              diskStatus: diskStatus,
              providerVolumes: providerVolumes,
              serverVolumesHashCode: hash,
            ),
    );
  }

  Future<void> _loadProvider(
    final _LoadProviderVolumes event,
    final Emitter<VolumesState> emit,
  ) async {
    if (!identical(event.origin, _latest?.origin)) {
      return;
    }
    try {
      final providers = await _loadProviderVolumes(event.origin);
      if (!emit.isDone &&
          !isClosed &&
          identical(event.origin, _latest?.origin)) {
        _publish(emit, providers);
      }
    } on Exception {
      // Server disk data remains available when provider metadata cannot load.
    }
  }

  Future<Price?> getPricePerGb() async {
    final origin = _presentedOrigin;
    if (!_isCurrent(origin)) {
      return null;
    }
    try {
      final price = await _loadPrice(origin!, state.location);
      return _isCurrent(origin) ? price : null;
    } on Exception {
      if (_isCurrent(origin)) {
        _showMessage('server.pricing_error'.tr());
      }
      return null;
    }
  }

  Future<void> _resizeVolume(
    final _ResizeVolume action,
    final Emitter<VolumesState> emit,
  ) async {
    if (!_isCurrent(action.origin) ||
        state is! VolumesLoaded ||
        action.event.volume.providerVolume == null) {
      return;
    }
    _resizing = true;
    _publish(emit);
    final OperationResult<ServerMutationResult<void>?> result;
    try {
      result = await _resize(
        action.origin!,
        action.event.volume,
        action.event.newSize,
        (final stage) {
          if (_isCurrent(action.origin)) {
            _showMessage(switch (stage) {
              VolumeResizeStage.started =>
                'storage.extending_volume_started'.tr(),
              VolumeResizeStage.providerWaiting =>
                'storage.extending_volume_provider_waiting'.tr(),
              VolumeResizeStage.serverWaiting =>
                'storage.extending_volume_server_waiting'.tr(),
              VolumeResizeStage.rebooting =>
                'storage.extending_volume_rebooting'.tr(),
            });
          }
        },
      );
    } catch (_) {
      if (_isCurrent(action.origin) && !emit.isDone) {
        _resizing = false;
        _publish(emit);
        _showMessage('server_mutation.outcome_unknown'.tr());
      }
      return;
    }
    if (!_isCurrent(action.origin) || emit.isDone) {
      return;
    }
    _resizing = false;
    _publish(emit);
    if (result.value case final receipt?) {
      if (receipt.outcome != ServerMutationOutcome.confirmed) {
        _showMessage(serverMutationMessage(receipt));
      }
    } else {
      _showMessage(
        result.status == OperationStatus.failed
            ? 'storage.extending_volume_error'.tr()
            : result.status.translationKey.tr(),
      );
    }
  }

  @override
  Future<void> close() async {
    _latest = null;
    _presentedOrigin = null;
    await _subscription.cancel();
    await _providerSubscription.cancel();
    return super.close();
  }
}
