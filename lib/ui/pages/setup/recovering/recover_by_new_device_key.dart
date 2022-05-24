import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/recovering/recovery_device_form_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/FilledButton.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';

class RecoverByNewDeviceKeyInstruction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BrandHeroScreen(
      heroTitle: "recovering.recovery_main_header".tr(),
      heroSubtitle: "recovering.method_device_description".tr(),
      hasBackButton: true,
      hasFlashButton: false,
      onBackButtonPressed: () =>
          context.read<ServerInstallationCubit>().revertRecoveryStep(),
      children: [
        FilledButton(
          title: "recovering.method_device_button".tr(),
          onPressed: () => Navigator.of(context)
              .push(materialRoute(RecoverByNewDeviceKeyInput())),
        )
      ],
    );
  }
}

class RecoverByNewDeviceKeyInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appConfig = context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (context) => RecoveryDeviceFormCubit(
        appConfig,
        FieldCubitFactory(context),
        ServerRecoveryMethods.newDeviceKey,
      ),
      child: BlocListener<ServerInstallationCubit, ServerInstallationState>(
        listener: (context, state) {
          if (state is ServerInstallationRecovery &&
              state.currentStep != RecoveryStep.NewDeviceKey) {
            Navigator.of(context).pop();
          }
        },
        child: Builder(
          builder: (context) {
            var formCubitState = context.watch<RecoveryDeviceFormCubit>().state;

            return BrandHeroScreen(
              heroTitle: "recovering.recovery_main_header".tr(),
              heroSubtitle: "recovering.method_device_input_description".tr(),
              hasBackButton: true,
              hasFlashButton: false,
              children: [
                CubitFormTextField(
                  formFieldCubit:
                      context.read<RecoveryDeviceFormCubit>().tokenField,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText:
                        "recovering.method_device_input_placeholder".tr(),
                  ),
                ),
                SizedBox(height: 16),
                FilledButton(
                  title: "more.continue".tr(),
                  onPressed: formCubitState.isSubmitting
                      ? null
                      : () =>
                          context.read<RecoveryDeviceFormCubit>().trySubmit(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
