import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/recovering/recovery_device_form_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';

class RecoverByOldTokenInstruction extends StatelessWidget {
  @override
  const RecoverByOldTokenInstruction(
      {Key? key, required this.instructionFilename})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServerInstallationCubit, ServerInstallationState>(
      listener: (context, state) {
        if (state is ServerInstallationRecovery &&
            state.currentStep != RecoveryStep.selecting) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
      child: BrandHeroScreen(
        heroTitle: 'recovering.recovery_main_header'.tr(),
        hasBackButton: true,
        hasFlashButton: false,
        onBackButtonPressed: () =>
            context.read<ServerInstallationCubit>().revertRecoveryStep(),
        children: [
          BrandMarkdown(
            fileName: instructionFilename,
          ),
          const SizedBox(height: 18),
          FilledButton(
            title: 'recovering.method_device_button'.tr(),
            onPressed: () => context
                .read<ServerInstallationCubit>()
                .selectRecoveryMethod(ServerRecoveryMethods.oldToken),
          )
        ],
      ),
    );
  }

  final String instructionFilename;
}

class RecoverByOldToken extends StatelessWidget {
  const RecoverByOldToken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appConfig = context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (context) => RecoveryDeviceFormCubit(
        appConfig,
        FieldCubitFactory(context),
        ServerRecoveryMethods.oldToken,
      ),
      child: Builder(
        builder: (context) {
          var formCubitState = context.watch<RecoveryDeviceFormCubit>().state;

          return BrandHeroScreen(
            heroTitle: 'recovering.recovery_main_header'.tr(),
            heroSubtitle: 'recovering.method_device_input_description'.tr(),
            hasBackButton: true,
            hasFlashButton: false,
            children: [
              CubitFormTextField(
                formFieldCubit:
                    context.read<RecoveryDeviceFormCubit>().tokenField,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'recovering.method_device_input_placeholder'.tr(),
                ),
              ),
              const SizedBox(height: 18),
              FilledButton(
                title: 'more.continue'.tr(),
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
