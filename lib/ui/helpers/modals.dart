import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/ui/components/buttons/dialog_action_button.dart';
import 'package:selfprivacy/ui/components/brand_alert/brand_alert.dart';

Future<T?> showBrandBottomSheet<T>({
  required final BuildContext context,
  required final WidgetBuilder builder,
}) =>
    showCupertinoModalBottomSheet<T>(
      builder: builder,
      barrierColor: Colors.black45,
      context: context,
      shadow: const BoxShadow(color: Colors.transparent),
      backgroundColor: Colors.transparent,
    );

void showPopUpAlert({
  required final String description,
  required final String actionButtonTitle,
  required final void Function() actionButtonOnPressed,
  final void Function()? cancelButtonOnPressed,
  final String? alertTitle,
  final String? cancelButtonTitle,
}) {
  getIt.get<NavigationService>().showPopUpDialog(
        BrandAlert(
          title: alertTitle ?? 'basis.alert'.tr(),
          contentText: description,
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
