import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class UserFormCubit extends FormCubit {
  UserFormCubit({
    required this.jobsCubit,
    required final FieldCubitFactory fieldFactory,
    this.initialUser,
  }) {
    if (initialUser == null) {
      login = fieldFactory.createUserLoginField();
      login.setValue('');
      password = fieldFactory.createUserPasswordField();
      password.setValue(
        StringGenerators.userPassword(),
      );

      super.addFields([login, password]);
    } else {
      login = fieldFactory.createRequiredStringField();
      login.setValue(initialUser!.login);
      password = fieldFactory.createUserPasswordField();
      password.setValue(
        initialUser?.password ?? '',
      );

      super.addFields([login, password]);
    }
  }

  @override
  FutureOr<void> onSubmit() {
    print('onSubmit');
    print('initialUser: $initialUser');
    print('login: ${login.state.value}');
    print('password: ${password.state.value}');
    if (initialUser == null) {
      final User user = User(
        login: login.state.value,
        type: UserType.normal,
        password: password.state.value,
      );
      jobsCubit.addJob(CreateUserJob(user: user));
    } else {
      final User user = User(
        login: initialUser?.login ?? login.state.value,
        type: initialUser?.type ?? UserType.normal,
        password: password.state.value,
      );
      jobsCubit.addJob(ResetUserPasswordJob(user: user));
    }
  }

  late FieldCubit<String> login;
  late FieldCubit<String> password;

  void genNewPassword() {
    password.externalSetValue(StringGenerators.userPassword());
  }

  final JobsCubit jobsCubit;
  final User? initialUser;
}
