import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';
import 'package:selfprivacy/logic/models/user.dart';

class CloudFlareFormCubit extends FormCubit {
  CloudFlareFormCubit({
    this.userCubit,
    User user,
  }) {
    var isEdit = user != null;

    var userRegExp = RegExp(r"\W");
    var passwordRegExp = RegExp(r"[\n\r\s]+");

    login = FieldCubit(
      initalValue: isEdit ? user.login : '',
      validations: [
        RequiredStringValidation('required'),
        ValidationModel<String>(
            (s) => userRegExp.hasMatch(s), 'invalid format'),
      ],
    );

    password = FieldCubit(
      initalValue: isEdit ? user.password : '',
      validations: [
        RequiredStringValidation('required'),
        ValidationModel<String>(
            (s) => passwordRegExp.hasMatch(s), 'invalid format'),
      ],
    );

    super.setFields([login, password]);
  }

  @override
  FutureOr<void> onSubmit() {
    var user = User(
      login: login.state.value,
      password: password.state.value,
    );
    userCubit.add(user);
  }

  FieldCubit<String> login;
  FieldCubit<String> password;

  UsersCubit userCubit;
}
