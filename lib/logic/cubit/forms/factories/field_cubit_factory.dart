import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sp_cubit_form/sp_cubit_form.dart';

class FieldCubitFactory {
  FieldCubitFactory(this.context);

  FieldCubit<String> createRequiredStringField() => FieldCubit(
    initalValue: '',
    validations: [RequiredStringValidation('validations.required'.tr())],
  );

  final BuildContext context;
}
