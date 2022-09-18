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
    emit(const ApiProviderVolumeState([], LoadingStatus.refreshing));
    _refetch();
  }

  Future<void> _refetch() async {
    if (providerApi == null) {
      return emit(const ApiProviderVolumeState([], LoadingStatus.error));
    }

    final List<ServerVolume> volumes =
        await providerApi!.getVolumeProvider().getVolumes();

    if (volumes.isEmpty) {
      return emit(const ApiProviderVolumeState([], LoadingStatus.error));
    }

    emit(ApiProviderVolumeState(volumes, LoadingStatus.success));
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
  ) async {
    final bool resized = await providerApi!.getVolumeProvider().resizeVolume(
          volume.providerVolume!.id,
          newSizeGb,
        );

    if (!resized) {
      getIt<NavigationService>().showSnackBar(
        'providers.storage.extending_volume_error'.tr(),
      );
      return false;
    }

    await ServerApi().resizeVolume(volume.name);
    refresh();
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
