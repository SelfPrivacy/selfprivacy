import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_factory_creator.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';

part 'provider_volume_state.dart';

class ApiProviderVolumeCubit
    extends ServerInstallationDependendCubit<ApiProviderVolumeState> {
  ApiProviderVolumeCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, const ApiProviderVolumeState.initial());

  VolumeProviderApiFactory? providerApi;

  final ServerApi serverApi = ServerApi();

  @override
  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final serverDetails = getIt<ApiConfigModel>().serverDetails;
      providerApi = serverDetails == null
          ? null
          : VolumeApiFactoryCreator.createVolumeProviderApiFactory(
              getIt<ApiConfigModel>().serverDetails!.provider,
            );
      _refetch();
    }
  }

  Future<double?> getPricePerGb() async =>
      providerApi!.getVolumeProvider().getPricePerGb();

  Future<void> refresh() async {
    emit(const ApiProviderVolumeState([], LoadingStatus.refreshing, false));
    _refetch();
  }

  Future<void> _refetch() async {
    if (providerApi == null) {
      return emit(const ApiProviderVolumeState([], LoadingStatus.error, false));
    }

    final List<ServerVolume> volumes =
        await providerApi!.getVolumeProvider().getVolumes();

    if (volumes.isEmpty) {
      return emit(const ApiProviderVolumeState([], LoadingStatus.error, false));
    }

    emit(ApiProviderVolumeState(volumes, LoadingStatus.success, false));
  }

  Future<void> attachVolume(final DiskVolume volume) async {
    final ServerHostingDetails server = getIt<ApiConfigModel>().serverDetails!;
    await providerApi!
        .getVolumeProvider()
        .attachVolume(volume.providerVolume!.id, server.id);
    refresh();
  }

  Future<void> detachVolume(final DiskVolume volume) async {
    await providerApi!
        .getVolumeProvider()
        .detachVolume(volume.providerVolume!.id);
    refresh();
  }

  Future<bool> resizeVolume(
    final DiskVolume volume,
    final int newSizeGb,
    final Function() callback,
  ) async {
    getIt<NavigationService>().showSnackBar(
      'Starting resize',
    );
    emit(state.copyWith(isResizing: true));
    final bool resized = await providerApi!.getVolumeProvider().resizeVolume(
          volume.providerVolume!.id,
          newSizeGb,
        );

    if (!resized) {
      getIt<NavigationService>().showSnackBar(
        'storage.extending_volume_error'.tr(),
      );
      emit(state.copyWith(isResizing: false));
      return false;
    }

    getIt<NavigationService>().showSnackBar(
      'Hetzner resized, waiting 10 seconds',
    );
    await Future.delayed(const Duration(seconds: 10));

    await ServerApi().resizeVolume(volume.name);
    getIt<NavigationService>().showSnackBar(
      'Server api resized, waiting 20 seconds',
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
    final ServerVolume? volume =
        await providerApi!.getVolumeProvider().createVolume();

    final diskVolume = DiskVolume(providerVolume: volume);
    await attachVolume(diskVolume);

    await Future.delayed(const Duration(seconds: 10));

    await ServerApi().mountVolume(volume!.name);
    refresh();
  }

  Future<void> deleteVolume(final DiskVolume volume) async {
    await providerApi!
        .getVolumeProvider()
        .deleteVolume(volume.providerVolume!.id);
    refresh();
  }

  @override
  void clear() {
    emit(const ApiProviderVolumeState.initial());
  }
}
