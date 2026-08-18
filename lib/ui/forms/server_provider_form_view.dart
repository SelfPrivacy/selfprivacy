import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/checks/credential_check_state.dart';
import 'package:selfprivacy/logic/forms/server_provider_form.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/forms/credential_check_error.dart';

class ServerProviderFormView extends StatelessWidget {
  const ServerProviderFormView({
    required this.serverProviderForm,
    required this.fieldLabel,
    required this.submitLabel,
    super.key,
  });

  final ServerProviderForm serverProviderForm;
  final String fieldLabel;
  final String submitLabel;

  @override
  Widget build(final BuildContext context) => ReactiveForm(
    formGroup: serverProviderForm.form,
    child: ValueListenableBuilder<CredentialCheckState>(
      valueListenable: serverProviderForm.credentialCheckState,
      builder: (final context, final checkState, final _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReactiveTextField<String>(
            formControlName: ServerProviderForm.apiKeyControlName,
            autofocus: true,
            scrollPadding: const EdgeInsets.only(bottom: 70),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: fieldLabel,
            ),
            validationMessages: {
              ValidationMessage.required: (final _) =>
                  'validations.required'.tr(),
            },
          ),
          if (checkState case CredentialCheckFailed(:final failure)) ...[
            const Gap(16),
            CredentialCheckError(
              failure: failure,
              rejectedMessage: 'initializing.provider_bad_key_error'.tr(),
            ),
          ],
          const Gap(16),
          ReactiveFormConsumer(
            builder: (final context, final form, final _) => BrandButton.filled(
              onPressed: form.valid && checkState is! CredentialCheckRunning
                  ? serverProviderForm.submit
                  : null,
              title: submitLabel,
            ),
          ),
        ],
      ),
    ),
  );
}
