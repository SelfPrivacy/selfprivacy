import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/models/config.dart';
import 'package:selfprivacy/logic/models/user.dart';

part 'initializing_state.dart';

class InitializingCubit extends Cubit<InitializingState> {
  InitializingCubit() : super(InitialInitializingState());

  void setHetznerKey(String key) {
    var newCofig = state.appConfig.copyWith(hatzner: key);
    emit(InitializingState(newCofig));
  }

  void setCloudFlare(String cloudFlareKey) {
    var newCofig = state.appConfig.copyWith(cloudFlare: cloudFlareKey);
    emit(InitializingState(newCofig));
  }

  void setDomain(String domain) {
    var newCofig = state.appConfig.copyWith(domain: domain);
    emit(InitializingState(newCofig));
  }

  void setRootUser(User rootUser) {
    var newCofig = state.appConfig.copyWith(rootUser: rootUser);
    emit(InitializingState(newCofig));
  }
}
