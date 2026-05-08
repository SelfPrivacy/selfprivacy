import 'dart:async';

import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:sp_cubit_form/sp_cubit_form.dart';

class RecoveryDeviceFormCubit extends FormCubit {
  RecoveryDeviceFormCubit(
    this.installationCubit,
    final FieldCubitFactory fieldFactory,
    this.recoveryMethod,
  ) {
    tokenField = fieldFactory.createRequiredStringField();

    super.addFields([tokenField]);
  }

  @override
  Future<void>? onSubmit() async {
    late final String token;
    // Trim spaces and make lowercase
    if (recoveryMethod == ServerRecoveryMethods.recoveryKey ||
        recoveryMethod == ServerRecoveryMethods.newDeviceKey) {
      token = tokenField.state.value.trim().toLowerCase();
    } else {
      token = tokenField.state.value.trim();
    }

    await installationCubit.tryToRecover(token, recoveryMethod);
  }

  final ServerInstallationCubit installationCubit;
  late final FieldCubit<String> tokenField;
  final ServerRecoveryMethods recoveryMethod;
}
