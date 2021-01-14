import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class UserFormCubit extends FormCubit {
  UserFormCubit({
    this.usersCubit,
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
      initalValue: isEdit ? user.password : genPass(),
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
    usersCubit.add(user);
  }

  FieldCubit<String> login;
  FieldCubit<String> password;

  void genNewPassword() {
    password.externalSetValue(genPass());
  }

  UsersCubit usersCubit;
}
