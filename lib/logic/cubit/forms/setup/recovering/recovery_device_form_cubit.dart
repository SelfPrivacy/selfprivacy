import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';

class RecoveryDeviceFormCubit extends FormCubit {
  RecoveryDeviceFormCubit(this.installationCubit,
      final FieldCubitFactory fieldFactory, this.recoveryMethod) {
    tokenField = fieldFactory.createRequiredStringField();

    super.addFields([tokenField]);
  }

  @override
  FutureOr<void> onSubmit() async {
    installationCubit.tryToRecover(tokenField.state.value, recoveryMethod);
  }

  final ServerInstallationCubit installationCubit;
  late final FieldCubit<String> tokenField;
  final ServerRecoveryMethods recoveryMethod;
}
