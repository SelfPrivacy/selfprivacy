import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/cubit/forms/validations/validations.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';

class HetznerFormCubit extends FormCubit {
  HetznerFormCubit(this.initializingCubit) {
    var regExp = RegExp(r"\s+|[-!$%^&*()@+|~=`{}\[\]:<>?,.\/]");
    apiKey = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('required'),
        ValidationModel<String>(
            (s) => regExp.hasMatch(s), 'invalid key format'),
        LegnthStringValidationWithLenghShowing(64, 'length is [] shoud be 64')
      ],
    );

    super.addFields([apiKey]);
  }

  @override
  FutureOr<void> onSubmit() async {
    initializingCubit.setHetznerKey(apiKey.state.value);
  }

  final AppConfigCubit initializingCubit;

  late final FieldCubit<String> apiKey;

  @override
  FutureOr<bool> asyncValidation() async {
    late bool isKeyValid;
    HetznerApi apiClient = HetznerApi(isWithToken: false);

    try {
      isKeyValid = await apiClient.isValid(apiKey.state.value);
    } catch (e) {
      addError(e);
    }

    if (!isKeyValid) {
      apiKey.setError('bad key');
      return false;
    }
    return true;
  }
}
