import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/server_connection_dependent/server_connection_dependent_cubit.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';

part 'provider_volume_state.dart';

class ApiProviderVolumeCubit
    extends ServerConnectionDependentCubit<ApiProviderVolumeState> {
  ApiProviderVolumeCubit() : super(const ApiProviderVolumeState.initial());
  final ServerApi serverApi = ServerApi();

  @override
  Future<void> load() async {
    unawaited(_refetch());
  }

  Future<Price?> getPricePerGb() async {
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

  Future<void> refresh() async {
    emit(const ApiProviderVolumeState([], LoadingStatus.refreshing, false));
    unawaited(_refetch());
  }

  Future<void> _refetch() async {
    if (ProvidersController.currentServerProvider == null) {
      return emit(const ApiProviderVolumeState([], LoadingStatus.error, false));
    }

    final volumesResult =
        await ProvidersController.currentServerProvider!.getVolumes();

    if (!volumesResult.success || volumesResult.data.isEmpty) {
      return emit(const ApiProviderVolumeState([], LoadingStatus.error, false));
    }

    emit(
      ApiProviderVolumeState(
        volumesResult.data,
        LoadingStatus.success,
        false,
      ),
    );
  }

  Future<void> attachVolume(final DiskVolume volume) async {
    final ServerHostingDetails server = getIt<ApiConfigModel>().serverDetails!;
    await ProvidersController.currentServerProvider!
        .attachVolume(volume.providerVolume!, server.id);
    unawaited(refresh());
  }

  Future<void> detachVolume(final DiskVolume volume) async {
    await ProvidersController.currentServerProvider!
        .detachVolume(volume.providerVolume!);
    unawaited(refresh());
  }

  Future<bool> resizeVolume(
    final DiskVolume volume,
    final DiskSize newSize,
    final Function() callback,
  ) async {
    getIt<NavigationService>().showSnackBar(
      'Starting resize',
    );
    emit(state.copyWith(isResizing: true));
    final resizedResult =
        await ProvidersController.currentServerProvider!.resizeVolume(
      volume.providerVolume!,
      newSize,
    );

    if (!resizedResult.success || !resizedResult.data) {
      getIt<NavigationService>().showSnackBar(
        'storage.extending_volume_error'.tr(),
      );
      emit(state.copyWith(isResizing: false));
      return false;
    }

    getIt<NavigationService>().showSnackBar(
      'Provider volume resized, waiting 10 seconds',
    );
    await Future.delayed(const Duration(seconds: 10));

    await ServerApi().resizeVolume(volume.name);
    getIt<NavigationService>().showSnackBar(
      'Server volume resized, waiting 20 seconds',
    );

    await Future.delayed(const Duration(seconds: 20));
    getIt<NavigationService>().showSnackBar(
      'Restarting server',
    );

    await refresh();
    emit(state.copyWith(isResizing: false));
    await callback();
    await serverApi.reboot();
    return true;
  }

  Future<void> createVolume(final DiskSize size) async {
    final ServerProviderVolume? volume = (await ProvidersController
            .currentServerProvider!
            .createVolume(size.gibibyte.toInt()))
        .data;

    final diskVolume = DiskVolume(providerVolume: volume);
    await attachVolume(diskVolume);

    await Future.delayed(const Duration(seconds: 10));

    await ServerApi().mountVolume(volume!.name);
    unawaited(refresh());
  }

  Future<void> deleteVolume(final DiskVolume volume) async {
    await ProvidersController.currentServerProvider!
        .deleteVolume(volume.providerVolume!);
    unawaited(refresh());
  }

  @override
  void clear() {
    emit(const ApiProviderVolumeState.initial());
  }
}
