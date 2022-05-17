import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';

part 'services_state.dart';

class ServicesCubit extends ServerInstallationDependendCubit<ServicesState> {
  ServicesCubit(ServerInstallationCubit serverInstallationCubit)
      : super(serverInstallationCubit, ServicesState.allOff());
  final api = ServerApi();
  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      var statuses = await api.servicesPowerCheck();
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
