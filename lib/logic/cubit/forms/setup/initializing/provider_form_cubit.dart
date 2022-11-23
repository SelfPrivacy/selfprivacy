import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';

class ProviderFormCubit extends FormCubit {
  ProviderFormCubit(this.serverInstallationCubit) {
    //final int tokenLength =
    //    serverInstallationCubit.serverProviderApiTokenValidation().length;
    apiKey = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('validations.required'.tr()),
        //LengthStringNotEqualValidation(tokenLength),
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
    late bool isKeyValid;

    try {
      isKeyValid = await serverInstallationCubit
          .isServerProviderApiTokenValid(apiKey.state.value);
    } catch (e) {
      addError(e);
      isKeyValid = false;
    }

    if (!isKeyValid) {
      apiKey.setError('initializing.provider_bad_key_error'.tr());
      return false;
    }

    return true;
  }
}
