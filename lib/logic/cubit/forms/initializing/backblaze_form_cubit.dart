
import 'dart:async';
import 'dart:convert';
import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/backblaze.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';

class BackblazeFormCubit extends FormCubit {
  BackblazeApi apiClient = BackblazeApi();

  BackblazeFormCubit(this.initializingCubit) {
    //var regExp = RegExp(r"\s+|[-!$%^&*()@+|~=`{}\[\]:<>?,.\/]");
    keyId = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('required'),
        //ValidationModel<String>(
        //(s) => regExp.hasMatch(s), 'invalid key format'),
        //LegnthStringValidationWithLenghShowing(64, 'length is [] shoud be 64')
      ],
    );

    applicationKey = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('required'),
        //ValidationModel<String>(
        //(s) => regExp.hasMatch(s), 'invalid key format'),
        //LegnthStringValidationWithLenghShowing(64, 'length is [] shoud be 64')
      ],
    );

    super.setFields([keyId, applicationKey]);
  }

  @override
  FutureOr<void> onSubmit() async {
    String encodedApiKey =
        encodeToBase64(keyId.state.value, applicationKey.state.value);

    initializingCubit.setBackblazeKey(encodedApiKey);
  }

  final AppConfigCubit initializingCubit;

  FieldCubit<String> keyId;

  FieldCubit<String> applicationKey;

  @override
  FutureOr<bool> asyncValidation() async {
    bool isKeyValid;
    try {
      String encodedApiKey =
          encodeToBase64(keyId.state.value, applicationKey.state.value);
      isKeyValid = await apiClient.isValid(encodedApiKey);
    } catch (e) {
      addError(e);
    }

    if (!isKeyValid) {
      keyId.setError('bad key');
      applicationKey.setError('bad key');
      return false;
    }
    return true;
  }

  @override
  Future<void> close() async {
    apiClient.close();

    return super.close();
  }

  String encodeToBase64(String keyId, String applicationKey) {
    String _apiKey = '$keyId:$applicationKey';
    String encodedApiKey = base64.encode(utf8.encode(_apiKey));
    return encodedApiKey;
  }
}