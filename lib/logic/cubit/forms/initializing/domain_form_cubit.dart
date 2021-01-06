import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/cloud_flare.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';

class DomainFormCubit extends FormCubit {
  CloudflareApi apiClient = CloudflareApi();

  DomainFormCubit(this.initializingCubit) {
    var regExp =
        RegExp(r"^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}");
    domainName = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('required'),
        ValidationModel<String>(
            (s) => !regExp.hasMatch(s), 'invalid domain format'),
      ],
    );

    super.setFields([domainName]);
  }

  @override
  FutureOr<void> onSubmit() async {
    var domain = CloudFlareDomain(
      name: domainName.state.value,
      zoneId: zoneId,
    );
    initializingCubit.setDomain(domain);
  }

  final AppConfigCubit initializingCubit;

  FieldCubit<String> domainName;
  String zoneId;

  @override
  FutureOr<bool> asyncValidation() async {
    var key = initializingCubit.state.cloudFlareKey;

    var zoneId = await apiClient.getZoneId(key, domainName.state.value);

    if (zoneId == null) {
      domainName.setError('Domain not in the list');
      return false;
    }
    this.zoneId = zoneId;
    return true;
  }

  @override
  Future<void> close() async {
    apiClient.close();

    return super.close();
  }
}
