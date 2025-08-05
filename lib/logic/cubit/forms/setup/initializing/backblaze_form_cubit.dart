import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/backblaze.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';

class BackblazeFormCubit extends FormCubit {
  BackblazeFormCubit(this.serverInstallationCubit) {
    keyId = FieldCubit(
      initalValue: '',
      validations: [RequiredStringValidation('validations.required'.tr())],
    );

    applicationKey = FieldCubit(
      initalValue: '',
      validations: [RequiredStringValidation('required')],
    );

    super.addFields([keyId, applicationKey]);
  }

  @override
  Future<void>? onSubmit() async {
    await serverInstallationCubit.setBackblazeKey(
      keyId.state.value,
      applicationKey.state.value,
    );
  }

  final ServerInstallationCubit serverInstallationCubit;

  late final FieldCubit<String> keyId;
  late final FieldCubit<String> applicationKey;

  @override
  FutureOr<bool> asyncValidation() async {
    late GenericResult<bool> backblazeResponse;
    final BackblazeApi apiClient = BackblazeApi(isWithToken: false);

    try {
      final String encodedApiKey = encodedBackblazeKey(
        keyId.state.value,
        applicationKey.state.value,
      );
      backblazeResponse = await apiClient.isApiTokenValid(encodedApiKey);
    } catch (e) {
      addError(e);
      backblazeResponse = GenericResult(
        success: false,
        data: false,
        message: e.toString(),
      );
    }

    if (!backblazeResponse.success) {
      getIt<NavigationService>().showSnackBar(
        'initializing.could_not_connect'.tr(),
      );
      keyId.setError('');
      applicationKey.setError('');
      return false;
    }

    if (!backblazeResponse.data) {
      keyId.setError('initializing.backblaze_bad_key_error'.tr());
      applicationKey.setError('initializing.backblaze_bad_key_error'.tr());
    }

    return backblazeResponse.data;
  }
}
