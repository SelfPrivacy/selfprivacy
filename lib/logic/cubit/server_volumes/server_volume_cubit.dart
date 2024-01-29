import 'dart:async';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/server_connection_dependent/server_connection_dependent_cubit.dart';
import 'package:selfprivacy/logic/cubit/provider_volumes/provider_volume_cubit.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';

part 'server_volume_state.dart';

class ApiServerVolumeCubit
    extends ServerConnectionDependentCubit<ApiServerVolumeState> {
  ApiServerVolumeCubit(
    final ServerInstallationCubit serverInstallationCubit,
    this.providerVolumeCubit,
  ) : super(ApiServerVolumeState.initial()) {
    // TODO: Remove this connection between cubits
    _providerVolumeSubscription =
        providerVolumeCubit.stream.listen(checkProviderVolumes);
  }

  final ServerApi serverApi = ServerApi();

  @override
  Future<void> load() async {
    unawaited(reload());
  }

  late StreamSubscription<ApiProviderVolumeState> _providerVolumeSubscription;
  final ApiProviderVolumeCubit providerVolumeCubit;

  void checkProviderVolumes(final ApiProviderVolumeState state) {
    emit(
      ApiServerVolumeState(
        this.state._volumes,
        this.state.status,
        DiskStatus.fromVolumes(this.state._volumes, state.volumes),
      ),
    );
    return;
  }

  Future<void> reload() async {
    final volumes = await serverApi.getServerDiskVolumes();
    var status = LoadingStatus.error;

    if (volumes.isNotEmpty) {
      status = LoadingStatus.success;
    }

    emit(
      ApiServerVolumeState(
        volumes,
        status,
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
