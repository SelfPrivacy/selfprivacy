import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';

part 'volumes_event.dart';
part 'volumes_state.dart';

class VolumesBloc extends Bloc<VolumesEvent, VolumesState> {
  VolumesBloc() : super(VolumesInitial()) {
    on<VolumesServerLoaded>(
      _loadState,
      transformer: droppable(),
    );
    on<VolumesServerReset>(
      _resetState,
      transformer: droppable(),
    );
    on<VolumesServerStateChanged>(
      _updateState,
      transformer: droppable(),
    );
    on<VolumeResize>(
      _resizeVolume,
      transformer: droppable(),
    );

    final connectionRepository = getIt<ApiConnectionRepository>();

    _apiStatusSubscription = connectionRepository.connectionStatusStream
        .listen((final ConnectionStatus connectionStatus) {
      switch (connectionStatus) {
        case ConnectionStatus.nonexistent:
          add(const VolumesServerReset());
          isLoaded = false;
          break;
        case ConnectionStatus.connected:
          if (!isLoaded) {
            add(const VolumesServerLoaded());
            isLoaded = true;
          }
          break;
        default:
          break;
      }
    });

    _apiDataSubscription = connectionRepository.dataStream.listen(
      (final ApiData apiData) {
        if (apiData.volumes.data == null) {
          add(const VolumesServerReset());
        } else {
          add(
            VolumesServerStateChanged(
              apiData.volumes.data!,
            ),
          );
        }
      },
    );
  }

  late StreamSubscription _apiStatusSubscription;
  late StreamSubscription _apiDataSubscription;
  bool isLoaded = false;

  Future<Price?> getPricePerGb() async {
    if (ProvidersController.currentServerProvider == null) {
      return null;
    }
    Price? price;
    final pricingResult =
        await ProvidersController.currentServerProvider!.getAdditionalPricing();
    if (pricingResult.data == null || !pricingResult.success) {
      getIt<NavigationService>().showSnackBar('server.pricing_error'.tr());
      return price;
    }
    price = pricingResult.data!.perVolumeGb;
    return price;
  }

  Future<void> _loadState(
    final VolumesServerLoaded event,
    final Emitter<VolumesState> emit,
  ) async {
    if (ProvidersController.currentServerProvider == null) {
      return;
    }

    emit(VolumesLoading());

    final volumesResult =
        await ProvidersController.currentServerProvider!.getVolumes();

    if (!volumesResult.success || volumesResult.data.isEmpty) {
      emit(VolumesInitial());
      return;
    }

    final serverVolumes = getIt<ApiConnectionRepository>().apiData.volumes.data;

    if (serverVolumes == null) {
      emit(VolumesLoading(providerVolumes: volumesResult.data));
      return;
    } else {
      emit(
        VolumesLoaded(
          diskStatus: DiskStatus.fromVolumes(
            serverVolumes,
            volumesResult.data,
          ),
          providerVolumes: volumesResult.data,
          serverVolumesHashCode: Object.hashAll(serverVolumes),
        ),
      );
    }
  }

  Future<void> _resetState(
    final VolumesServerReset event,
    final Emitter<VolumesState> emit,
  ) async {
    emit(VolumesInitial());
  }

  @override
  void onChange(final Change<VolumesState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    await _apiStatusSubscription.cancel();
    await _apiDataSubscription.cancel();
    await super.close();
  }

  Future<void> invalidateCache() async {
    getIt<ApiConnectionRepository>().apiData.volumes.invalidate();
  }

  Future<void> _updateState(
    final VolumesServerStateChanged event,
    final Emitter<VolumesState> emit,
  ) async {
    final serverVolumes = event.volumes;
    final providerVolumes = state.providerVolumes;
    if (state is VolumesLoading) {
      emit(
        VolumesLoaded(
          diskStatus: DiskStatus.fromVolumes(
            serverVolumes,
            providerVolumes,
          ),
          providerVolumes: providerVolumes,
          serverVolumesHashCode: Object.hashAll(serverVolumes),
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        diskStatus: DiskStatus.fromVolumes(
          serverVolumes,
          providerVolumes,
        ),
        providerVolumes: providerVolumes,
        serverVolumesHashCode: Object.hashAll(serverVolumes),
      ),
    );
  }

  Future<void> _resizeVolume(
    final VolumeResize event,
    final Emitter<VolumesState> emit,
  ) async {
    if (state is! VolumesLoaded) {
      return;
    }
    getIt<NavigationService>().showSnackBar(
      'storage.extending_volume_started'.tr(),
    );
    emit(
      VolumesResizing(
        serverVolumesHashCode: state._serverVolumesHashCode,
        diskStatus: state.diskStatus,
        providerVolumes: state.providerVolumes,
      ),
    );

    final resizedResult =
        await ProvidersController.currentServerProvider!.resizeVolume(
      event.volume.providerVolume!,
      event.newSize,
    );

    if (!resizedResult.success || !resizedResult.data) {
      getIt<NavigationService>().showSnackBar(
        'storage.extending_volume_error'.tr(),
      );
      emit(
        VolumesLoaded(
          serverVolumesHashCode: state._serverVolumesHashCode,
          diskStatus: state.diskStatus,
          providerVolumes: state.providerVolumes,
        ),
      );
      return;
    }

    getIt<NavigationService>().showSnackBar(
      'storage.extending_volume_waiting'.tr(),
    );

    await Future.delayed(const Duration(seconds: 10));

    await getIt<ApiConnectionRepository>().api.resizeVolume(event.volume.name);
    getIt<NavigationService>().showSnackBar(
      'storage.extending_volume_server_waiting'.tr(),
    );

    await Future.delayed(const Duration(seconds: 20));
    getIt<NavigationService>().showSnackBar(
      'storage.extending_volume_rebooting'.tr(),
    );

    emit(
      VolumesLoaded(
        serverVolumesHashCode: state._serverVolumesHashCode,
        diskStatus: state.diskStatus,
        providerVolumes: state.providerVolumes,
      ),
    );

    await getIt<ApiConnectionRepository>().api.reboot();
  }
}
