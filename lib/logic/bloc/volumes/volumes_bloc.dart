import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/logic/operations/volumes/resize_volume_operation.dart';
import 'package:selfprivacy/utils/server_mutation_feedback.dart';

part 'volumes_event.dart';
part 'volumes_state.dart';

typedef ResizeVolume =
    Future<OperationResult<ServerMutationResult<void>?>> Function(
      DiskVolume volume,
      DiskSize size,
      void Function(VolumeResizeStage) onProgress,
    );

class VolumesBloc extends Bloc<VolumesEvent, VolumesState> {
  VolumesBloc({
    required final Stream<CachedValue<List<ServerDiskVolume>>?> volumes,
    required final Stream<void> providerChanges,
    required final Future<List<ServerProviderVolume>> Function()
    loadProviderVolumes,
    required final Future<Price?> Function(String?) loadPrice,
    required final ResizeVolume resize,
    required final void Function(String) showMessage,
  }) : _loadProviderVolumes = loadProviderVolumes,
       _loadPrice = loadPrice,
       _resize = resize,
       _showMessage = showMessage,
       super(VolumesInitial()) {
    on<_VolumesObserved>(_observe, transformer: sequential());
    on<_LoadProviderVolumes>(_loadProvider, transformer: restartable());
    on<VolumeResize>(_resizeVolume, transformer: droppable());
    _subscription = volumes.listen((final observation) {
      _latest = observation;
      add(_VolumesObserved(observation));
    });
    _providerSubscription = providerChanges.listen((_) {
      if (_isActive) {
        add(const _LoadProviderVolumes());
      }
    });
  }

  final Future<List<ServerProviderVolume>> Function() _loadProviderVolumes;
  final Future<Price?> Function(String?) _loadPrice;
  final ResizeVolume _resize;
  final void Function(String) _showMessage;
  late final StreamSubscription<CachedValue<List<ServerDiskVolume>>?>
  _subscription;
  late final StreamSubscription<void> _providerSubscription;
  CachedValue<List<ServerDiskVolume>>? _latest;
  bool _resizing = false;
  bool _providerRequested = false;

  bool get _isActive => !isClosed && _latest != null;

  void _observe(
    final _VolumesObserved event,
    final Emitter<VolumesState> emit,
  ) {
    if (event.observation == null) {
      _resizing = false;
      emit(VolumesInitial());
      return;
    }
    _publish(emit);
    if (!_providerRequested &&
        !event.observation!.isRefreshing &&
        event.observation!.lastError == null) {
      _providerRequested = true;
      add(const _LoadProviderVolumes());
    }
  }

  void _publish(
    final Emitter<VolumesState> emit, [
    final List<ServerProviderVolume>? providers,
  ]) {
    final providerVolumes = providers ?? state.providerVolumes;
    final volumes = _latest?.data;
    if (volumes == null) {
      final snapshot = _latest;
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
    if (!_isActive) {
      return;
    }
    _providerRequested = true;
    try {
      final providers = await _loadProviderVolumes();
      if (!emit.isDone && _isActive) {
        _publish(emit, providers);
      }
    } on Exception {
      if (!emit.isDone && _isActive) {
        _providerRequested = false;
      }
    }
  }

  Future<Price?> getPricePerGb() async {
    if (!_isActive) {
      return null;
    }
    try {
      final price = await _loadPrice(state.location);
      return _isActive ? price : null;
    } on Exception {
      if (_isActive) {
        _showMessage('server.pricing_error'.tr());
      }
      return null;
    }
  }

  Future<void> _resizeVolume(
    final VolumeResize action,
    final Emitter<VolumesState> emit,
  ) async {
    if (!_isActive ||
        state is! VolumesLoaded ||
        action.volume.providerVolume == null) {
      return;
    }
    _resizing = true;
    _publish(emit);
    final OperationResult<ServerMutationResult<void>?> result;
    try {
      result = await _resize(action.volume, action.newSize, (final stage) {
        if (_isActive) {
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
      });
    } catch (_) {
      if (_isActive && !emit.isDone) {
        _resizing = false;
        _publish(emit);
        _showMessage('server_mutation.outcome_unknown'.tr());
      }
      return;
    }
    if (!_isActive || emit.isDone) {
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
    await _subscription.cancel();
    await _providerSubscription.cancel();
    return super.close();
  }
}
