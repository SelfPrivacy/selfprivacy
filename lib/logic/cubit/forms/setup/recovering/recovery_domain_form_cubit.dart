import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class RecoveryDomainFormCubit extends FormCubit {
  RecoveryDomainFormCubit(
      this.initializingCubit, final FieldCubitFactory fieldFactory) {
    serverDomainField = fieldFactory.createServerDomainField();

    super.addFields([serverDomainField]);
  }

  @override
  FutureOr<void> onSubmit() async {
    initializingCubit.setDomain(ServerDomain(
        domainName: serverDomainField.state.value,
        provider: DnsProvider.Unknown,
        zoneId: ""));
  }

  @override
  FutureOr<bool> asyncValidation() async {
    var api = ServerApi(
        hasLogger: false,
        isWithToken: false,
        overrideDomain: serverDomainField.state.value);

    // API version doesn't require access token,
    // so if the entered domain is indeed valid
    // and the server by it is reachable, we will
    // be able to confirm the input

    final bool domainValid = await api.getApiVersion() != null;
    if (!domainValid) {
      serverDomainField.setError("recovering.domain_recover_error".tr());
    }

    return domainValid;
  }

  FutureOr<void> setCustomError(String error) {
    serverDomainField.setError(error);
  }

  final ServerInstallationCubit initializingCubit;
  late final FieldCubit<String> serverDomainField;
}
