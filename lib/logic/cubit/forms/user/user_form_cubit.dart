import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

class UserFormCubit extends FormCubit {
  UserFormCubit({
    required final FieldCubitFactory fieldFactory,
    required this.initialUser,
  }) : userCreated = initialUser != null {
    login = initialUser == null
        ? fieldFactory.createUserLoginField()
        : fieldFactory.createRequiredStringField();
    login.setValue(initialUser?.login ?? '');

    displayName = fieldFactory.createUserDisplayNameField();
    displayName.setValue(initialUser?.displayName ?? '');

    super.addFields([login, displayName]);
  }

  @override
  FutureOr<void> onSubmit() async {
    if (!userCreated) {
      final User user = User(
        login: login.state.value,
        type: UserType.normal,
        displayName:
            displayName.state.value == '' ? null : displayName.state.value,
      );
      final (result, message) =
          await getIt<ApiConnectionRepository>().createUser(user);

      if (result) {
        userCreated = true;
        userCreationMessage = message;
        errorMessage = '';
      } else {
        errorMessage = message;
      }
    }
  }

  late FieldCubit<String> login;
  late FieldCubit<String> displayName;

  bool userCreated;
  String? userCreationMessage = '';
  String errorMessage = '';
  final User? initialUser;
}
