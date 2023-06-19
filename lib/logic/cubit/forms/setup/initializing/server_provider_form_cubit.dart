import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';

class ServerProviderFormCubit extends FormCubit {
  ServerProviderFormCubit(this.serverInstallationCubit) {
    apiKey = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('validations.required'.tr()),
      ],
    );

    super.addFields([apiKey]);
  }

  @override
  FutureOr<void> onSubmit() async {
    serverInstallationCubit.setServerProviderKey(apiKey.state.value);
  }

  final ServerInstallationCubit serverInstallationCubit;
  late final FieldCubit<String> apiKey;

  @override
  FutureOr<bool> asyncValidation() async {
    bool? isKeyValid;

    try {
      isKeyValid = await serverInstallationCubit
          .isServerProviderApiTokenValid(apiKey.state.value);
    } catch (e) {
      addError(e);
    }

    if (isKeyValid == null) {
      apiKey.setError('');
      return false;
    }

    if (!isKeyValid) {
      apiKey.setError('initializing.provider_bad_key_error'.tr());
    }

    return isKeyValid;
  }
}
