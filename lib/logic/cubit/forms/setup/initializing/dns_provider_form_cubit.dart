import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:sp_cubit_form/sp_cubit_form.dart';

class DnsProviderFormCubit extends FormCubit {
  DnsProviderFormCubit(this.initializingCubit, this.dnsProviderType) {
    final requiredCredentials = dnsProviderType.requiredCredentials;

    token = FieldCubit(
      initalValue: '',
      validations: [RequiredStringValidation('validations.required'.tr())],
    );

    tokenId = FieldCubit<String>(
      initalValue: '',
      validations: [RequiredStringValidation('validations.required'.tr())],
    );

    url = FieldCubit<String>(
      initalValue: '',
      validations: [RequiredStringValidation('validations.required'.tr())],
    );

    tenant = FieldCubit<String>(
      initalValue: '',
      validations: [RequiredStringValidation('validations.required'.tr())],
    );

    secondaryToken = FieldCubit<String>(
      initalValue: '',
      validations: [RequiredStringValidation('validations.required'.tr())],
    );

    super.addFields([
      token,
      if (requiredCredentials.requiresTokenId) tokenId,
      if (requiredCredentials.requiresUrl) url,
      if (requiredCredentials.requiresTenant) tenant,
      if (requiredCredentials.requiresSecondaryToken) secondaryToken,
    ]);
  }

  @override
  Future<void>? onSubmit() async {
    await initializingCubit.setDnsApiCredential(
      DnsProviderCredential(
        provider: dnsProviderType,
        token: token.state.value,
        tokenId: dnsProviderType.requiredCredentials.requiresTokenId
            ? tokenId.state.value
            : null,
        url: dnsProviderType.requiredCredentials.requiresUrl
            ? url.state.value
            : null,
        tenant: dnsProviderType.requiredCredentials.requiresTenant
            ? tenant.state.value
            : null,
        secondaryToken:
            dnsProviderType.requiredCredentials.requiresSecondaryToken
            ? secondaryToken.state.value
            : null,
        associatedDomainNames: [],
      ),
    );
  }

  final ServerInstallationCubit initializingCubit;
  final DnsProviderType dnsProviderType;

  late final FieldCubit<String> token;
  late final FieldCubit<String> tokenId;
  late final FieldCubit<String> url;
  late final FieldCubit<String> tenant;
  late final FieldCubit<String> secondaryToken;

  @override
  FutureOr<bool> asyncValidation() async {
    bool? isKeyValid;

    try {
      isKeyValid = await initializingCubit.isDnsProviderApiTokenValid(
        DnsProviderCredential(
          provider: dnsProviderType,
          token: token.state.value,
          tokenId: dnsProviderType.requiredCredentials.requiresTokenId
              ? tokenId.state.value
              : null,
          url: dnsProviderType.requiredCredentials.requiresUrl
              ? url.state.value
              : null,
          tenant: dnsProviderType.requiredCredentials.requiresTenant
              ? tenant.state.value
              : null,
          secondaryToken:
              dnsProviderType.requiredCredentials.requiresSecondaryToken
              ? secondaryToken.state.value
              : null,
          associatedDomainNames: [],
        ),
      );
    } catch (e) {
      addError(e);
    }

    if (isKeyValid == null) {
      token.setError('');
      return false;
    }

    if (!isKeyValid) {
      token.setError('initializing.provider_bad_key_error'.tr());
    }

    return isKeyValid;
  }
}
