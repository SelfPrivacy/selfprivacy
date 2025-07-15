import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/recovering/recovery_device_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/markdown/brand_md.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class RecoverByOldTokenInstruction extends StatelessWidget {
  @override
  const RecoverByOldTokenInstruction({
    required this.instructionFilename,
    super.key,
  });

  @override
  Widget build(final BuildContext context) =>
      BlocListener<ServerInstallationCubit, ServerInstallationState>(
        listener: (final context, final state) {
          if (state is ServerInstallationRecovery &&
              state.currentStep != RecoveryStep.selecting) {
            Navigator.of(context).pop();
          }
        },
        child: BrandHeroScreen(
          heroTitle: 'recovering.recovery_main_header'.tr(),
          hasBackButton: true,
          hasFlashButton: false,
          ignoreBreakpoints: true,
          onBackButtonPressed:
              context.read<ServerInstallationCubit>().revertRecoveryStep,
          children: [
            BrandMarkdown(fileName: instructionFilename),
            const SizedBox(height: 16),
            BrandButton.filled(
              child: Text('recovering.method_device_button'.tr()),
              onPressed:
                  () => context
                      .read<ServerInstallationCubit>()
                      .selectRecoveryMethod(ServerRecoveryMethods.oldToken),
            ),
          ],
        ),
      );

  final String instructionFilename;
}

class RecoverByOldToken extends StatelessWidget {
  const RecoverByOldToken({super.key});

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationCubit appConfig =
        context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create:
          (final context) => RecoveryDeviceFormCubit(
            appConfig,
            FieldCubitFactory(context),
            ServerRecoveryMethods.oldToken,
          ),
      child: Builder(
        builder: (final context) {
          final FormCubitState formCubitState =
              context.watch<RecoveryDeviceFormCubit>().state;

          return BrandHeroScreen(
            heroTitle: 'recovering.recovery_main_header'.tr(),
            heroSubtitle: 'recovering.method_device_input_description'.tr(),
            hasBackButton: true,
            hasFlashButton: false,
            ignoreBreakpoints: true,
            children: [
              CubitFormTextField(
                autofocus: true,
                formFieldCubit:
                    context.read<RecoveryDeviceFormCubit>().tokenField,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'recovering.method_device_input_placeholder'.tr(),
                ),
              ),
              const SizedBox(height: 16),
              BrandButton.filled(
                onPressed:
                    formCubitState.isSubmitting
                        ? null
                        : () =>
                            context.read<RecoveryDeviceFormCubit>().trySubmit(),
                child: Text('basis.continue'.tr()),
              ),
            ],
          );
        },
      ),
    );
  }
}
