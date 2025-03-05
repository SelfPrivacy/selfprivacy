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

    super.addFields([login]);
  }

  @override
  FutureOr<void> onSubmit() async {
    if (!userCreated) {
      final User user = User(
        login: login.state.value,
        type: UserType.normal,
      );
      final (result, message) =
          await getIt<ApiConnectionRepository>().createUser(user);

      if (result) {
        initialUser = user;
        userCreated = true;
        userCreationMessage = message;
        errorMessage = '';
      } else {
        errorMessage = message;
        getIt<NavigationService>().showSnackBar(errorMessage);
      }
    } else {
      /// We got request to reset password
      final User user = User(
        login: initialUser?.login ?? login.state.value,
        type: initialUser?.type ?? UserType.normal,
      );
      final (link, message) = await getIt<ApiConnectionRepository>()
          .generatePasswordResetLink(user);

      if (link != null) {
        passwordResetLink = link;
        passwordResetMessage = message;
      } else {
        passwordResetMessage = message;
        getIt<NavigationService>().showSnackBar(passwordResetMessage);
      }
    }
  }

  late FieldCubit<String> login;
  User? initialUser;

  bool userCreated;
  String? userCreationMessage = '';
  String errorMessage = '';

  Uri? passwordResetLink;
  String passwordResetMessage = '';
}
