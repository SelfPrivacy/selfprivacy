import 'package:selfprivacy/logic/api_maps/rest_maps/backblaze.dart';
import 'package:selfprivacy/logic/forms/backblaze_form.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';

Future<CredentialValidationResult> checkBackblazeCredentials(
  final BackblazeCredentials credentials,
) async {
  final encodedApiKey = encodedBackblazeKey(
    credentials.keyId,
    credentials.applicationKey,
  );
  final result = await BackblazeApi(
    isWithToken: false,
  ).isApiTokenValid(encodedApiKey);

  if (!result.success) {
    return const CredentialValidationUnavailable();
  }

  return result.data
      ? const CredentialValidationValid()
      : const CredentialValidationRejected();
}
