import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';
import 'package:selfprivacy/ui/forms/credential_check_error.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../catalog_case.dart';

@UseCase(name: 'Rejected', type: CredentialCheckError, path: '[Forms]')
Widget credentialCheckErrorRejected(final BuildContext context) =>
    _example('Rejected', const CredentialValidationRejected());

@UseCase(name: 'Unavailable', type: CredentialCheckError, path: '[Forms]')
Widget credentialCheckErrorUnavailable(final BuildContext context) =>
    _example('Unavailable', const CredentialValidationUnavailable());

@UseCase(name: 'Provider message', type: CredentialCheckError, path: '[Forms]')
Widget credentialCheckErrorProviderMessage(final BuildContext context) =>
    _example(
      'Provider message',
      const CredentialValidationRejected(
        providerMessage: 'This token does not have permission to list domains.',
      ),
    );

@UseCase(
  name: 'Translated message',
  type: CredentialCheckError,
  path: '[Forms]',
)
Widget credentialCheckErrorTranslatedMessage(final BuildContext context) =>
    _example(
      'Translated message',
      const CredentialValidationRejected(
        providerMessage: 'initializing.could_not_connect',
      ),
    );

CatalogCase _example(
  final String variant,
  final CredentialValidationFailure failure,
) => CatalogCase(
  key: ValueKey('CredentialCheckError/$variant'),
  id: 'CredentialCheckError/$variant',
  variant: variant,
  builder: (final context, final fixtures, final controller, final update) =>
      CredentialCheckError(
        failure: failure,
        rejectedMessage: 'The provider rejected these credentials.',
      ),
);
