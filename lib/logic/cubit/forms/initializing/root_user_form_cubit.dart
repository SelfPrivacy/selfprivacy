import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:easy_localization/easy_localization.dart';

class RootUserFormCubit extends FormCubit {
  RootUserFormCubit(this.initializingCubit) {
    var userRegExp = RegExp(r"\W");
    var passwordRegExp = RegExp(r"[\n\r\s]+");

    userName = FieldCubit(
      initalValue: '',
      validations: [
        ValidationModel<String>(
            (s) => s.toLowerCase() == 'root', 'validations.root_name'.tr()),
        RequiredStringValidation('validations.required'.tr()),
        ValidationModel<String>(
            (s) => userRegExp.hasMatch(s), 'validations.invalid_format'.tr()),
      ],
    );

    password = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('validations.required'.tr()),
        ValidationModel<String>(
            (s) => passwordRegExp.hasMatch(s), 'validations.invalid_format'.tr()),
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

  late final FieldCubit<String> userName;
  late final FieldCubit<String> password;
  late final FieldCubit<bool> isVisible;
}
