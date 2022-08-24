import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_factory_creator.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/ui/pages/server_storage/disk_status.dart';

part 'provider_volume_state.dart';

class ApiProviderVolumeCubit
    extends ServerInstallationDependendCubit<ApiProviderVolumeState> {
  ApiProviderVolumeCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, const ApiProviderVolumeState.initial()) {
    final serverDetails = getIt<ApiConfigModel>().serverDetails;
    providerApi = serverDetails == null
        ? null
        : VolumeApiFactoryCreator.createVolumeProviderApiFactory(
            getIt<ApiConfigModel>().serverDetails!.provider,
          );
  }

  VolumeProviderApiFactory? providerApi;

  @override
  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
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

  Future<void> attachVolume(final ServerVolume volume) async {
    final ServerHostingDetails server = getIt<ApiConfigModel>().serverDetails!;
    await providerApi!.getVolumeProvider().attachVolume(volume.id, server.id);
    refresh();
  }

  Future<void> detachVolume(final ServerVolume volume) async {
    await providerApi!.getVolumeProvider().detachVolume(volume.id);
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
      return false;
    }

    await ServerApi().resizeVolume(volume.name);
    refresh();
    return true;
  }

  Future<void> createVolume() async {
    final ServerVolume? volume =
        await providerApi!.getVolumeProvider().createVolume();
    await attachVolume(volume!);

    await Future.delayed(const Duration(seconds: 10));

    await ServerApi().mountVolume(volume.name);
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
