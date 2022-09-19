import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/validations/validations.dart';

class DnsProviderFormCubit extends FormCubit {
  DnsProviderFormCubit(this.initializingCubit) {
    final RegExp regExp = initializingCubit.getDnsProviderApiTokenValidation();
    apiKey = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('validations.required'.tr()),
        ValidationModel<String>(
          regExp.hasMatch,
          'validations.key_format'.tr(),
        ),
        LengthStringNotEqualValidation(40)
      ],
    );

    super.addFields([apiKey]);
  }

  @override
  FutureOr<void> onSubmit() async {
    initializingCubit.setCloudflareKey(apiKey.state.value);
  }

  final ServerInstallationCubit initializingCubit;
  late final FieldCubit<String> apiKey;

  @override
  FutureOr<bool> asyncValidation() async {
    late bool isKeyValid;

    try {
      isKeyValid = await initializingCubit
          .isDnsProviderApiTokenValid(apiKey.state.value);
    } catch (e) {
      addError(e);
      isKeyValid = false;
    }

    if (!isKeyValid) {
      apiKey.setError('initializing.cloudflare_bad_key_error'.tr());
      return false;
    }

    return true;
  }
}
