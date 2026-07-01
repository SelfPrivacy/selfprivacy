import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/ssh_key_form.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';

class SshKeyFormView extends StatelessWidget {
  const SshKeyFormView({required this.sshKeyForm, super.key});

  final SshKeyForm sshKeyForm;

  @override
  Widget build(final BuildContext context) => ReactiveForm(
    formGroup: sshKeyForm.form,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ReactiveTextField<String>(
          formControlName: 'key',
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'ssh.input_label'.tr(),
            filled: true,
          ),
          validationMessages: {
            SshKeyForm.errDuplicateSshKey: (final error) =>
                'validations.already_exist'.tr(),
            SshKeyForm.errInvalidSshKey: (final error) =>
                'validations.invalid_format_ssh'.tr(),
            ValidationMessage.required: (final error) =>
                'validations.required'.tr(),
          },
        ),
        const Gap(16),
        ReactiveFormConsumer(
          builder: (final context, final form, final child) =>
              BrandButton.filled(
                onPressed: form.valid ? sshKeyForm.submit : null,
                title: 'ssh.create'.tr(),
              ),
        ),
      ],
    ),
  );
}
