import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/models/user.dart';

class RootUserFormCubit extends FormCubit {
  HetznerApi apiClient = HetznerApi();

  RootUserFormCubit(this.initializingCubit) {
    var userRegExp = RegExp(r"\W");
    var passwordRegExp = RegExp(r"[\n\r\s]+");

    userName = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('required'),
        ValidationModel<String>(
            (s) => userRegExp.hasMatch(s), 'invalid format'),
      ],
    );

    password = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('required'),
        ValidationModel<String>(
            (s) => passwordRegExp.hasMatch(s), 'invalid format'),
      ],
    );

    isVisible = FieldCubit(initalValue: false);

    super.addFields([userName, password, isVisible]);
  }

  @override
  FutureOr<void> onSubmit() async {
    var user = User(
      login: userName.state.value,
      password: password.state.value,
    );
    initializingCubit.setRootUser(user);
  }

  final AppConfigCubit initializingCubit;

  // ignore: close_sinks
  late final FieldCubit<String> userName;
  // ignore: close_sinks
  late final FieldCubit<String> password;
  // ignore: close_sinks
  late final FieldCubit<bool> isVisible;

  @override
  Future<void> close() async {
    apiClient.close();

    return super.close();
  }
}
