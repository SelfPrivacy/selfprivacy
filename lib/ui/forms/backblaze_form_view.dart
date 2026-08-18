import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/backblaze_form.dart';
import 'package:selfprivacy/logic/forms/checks/credential_check_state.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/forms/credential_check_error.dart';

class BackblazeFormView extends StatelessWidget {
  const BackblazeFormView({required this.backblazeForm, super.key});

  final BackblazeForm backblazeForm;

  @override
  Widget build(final BuildContext context) => ReactiveForm(
    formGroup: backblazeForm.form,
    child: ValueListenableBuilder<CredentialCheckState>(
      valueListenable: backblazeForm.credentialCheckState,
      builder: (final context, final checkState, final _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReactiveTextField<String>(
            formControlName: BackblazeForm.keyIdControlName,
            autofocus: true,
            scrollPadding: const EdgeInsets.only(bottom: 70),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Key ID',
            ),
            validationMessages: {
              ValidationMessage.required: (final _) =>
                  'validations.required'.tr(),
            },
          ),
          const Gap(16),
          ReactiveTextField<String>(
            formControlName: BackblazeForm.applicationKeyControlName,
            scrollPadding: const EdgeInsets.only(bottom: 70),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Master Application Key',
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
              rejectedMessage: 'initializing.backblaze_bad_key_error'.tr(),
            ),
          ],
          const Gap(16),
          ReactiveFormConsumer(
            builder: (final context, final form, final _) => BrandButton.filled(
              onPressed: form.valid && checkState is! CredentialCheckRunning
                  ? backblazeForm.submit
                  : null,
              title: 'basis.connect'.tr(),
            ),
          ),
        ],
      ),
    ),
  );
}
