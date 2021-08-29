import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesState.allOff());

  Box box = Hive.box(BNames.servicesState);

  void load() {
    emit(
      ServicesState(
        isPasswordManagerEnable:
            box.get(ServiceTypes.passwordManager.txt, defaultValue: false),
        isCloudEnable: box.get(ServiceTypes.cloud.txt, defaultValue: false),
        isGitEnable: box.get(ServiceTypes.git.txt, defaultValue: false),
        isSocialNetworkEnable:
            box.get(ServiceTypes.socialNetwork.txt, defaultValue: false),
        isVpnEnable: box.get(ServiceTypes.vpn.txt, defaultValue: false),
      ),
    );
  }

  void allOn() {
    box.put(ServiceTypes.passwordManager.txt, true);
    box.put(ServiceTypes.cloud.txt, true);
    box.put(ServiceTypes.git.txt, true);
    box.put(ServiceTypes.socialNetwork.txt, true);
    box.put(ServiceTypes.vpn.txt, true);

    emit(ServicesState.allOn());
  }

  void allOff() {
    box.put(ServiceTypes.passwordManager.txt, false);
    box.put(ServiceTypes.cloud.txt, false);
    box.put(ServiceTypes.git.txt, false);
    box.put(ServiceTypes.socialNetwork.txt, false);
    box.put(ServiceTypes.vpn.txt, false);

    emit(ServicesState.allOff());
  }

  void turnOffList(List<ServiceTypes> list) {
    for (final service in list) {
      box.put(service.txt, false);
    }

    emit(state.disableList(list));
  }

  void turnOnist(List<ServiceTypes> list) {
    for (final service in list) {
      box.put(service.txt, true);
    }

    emit(state.enableList(list));
  }
}
