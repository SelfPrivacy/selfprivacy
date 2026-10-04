import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/atoms/buttons/dialog_action_button.dart';

DialogRoute<void> showPopUpAlert({
  required final BuildContext context,
  required final String description,
  required final String actionButtonTitle,
  required final void Function() actionButtonOnPressed,
  final void Function()? cancelButtonOnPressed,
  final String? alertTitle,
  final String? cancelButtonTitle,
}) {
  final route = DialogRoute<void>(
    context: context,
    builder: (_) => AlertDialog(
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
  unawaited(Navigator.of(context).push(route));
  return route;
}
