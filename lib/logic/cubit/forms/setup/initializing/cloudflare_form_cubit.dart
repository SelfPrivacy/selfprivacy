import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/cloudflare.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/validations/validations.dart';

class CloudFlareFormCubit extends FormCubit {
  CloudFlareFormCubit(this.initializingCubit) {
    final RegExp regExp = RegExp(r'\s+|[!$%^&*()@+|~=`{}\[\]:<>?,.\/]');
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
    final CloudflareApi apiClient = CloudflareApi(isWithToken: false);

    try {
      isKeyValid = await apiClient.isValid(apiKey.state.value);
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
