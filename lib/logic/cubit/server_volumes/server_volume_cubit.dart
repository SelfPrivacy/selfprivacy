import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';

part 'server_volume_state.dart';

class ApiServerVolumeCubit
    extends ServerInstallationDependendCubit<ApiServerVolumeState> {
  ApiServerVolumeCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, const ApiServerVolumeState.initial());

  final ServerApi serverApi = ServerApi();

  @override
  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      _refetch();
    }
  }

  Future<void> _refetch() async {
    final List<ServerDiskVolume> volumes =
        await serverApi.getServerDiskVolumes();
    if (volumes.isNotEmpty) {
      emit(ApiServerVolumeState(volumes, LoadingStatus.success));
    } else {
      emit(const ApiServerVolumeState([], LoadingStatus.error));
    }
  }

  @override
  void clear() {
    emit(const ApiServerVolumeState.initial());
  }
}
