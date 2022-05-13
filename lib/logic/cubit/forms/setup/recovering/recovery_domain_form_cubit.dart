import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/models/server_domain.dart';

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

  // @override
  // FutureOr<bool> asyncValidation() async {
  //   ; //var client =
  // }

  final AppConfigCubit initializingCubit;
  late final FieldCubit<String> serverDomainField;
}
