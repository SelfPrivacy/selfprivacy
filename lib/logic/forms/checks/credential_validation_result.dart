sealed class CredentialValidationResult {
  const CredentialValidationResult();
}

final class CredentialValidationValid extends CredentialValidationResult {
  const CredentialValidationValid();
}

sealed class CredentialValidationFailure extends CredentialValidationResult {
  const CredentialValidationFailure({this.providerMessage});

  final String? providerMessage;
}

final class CredentialValidationRejected extends CredentialValidationFailure {
  const CredentialValidationRejected({super.providerMessage});
}

final class CredentialValidationUnavailable
    extends CredentialValidationFailure {
  const CredentialValidationUnavailable({super.providerMessage});
}
