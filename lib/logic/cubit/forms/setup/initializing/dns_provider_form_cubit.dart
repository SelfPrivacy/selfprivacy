import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/validations/validations.dart';

class DnsProviderFormCubit extends FormCubit {
  DnsProviderFormCubit(this.initializingCubit) {
    apiKey = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('validations.required'.tr()),
        LengthStringNotEqualValidation(40)
      ],
    );

    super.addFields([apiKey]);
  }

  @override
  FutureOr<void> onSubmit() async {
    initializingCubit.setDnsApiToken(apiKey.state.value);
  }

  final ServerInstallationCubit initializingCubit;
  late final FieldCubit<String> apiKey;

  @override
  FutureOr<bool> asyncValidation() async {
    bool? isKeyValid;

    try {
      isKeyValid = await initializingCubit
          .isDnsProviderApiTokenValid(apiKey.state.value);
    } catch (e) {
      addError(e);
    }

    if (isKeyValid == null) {
      apiKey.setError('');
      return false;
    }

    if (!isKeyValid) {
      apiKey.setError('initializing.cloudflare_bad_key_error'.tr());
    }

    return isKeyValid;
  }
}
