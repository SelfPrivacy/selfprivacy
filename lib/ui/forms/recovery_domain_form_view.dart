import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/recovery_domain_form.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';

class RecoveryDomainFormView extends StatelessWidget {
  const RecoveryDomainFormView({required this.recoveryDomainForm, super.key});

  final RecoveryDomainForm recoveryDomainForm;

  @override
  Widget build(final BuildContext context) => ReactiveForm(
    formGroup: recoveryDomainForm.form,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ReactiveTextField<String>(
          formControlName: RecoveryDomainForm.domainControlName,
          autofocus: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'recovering.domain_recover_placeholder'.tr(),
          ),
          onChanged: (final _) => recoveryDomainForm.clearDomainNotFoundError(),
          validationMessages: {
            ValidationMessage.required: (final _) =>
                'validations.required'.tr(),
            RecoveryDomainForm.errDomainNotFound: (final _) =>
                'recovering.domain_recover_error'.tr(),
          },
        ),
        const Gap(16),
        ValueListenableBuilder<bool>(
          valueListenable: recoveryDomainForm.isSubmitting,
          builder: (final context, final isSubmitting, final _) =>
              BrandButton.filled(
                onPressed: isSubmitting ? null : recoveryDomainForm.submit,
                child: Text('basis.continue'.tr()),
              ),
        ),
      ],
    ),
  );
}
