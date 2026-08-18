import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/recovery_device_form.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';

class RecoveryDeviceFormView extends StatelessWidget {
  const RecoveryDeviceFormView({required this.recoveryDeviceForm, super.key});

  final RecoveryDeviceForm recoveryDeviceForm;

  @override
  Widget build(final BuildContext context) => ReactiveForm(
    formGroup: recoveryDeviceForm.form,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ReactiveTextField<String>(
          formControlName: RecoveryDeviceForm.tokenControlName,
          autofocus: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'recovering.method_device_input_placeholder'.tr(),
          ),
          validationMessages: {
            ValidationMessage.required: (final _) =>
                'validations.required'.tr(),
            RecoveryDeviceForm.errInvalidMnemonic: (final _) =>
                _invalidMnemonicMessage,
          },
        ),
        const Gap(16),
        ValueListenableBuilder<bool>(
          valueListenable: recoveryDeviceForm.isSubmitting,
          builder: (final context, final isSubmitting, final _) =>
              BrandButton.filled(
                onPressed: isSubmitting ? null : recoveryDeviceForm.submit,
                child: Text('basis.continue'.tr()),
              ),
        ),
      ],
    ),
  );

  String get _invalidMnemonicMessage =>
      recoveryDeviceForm.tokenType == RecoveryDeviceTokenType.recoveryKey
      ? 'recovering.invalid_recovery_key_format'.tr()
      : 'recovering.invalid_new_device_key_format'.tr();
}
