import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

Future<CredentialValidationResult> checkServerProviderCredential(
  final ServerProviderType providerType,
  final String credential,
) async {
  if (providerType == ServerProviderType.unknown) {
    return const CredentialValidationUnavailable();
  }

  final provider = ServerProviderFactory.createServerProviderInterface(
    ServerProviderSettings(provider: providerType),
  );
  final result = await provider.tryInitApiByToken(credential);
  if (!result.success) {
    return CredentialValidationUnavailable(providerMessage: result.message);
  }

  return result.data
      ? const CredentialValidationValid()
      : CredentialValidationRejected(providerMessage: result.message);
}
