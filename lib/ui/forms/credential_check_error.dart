import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';

class CredentialCheckError extends StatelessWidget {
  const CredentialCheckError({
    required this.failure,
    required this.rejectedMessage,
    super.key,
  });

  final CredentialValidationFailure failure;
  final String rejectedMessage;

  @override
  Widget build(final BuildContext context) {
    final error = switch (failure) {
      CredentialValidationRejected() => rejectedMessage,
      CredentialValidationUnavailable() =>
        'initializing.could_not_connect'.tr(),
    };
    final providerMessage = switch (failure.providerMessage) {
      final message? when message.startsWith('initializing.') => message.tr(),
      final message? => message,
      null => null,
    };
    final style = TextStyle(color: Theme.of(context).colorScheme.error);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(error, style: style),
        if (providerMessage != null && providerMessage != error) ...[
          const Gap(4),
          Text(providerMessage, style: style),
        ],
      ],
    );
  }
}
