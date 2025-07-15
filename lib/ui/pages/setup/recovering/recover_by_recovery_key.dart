import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/recovering/recovery_device_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class RecoverByRecoveryKey extends StatelessWidget {
  const RecoverByRecoveryKey({super.key});

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationCubit appConfig =
        context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create:
          (final context) => RecoveryDeviceFormCubit(
            appConfig,
            FieldCubitFactory(context),
            ServerRecoveryMethods.recoveryKey,
          ),
      child: Builder(
        builder: (final context) {
          final FormCubitState formCubitState =
              context.watch<RecoveryDeviceFormCubit>().state;

          return BrandHeroScreen(
            heroTitle: 'recovering.recovery_main_header'.tr(),
            heroSubtitle: 'recovering.method_recovery_input_description'.tr(),
            hasBackButton: true,
            hasFlashButton: false,
            ignoreBreakpoints: true,
            onBackButtonPressed:
                context.read<ServerInstallationCubit>().revertRecoveryStep,
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
