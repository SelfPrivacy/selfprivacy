import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';

class RecoveryDeviceFormCubit extends FormCubit {
  RecoveryDeviceFormCubit(
      this.initializingCubit, final FieldCubitFactory fieldFactory) {
    tokenField = fieldFactory.createServerDomainField();

    super.addFields([tokenField]);
  }

  @override
  FutureOr<void> onSubmit() async {
    // initializingCubit.setDomain(ServerDomain(
    //     domainName: serverDomainField.state.value,
    //     provider: DnsProvider.Unknown,
    //     zoneId: ""));
  }

  final ServerInstallationCubit initializingCubit;
  late final FieldCubit<String> tokenField;
}
