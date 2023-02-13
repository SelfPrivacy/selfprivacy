import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';

part 'devices_state.dart';

class ApiDevicesCubit
    extends ServerInstallationDependendCubit<ApiDevicesState> {
  ApiDevicesCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, const ApiDevicesState.initial());

  final ServerApi api = ServerApi();

  @override
  void load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      _refetch();
    }
  }

  Future<void> refresh() async {
    emit(const ApiDevicesState([], LoadingStatus.refreshing));
    _refetch();
  }

  void _refetch() async {
    final List<ApiToken>? devices = await _getApiTokens();
    if (devices != null) {
      emit(ApiDevicesState(devices, LoadingStatus.success));
    } else {
      emit(const ApiDevicesState([], LoadingStatus.error));
    }
  }

  Future<List<ApiToken>?> _getApiTokens() async {
    final GenericResult<List<ApiToken>> response = await api.getApiTokens();
    if (response.success) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<void> deleteDevice(final ApiToken device) async {
    final GenericResult<void> response = await api.deleteApiToken(device.name);
    if (response.success) {
      emit(
        ApiDevicesState(
          state.devices.where((final d) => d.name != device.name).toList(),
          LoadingStatus.success,
        ),
      );
    } else {
      getIt<NavigationService>()
          .showSnackBar(response.message ?? 'Error deleting device');
    }
  }

  Future<String?> getNewDeviceKey() async {
    final GenericResult<String> response = await api.createDeviceToken();
    if (response.success) {
      return response.data;
    } else {
      getIt<NavigationService>().showSnackBar(
        response.message ?? 'Error getting new device key',
      );
      return null;
    }
  }

  @override
  void clear() {
    emit(const ApiDevicesState.initial());
  }
}
