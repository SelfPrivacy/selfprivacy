import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';

part 'volumes_state.dart';

class ApiVolumesCubit
    extends ServerInstallationDependendCubit<ApiVolumesState> {
  ApiVolumesCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, const ApiVolumesState.initial());

  final ServerApi api = ServerApi();

  @override
  void load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      _refetch();
    }
  }

  void refresh() async {
    emit(const ApiVolumesState([], LoadingStatus.refreshing));
    _refetch();
  }

  void _refetch() async {
    final List<ServerVolume> volumes = await HetznerApi().getVolumes();
    if (volumes.isNotEmpty) {
      emit(ApiVolumesState(volumes, LoadingStatus.success));
    } else {
      emit(const ApiVolumesState([], LoadingStatus.error));
    }
  }

  void attachVolume(final ServerVolume volume) async {
    final ServerHostingDetails server = getIt<ApiConfigModel>().serverDetails!;
    HetznerApi().attachVolume(volume.id, server.id);
    refresh();
  }

  void detachVolume(final ServerVolume volume) async {
    HetznerApi().detachVolume(volume.id);
    refresh();
  }

  void resizeVolume(final ServerVolume volume, final int newSizeGb) {
    if (volume.sizeByte < newSizeGb) {
      HetznerApi().resizeVolume(volume.id, newSizeGb);
      refresh();
    }
  }

  void createVolume() async {
    HetznerApi().createVolume();
    refresh();
  }

  void deleteVolume(final ServerVolume volume) async {
    HetznerApi().deleteVolume(volume.id);
    refresh();
  }

  @override
  void clear() {
    emit(const ApiVolumesState.initial());
  }
}
