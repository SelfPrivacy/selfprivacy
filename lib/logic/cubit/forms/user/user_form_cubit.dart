import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class UserFormCubit extends FormCubit {
  UserFormCubit({
    required this.jobsCubit,
    required List<User> users,
    User? user,
  }) {
    var isEdit = user != null;

    var userRegExp = RegExp(r"\W");
    var passwordRegExp = RegExp(r"[\n\r\s]+");

    login = FieldCubit(
      initalValue: isEdit ? user!.login : '',
      validations: [
        ValidationModel<String>(
            (s) => s.toLowerCase() == 'root', 'validations.root_name'.tr()),
        ValidationModel(
          (login) => users.any((user) => user.login == login),
          'validations.user_already_exist'.tr(),
        ),
        RequiredStringValidation('validations.required'.tr()),
        ValidationModel<String>(
            (s) => userRegExp.hasMatch(s), 'validations.invalid_format'.tr()),
      ],
    );

    password = FieldCubit(
      initalValue: isEdit ? user!.password : StringGenerators.userPassword(),
      validations: [
        RequiredStringValidation('validations.required'.tr()),
        ValidationModel<String>((s) => passwordRegExp.hasMatch(s),
            'validations.invalid_format'.tr()),
      ],
    );

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
