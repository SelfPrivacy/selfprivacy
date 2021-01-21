import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/cloudflare.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/validations/validations.dart';

class CloudFlareFormCubit extends FormCubit {
  CloudflareApi apiClient = CloudflareApi();

  CloudFlareFormCubit(this.initializingCubit) {
    var regExp = RegExp(r"\s+|[!$%^&*()@+|~=`{}\[\]:<>?,.\/]");
    apiKey = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('required'),
        ValidationModel<String>(
            (s) => regExp.hasMatch(s), 'invalid key format'),
        LegnthStringValidationWithLenghShowing(40, 'length is [] shoud be 40')
      ],
    );

    super.setFields([apiKey]);
  }

  @override
  FutureOr<void> onSubmit() async {
    initializingCubit.setCloudFlare(apiKey.state.value);
  }

  final AppConfigCubit initializingCubit;

  FieldCubit<String> apiKey;

  @override
  FutureOr<bool> asyncValidation() async {
    bool isKeyValid;

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

  @override
  Future<void> close() async {
    apiClient.close();

    return super.close();
  }
}
