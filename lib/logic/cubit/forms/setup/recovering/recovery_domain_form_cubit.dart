import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';

class RecoveryDomainFormCubit extends FormCubit {
  RecoveryDomainFormCubit(
    this.initializingCubit,
    final FieldCubitFactory fieldFactory,
  ) {
    serverDomainField = fieldFactory.createRequiredStringField();

    super.addFields([serverDomainField]);
  }

  @override
  Future<void>? onSubmit() async {
    await initializingCubit.submitDomainForAccessRecovery(
      serverDomainField.state.value.toLowerCase(),
    );
  }

  @override
  FutureOr<bool> asyncValidation() async {
    final ServerApi api = ServerApi(
      hasLogger: false,
      isWithToken: false,
      overrideDomain: serverDomainField.state.value,
    );

    // API version doesn't require access token,
    // so if the entered domain is indeed valid
    // and the server by it is reachable, we will
    // be able to confirm the input

    final bool domainValid = await api.getApiVersion() != null;
    if (!domainValid) {
      serverDomainField.setError('recovering.domain_recover_error'.tr());
    }

    return domainValid;
  }

  void setCustomError(final String error) {
    serverDomainField.setError(error);
  }

  final ServerInstallationCubit initializingCubit;
  late final FieldCubit<String> serverDomainField;
}
