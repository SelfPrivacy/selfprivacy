import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/provider_volumes/provider_volume_cubit.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';

part 'server_volume_state.dart';

class ApiServerVolumeCubit
    extends ServerInstallationDependendCubit<ApiServerVolumeState> {
  ApiServerVolumeCubit(
    final ServerInstallationCubit serverInstallationCubit,
    this.providerVolumeCubit,
  ) : super(serverInstallationCubit, ApiServerVolumeState.initial()) {
    _providerVolumeSubscription =
        providerVolumeCubit.stream.listen(checkProviderVolumes);
  }

  final ServerApi serverApi = ServerApi();

  @override
  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      _refetch();
    }
  }

  late StreamSubscription<ApiProviderVolumeState> _providerVolumeSubscription;
  final ApiProviderVolumeCubit providerVolumeCubit;

  void checkProviderVolumes(final ApiProviderVolumeState state) {
    emit(
      ApiServerVolumeState(
        this.state._volumes,
        this.state.status,
        this.state.usesBinds,
        DiskStatus.fromVolumes(this.state._volumes, state.volumes),
      ),
    );
    return;
  }

  Future<void> _refetch() async {
    final volumes = await serverApi.getServerDiskVolumes();
    final usesBinds = await serverApi.isUsingBinds();
    var status = LoadingStatus.error;

    if (volumes.isNotEmpty) {
      status = LoadingStatus.success;
    }

    emit(
      ApiServerVolumeState(
        volumes,
        status,
        usesBinds,
        DiskStatus.fromVolumes(
          volumes,
          providerVolumeCubit.state.volumes,
        ),
      ),
    );
  }

  @override
  void clear() {
    emit(ApiServerVolumeState.initial());
  }

  @override
  Future<void> close() {
    _providerVolumeSubscription.cancel();
    return super.close();
  }
}
