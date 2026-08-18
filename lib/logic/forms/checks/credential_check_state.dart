import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';

sealed class CredentialCheckState {
  const CredentialCheckState();
}

final class CredentialCheckIdle extends CredentialCheckState {
  const CredentialCheckIdle();
}

final class CredentialCheckRunning extends CredentialCheckState {
  const CredentialCheckRunning();
}

final class CredentialCheckFailed extends CredentialCheckState {
  const CredentialCheckFailed(this.failure);

  final CredentialValidationFailure failure;
}
