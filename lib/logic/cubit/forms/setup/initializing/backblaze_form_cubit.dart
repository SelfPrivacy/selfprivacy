import 'dart:async';
import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/backblaze.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_credential.dart';
import 'package:easy_localization/easy_localization.dart';

class BackblazeFormCubit extends FormCubit {
  BackblazeFormCubit(this.serverInstallationCubit) {
    //var regExp = RegExp(r"\s+|[-!$%^&*()@+|~=`{}\[\]:<>?,.\/]");
    keyId = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('validations.required'.tr()),
      ],
    );

    applicationKey = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('required'),
      ],
    );

    super.addFields([keyId, applicationKey]);
  }

  @override
  FutureOr<void> onSubmit() async {
    serverInstallationCubit.setBackblazeKey(
      keyId.state.value,
      applicationKey.state.value,
    );
  }

  final ServerInstallationCubit serverInstallationCubit;

  late final FieldCubit<String> keyId;
  late final FieldCubit<String> applicationKey;

  @override
  FutureOr<bool> asyncValidation() async {
    late bool isKeyValid;
    final BackblazeApi apiClient = BackblazeApi(isWithToken: false);

    try {
      final String encodedApiKey = encodedBackblazeKey(
        keyId.state.value,
        applicationKey.state.value,
      );
      isKeyValid = await apiClient.isValid(encodedApiKey);
    } catch (e) {
      addError(e);
      isKeyValid = false;
    }

    if (!isKeyValid) {
      keyId.setError('initializing.backblaze_bad_key_error'.tr());
      applicationKey.setError('initializing.backblaze_bad_key_error'.tr());
      return false;
    }

    return true;
  }
}
