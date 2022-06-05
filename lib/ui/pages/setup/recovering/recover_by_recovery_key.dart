import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/recovering/recovery_device_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';

class RecoverByRecoveryKey extends StatelessWidget {
  const RecoverByRecoveryKey({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    ServerInstallationCubit appConfig = context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (final context) => RecoveryDeviceFormCubit(
        appConfig,
        FieldCubitFactory(context),
        ServerRecoveryMethods.recoveryKey,
      ),
      child: Builder(
        builder: (final context) {
          FormCubitState formCubitState = context.watch<RecoveryDeviceFormCubit>().state;

          return BrandHeroScreen(
            heroTitle: 'recovering.recovery_main_header'.tr(),
            heroSubtitle: 'recovering.method_recovery_input_description'.tr(),
            hasBackButton: true,
            hasFlashButton: false,
            onBackButtonPressed: () =>
                context.read<ServerInstallationCubit>().revertRecoveryStep(),
            children: [
              CubitFormTextField(
                formFieldCubit:
                    context.read<RecoveryDeviceFormCubit>().tokenField,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'recovering.method_device_input_placeholder'.tr(),
                ),
              ),
              const SizedBox(height: 16),
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
