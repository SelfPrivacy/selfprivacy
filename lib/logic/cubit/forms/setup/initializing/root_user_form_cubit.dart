import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

class RootUserFormCubit extends FormCubit {
  RootUserFormCubit(
    this.serverInstallationCubit,
    final FieldCubitFactory fieldFactory,
  ) {
    userName = fieldFactory.createUserLoginField();
    password = fieldFactory.createUserPasswordField();

    isVisible = FieldCubit(initalValue: false);

    super.addFields([userName, password, isVisible]);
  }

  @override
  Future<void>? onSubmit() async {
    final User user = User(
      login: userName.state.value,
      type: UserType.primary,
      password: password.state.value,
    );
    await serverInstallationCubit.setRootUser(user);
  }

  final ServerInstallationCubit serverInstallationCubit;

  late final FieldCubit<String> userName;
  late final FieldCubit<String> password;
  late final FieldCubit<bool> isVisible;
}
