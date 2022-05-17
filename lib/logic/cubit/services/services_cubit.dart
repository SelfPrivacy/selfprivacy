import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';

part 'services_state.dart';

class ServicesCubit extends ServerInstallationDependendCubit<ServicesState> {
  ServicesCubit(ServerInstallationCubit appConfigCubit)
      : super(appConfigCubit, ServicesState.allOff());

  Box box = Hive.box(BNames.servicesState);
  final api = ServerApi();
  Future<void> load() async {
    if (appConfigCubit.state is ServerInstallationFinished) {
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
    box.clear();
    emit(ServicesState.allOff());
  }
}
