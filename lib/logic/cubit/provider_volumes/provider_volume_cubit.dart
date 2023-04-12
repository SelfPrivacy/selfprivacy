import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_controller.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/price.dart';

part 'provider_volume_state.dart';

class ApiProviderVolumeCubit
    extends ServerInstallationDependendCubit<ApiProviderVolumeState> {
  ApiProviderVolumeCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, const ApiProviderVolumeState.initial());
  final ServerApi serverApi = ServerApi();

  @override
  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      unawaited(_refetch());
    }
  }

  Future<Price?> getPricePerGb() async =>
      ApiController.currentVolumeProviderApiFactory!
          .getVolumeProvider()
          .getPricePerGb();

  Future<void> refresh() async {
    emit(const ApiProviderVolumeState([], LoadingStatus.refreshing, false));
    unawaited(_refetch());
  }

  Future<void> _refetch() async {
    if (ApiController.currentVolumeProviderApiFactory == null) {
      return emit(const ApiProviderVolumeState([], LoadingStatus.error, false));
    }

    final List<ServerVolume> volumes = await ApiController
        .currentVolumeProviderApiFactory!
        .getVolumeProvider()
        .getVolumes();

    if (volumes.isEmpty) {
      return emit(const ApiProviderVolumeState([], LoadingStatus.error, false));
    }

    emit(ApiProviderVolumeState(volumes, LoadingStatus.success, false));
  }

  Future<void> attachVolume(final DiskVolume volume) async {
    final ServerHostingDetails server = getIt<ApiConfigModel>().serverDetails!;
    await ApiController.currentVolumeProviderApiFactory!
        .getVolumeProvider()
        .attachVolume(volume.providerVolume!, server.id);
    unawaited(refresh());
  }

  Future<void> detachVolume(final DiskVolume volume) async {
    await ApiController.currentVolumeProviderApiFactory!
        .getVolumeProvider()
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
    final bool resized = await ApiController.currentVolumeProviderApiFactory!
        .getVolumeProvider()
        .resizeVolume(
          volume.providerVolume!,
          newSize,
        );

    if (!resized) {
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

  Future<void> createVolume() async {
    final ServerVolume? volume = (await ApiController
            .currentVolumeProviderApiFactory!
            .getVolumeProvider()
            .createVolume())
        .data;

    final diskVolume = DiskVolume(providerVolume: volume);
    await attachVolume(diskVolume);

    await Future.delayed(const Duration(seconds: 10));

    await ServerApi().mountVolume(volume!.name);
    unawaited(refresh());
  }

  Future<void> deleteVolume(final DiskVolume volume) async {
    await ApiController.currentVolumeProviderApiFactory!
        .getVolumeProvider()
        .deleteVolume(volume.providerVolume!);
    unawaited(refresh());
  }

  @override
  void clear() {
    emit(const ApiProviderVolumeState.initial());
  }
}
