import 'package:selfprivacy/logic/api_maps/rest_maps/server.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';

part 'services_state.dart';

class ServicesCubit extends ServerInstallationDependendCubit<ServicesState> {
  ServicesCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, ServicesState.allOff());
  final ServerApi api = ServerApi();
  @override
  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final Map<ServiceTypes, bool> statuses = await api.servicesPowerCheck();
      emit(
        ServicesState(
          isPasswordManagerEnable: statuses[ServiceTypes.passwordManager]!,
          isCloudEnable: statuses[ServiceTypes.cloud]!,
          isGitEnable: statuses[ServiceTypes.git]!,
          isSocialNetworkEnable: statuses[ServiceTypes.socialNetwork]!,
          isVpnEnable: statuses[ServiceTypes.vpn]!,
        ),
      );
    }
  }

  @override
  void clear() async {
    emit(ServicesState.allOff());
  }
}
