import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/user_form.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';

class UserFormView extends StatelessWidget {
  const UserFormView({
    required this.userForm,
    required this.domainName,
    required this.groupsSelector,
    super.key,
  });

  final UserForm userForm;
  final String domainName;
  final Widget groupsSelector;

  @override
  Widget build(final BuildContext context) => ReactiveForm(
    formGroup: userForm.form,
    child: Column(
      children: [
        IntrinsicHeight(
          child: ReactiveTextField<String>(
            formControlName: UserForm.loginControlName,
            autofocus: true,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: userForm.isEdit
                  ? Theme.of(context).colorScheme.onSurface.withAlpha(97)
                  : Theme.of(context).colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              labelText: 'users.login'.tr(),
              suffixText: '@$domainName',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            validationMessages: _validationMessages,
          ),
        ),
        const Gap(24),
        IntrinsicHeight(
          child: ReactiveTextField<String>(
            formControlName: UserForm.displayNameControlName,
            decoration: InputDecoration(
              labelText: 'users.display_name'.tr(),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            validationMessages: _validationMessages,
          ),
        ),
        const Gap(16),
        groupsSelector,
        const Gap(24),
        ValueListenableBuilder<bool>(
          valueListenable: userForm.isSubmitting,
          builder: (final context, final isSubmitting, final _) =>
              BrandButton.filled(
                onPressed: isSubmitting ? null : userForm.submit,
                title: userForm.isEdit
                    ? 'basis.apply'.tr()
                    : 'basis.create'.tr(),
              ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );

  static String _maxLengthMessage(final Object? error) {
    final details = error! as Map<String, dynamic>;
    return 'validations.length_longer'.tr(
      namedArgs: {
        'actualLength': details['actualLength'].toString(),
        'maxLength': details['requiredLength'].toString(),
      },
    );
  }

  static final _validationMessages = <String, String Function(Object?)>{
    ValidationMessage.required: (final _) => 'validations.required'.tr(),
    ValidationMessage.maxLength: _maxLengthMessage,
    ValidationMessage.pattern: (final _) => 'validations.invalid_format'.tr(),
    UserForm.errReservedLogin: (final _) => 'validations.root_name'.tr(),
    UserForm.errLoginTaken: (final _) => 'validations.already_exist'.tr(),
  };
}
