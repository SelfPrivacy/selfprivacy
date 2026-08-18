import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider_factory.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';

const _genericProviderBadKeyError = 'initializing.provider_bad_key_error';

Future<CredentialValidationResult> checkDnsProviderCredential(
  final DnsProviderCredential credential,
) async {
  if (credential.provider == DnsProviderType.unknown) {
    return const CredentialValidationUnavailable();
  }

  final provider = DnsProviderFactory.createDnsProviderInterface(
    DnsProviderSettings(provider: credential.provider),
  );
  final result = await provider.tryInitApiByToken(credential);
  if (!result.success) {
    return CredentialValidationUnavailable(providerMessage: result.message);
  }

  return result.data
      ? const CredentialValidationValid()
      : CredentialValidationRejected(
          providerMessage: result.message == _genericProviderBadKeyError
              ? null
              : result.message,
        );
}
