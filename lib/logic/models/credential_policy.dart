import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';

enum CredentialPolicy {
  any,
  mfa,
  passkey,
  attestedPasskey,
  unknown;

  static CredentialPolicy fromGraphQL(final Enum$KanidmCredentialType value) =>
      switch (value) {
        Enum$KanidmCredentialType.any => any,
        Enum$KanidmCredentialType.mfa => mfa,
        Enum$KanidmCredentialType.passkey => passkey,
        Enum$KanidmCredentialType.attested_passkey => attestedPasskey,
        Enum$KanidmCredentialType.$unknown => unknown,
      };

  Enum$KanidmCredentialType get graphQL => switch (this) {
    any => Enum$KanidmCredentialType.any,
    mfa => Enum$KanidmCredentialType.mfa,
    passkey => Enum$KanidmCredentialType.passkey,
    attestedPasskey => Enum$KanidmCredentialType.attested_passkey,
    unknown => throw ArgumentError(
      'Unknown credential policy cannot be submitted.',
    ),
  };

  String get translationKey =>
      'server.credential_policy.${this == attestedPasskey ? 'attested_passkey' : name}';
}
