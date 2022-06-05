import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/validations/validations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';

class FieldCubitFactory {
  FieldCubitFactory(this.context);

  /// A common user login field.
  ///
  /// - Available characters are lowercase a-z, digits and underscore _
  /// - Must start with either a-z or underscore
  /// - Must be no longer than 'userMaxLength' characters
  /// - Must not be empty
  /// - Must not be a reserved root login
  /// - Must be unique
  FieldCubit<String> createUserLoginField() {
    final RegExp userAllowedRegExp = RegExp(r'^[a-z_][a-z0-9_]+$');
    const int userMaxLength = 31;
    return FieldCubit(
      initalValue: '',
      validations: [
        ValidationModel<String>(
          (final String s) => s.toLowerCase() == 'root',
          'validations.root_name'.tr(),
        ),
        ValidationModel(
          (final String login) =>
              context.read<UsersCubit>().state.isLoginRegistered(login),
          'validations.user_already_exist'.tr(),
        ),
        RequiredStringValidation('validations.required'.tr()),
        LengthStringLongerValidation(userMaxLength),
        ValidationModel<String>(
          (final String s) => !userAllowedRegExp.hasMatch(s),
          'validations.invalid_format'.tr(),
        ),
      ],
    );
  }

  /// A common user password field.
  ///
  /// - Must fail on the regural expression of invalid matches: [\n\r\s]+
  /// - Must not be empty
  FieldCubit<String> createUserPasswordField() {
    final RegExp passwordForbiddenRegExp = RegExp(r'[\n\r\s]+');
    return FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('validations.required'.tr()),
        ValidationModel<String>(
          passwordForbiddenRegExp.hasMatch,
          'validations.invalid_format'.tr(),
        ),
      ],
    );
  }

  FieldCubit<String> createRequiredStringField() => FieldCubit(
        initalValue: '',
        validations: [
          RequiredStringValidation('validations.required'.tr()),
        ],
      );

  final BuildContext context;
}
