import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class UserFormCubit extends FormCubit {
  UserFormCubit({
    required this.jobsCubit,
    required FieldCubitFactory fieldFactory,
    User? user,
  }) {
    var isEdit = user != null;

    login = fieldFactory.createUserLoginField();
    login.setValue(isEdit ? user!.login : '');
    password = fieldFactory.createUserPasswordField();
    password.setValue(
        isEdit ? (user?.password ?? '') : StringGenerators.userPassword());

    super.addFields([login, password]);
  }

  @override
  FutureOr<void> onSubmit() {
    var user = User(
      login: login.state.value,
      password: password.state.value,
    );
    jobsCubit.addJob(CreateUserJob(user: user));
  }

  late FieldCubit<String> login;
  late FieldCubit<String> password;

  void genNewPassword() {
    password.externalSetValue(StringGenerators.userPassword());
  }

  final JobsCubit jobsCubit;
}
