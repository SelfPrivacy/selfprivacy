import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/recovering/recovery_device_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/FilledButton.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';

class RecoveryMethodToken extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appConfig = context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (context) =>
          RecoveryDeviceFormCubit(appConfig, FieldCubitFactory(context)),
      child: Builder(
        builder: (context) {
          var formCubitState = context.watch<RecoveryDeviceFormCubit>().state;

          return BrandHeroScreen(
            heroTitle: "recovering.recovery_main_header".tr(),
            heroSubtitle: "recovering.method_recovery_input_description".tr(),
            hasBackButton: true,
            hasFlashButton: false,
            children: [
              CubitFormTextField(
                formFieldCubit:
                    context.read<RecoveryDeviceFormCubit>().tokenField,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "recovering.method_device_input_placeholder".tr(),
                ),
              ),
              SizedBox(height: 16),
              FilledButton(
                title: "more.continue".tr(),
                onPressed: formCubitState.isSubmitting
                    ? null
                    : () => context.read<RecoveryDeviceFormCubit>().trySubmit(),
              )
            ],
          );
        },
      ),
    );
  }
}
