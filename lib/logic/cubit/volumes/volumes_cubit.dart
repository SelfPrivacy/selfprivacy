import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_factory_creator.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';

part 'volumes_state.dart';

class ApiVolumesCubit
    extends ServerInstallationDependendCubit<ApiVolumesState> {
  ApiVolumesCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, const ApiVolumesState.initial());

  final VolumeProviderApiFactory providerApi =
      VolumeApiFactoryCreator.createVolumeProviderApiFactory(
    getIt<ApiConfigModel>().serverDetails!.provider,
  );

  @override
  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      _refetch();
    }
  }

  Future<double?> getPricePerGb() async =>
      providerApi.getVolumeProvider().getPricePerGb();

  Future<void> refresh() async {
    emit(const ApiVolumesState([], LoadingStatus.refreshing));
    _refetch();
  }

  Future<void> _refetch() async {
    final List<ServerVolume> volumes =
        await providerApi.getVolumeProvider().getVolumes();
    if (volumes.isNotEmpty) {
      emit(ApiVolumesState(volumes, LoadingStatus.success));
    } else {
      emit(const ApiVolumesState([], LoadingStatus.error));
    }
  }

  Future<void> attachVolume(final ServerVolume volume) async {
    final ServerHostingDetails server = getIt<ApiConfigModel>().serverDetails!;
    await providerApi.getVolumeProvider().attachVolume(volume.id, server.id);
    refresh();
  }

  Future<void> detachVolume(final ServerVolume volume) async {
    await providerApi.getVolumeProvider().detachVolume(volume.id);
    refresh();
  }

  Future<bool> resizeVolume(
    final ServerDiskVolume volume,
    final int newSizeGb,
  ) async {
    final ServerVolume? providerVolume = await fetchProdiverVolume(volume);
    final bool resized = await providerApi.getVolumeProvider().resizeVolume(
          providerVolume!.id,
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
        await providerApi.getVolumeProvider().createVolume();
    await attachVolume(volume!);

    await Future.delayed(const Duration(seconds: 10));

    final ServerDiskVolume? diskVolume = await fetchServerDiskVolume(volume);
    await ServerApi().mountVolume(diskVolume!.name);
    refresh();
  }

  Future<void> deleteVolume(final ServerDiskVolume volume) async {
    final ServerVolume? providerVolume = await fetchProdiverVolume(volume);
    await providerApi.getVolumeProvider().deleteVolume(providerVolume!.id);
    refresh();
  }

  @override
  void clear() {
    emit(const ApiVolumesState.initial());
  }

  Future<ServerVolume?> fetchProdiverVolume(
    final ServerDiskVolume volume,
  ) async {
    ServerVolume? fetchedVolume;
    final List<ServerVolume> volumes =
        await providerApi.getVolumeProvider().getVolumes();

    for (final ServerVolume providerVolume in volumes) {
      if (providerVolume.linuxDevice == null) {
        continue;
      }

      final String deviceId = providerVolume.linuxDevice!.split('/').last;
      if (deviceId.contains(volume.model!) &&
          deviceId.contains(volume.serial!)) {
        fetchedVolume = providerVolume;
        break;
      }
    }

    return fetchedVolume;
  }

  Future<ServerDiskVolume?> fetchServerDiskVolume(
    final ServerVolume volume,
  ) async {
    ServerDiskVolume? fetchedVolume;
    if (volume.linuxDevice == null) {
      return fetchedVolume;
    }

    final List<ServerDiskVolume> volumes =
        await ServerApi().getServerDiskVolumes();

    for (final ServerDiskVolume serverDiskVolumes in volumes) {
      if (serverDiskVolumes.model == null || serverDiskVolumes.serial == null) {
        continue;
      }

      final String deviceId = volume.linuxDevice!.split('/').last;
      if (deviceId.contains(serverDiskVolumes.model!) &&
          deviceId.contains(serverDiskVolumes.serial!)) {
        fetchedVolume = serverDiskVolumes;
        break;
      }
    }

    return fetchedVolume;
  }
}
