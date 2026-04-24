import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/ui/atoms/buttons/dialog_action_button.dart';

void showPopUpAlert({
  required final String description,
  required final String actionButtonTitle,
  required final void Function() actionButtonOnPressed,
  final void Function()? cancelButtonOnPressed,
  final String? alertTitle,
  final String? cancelButtonTitle,
}) {
  getIt.get<NavigationService>().showPopUpDialog(
    AlertDialog(
      title: Text(alertTitle ?? 'basis.alert'.tr()),
      content: Text(description),
      actions: [
        DialogActionButton(
          text: actionButtonTitle,
          isRed: true,
          onPressed: actionButtonOnPressed,
        ),
        DialogActionButton(
          text: cancelButtonTitle ?? 'basis.cancel'.tr(),
          onPressed: cancelButtonOnPressed,
        ),
      ],
    ),
  );
}
