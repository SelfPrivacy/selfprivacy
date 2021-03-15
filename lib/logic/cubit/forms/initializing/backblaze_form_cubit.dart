import 'dart:async';
import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/backblaze.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/models/backblaze_credential.dart';

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
    initializingCubit.setBackblazeKey(
      keyId.state.value,
      applicationKey.state.value,
    );
  }

  final AppConfigCubit initializingCubit;

  // ignore: close_sinks
  late final FieldCubit<String> keyId;
  // ignore: close_sinks
  late final FieldCubit<String> applicationKey;

  @override
  FutureOr<bool> asyncValidation() async {
    late bool isKeyValid;
    try {
      String encodedApiKey = encodedBackblazeKey(
        keyId.state.value,
        applicationKey.state.value,
      );
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
}
