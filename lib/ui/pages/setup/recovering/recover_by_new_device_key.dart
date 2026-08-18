import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/forms/recovery_device_form.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/forms/recovery_device_form_view.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class RecoverByNewDeviceKeyInstruction extends StatelessWidget {
  const RecoverByNewDeviceKeyInstruction({super.key});

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
    heroTitle: 'recovering.recovery_main_header'.tr(),
    heroSubtitle: 'recovering.method_device_description'.tr(),
    hasBackButton: true,
    hasFlashButton: false,
    ignoreBreakpoints: true,
    onBackButtonPressed: context
        .read<ServerInstallationCubit>()
        .revertRecoveryStep,
    children: [
      BrandButton.filled(
        child: Text('recovering.method_device_button'.tr()),
        onPressed: () => Navigator.of(
          context,
        ).push(materialRoute(const RecoverByNewDeviceKeyInput())),
      ),
    ],
  );
}

class RecoverByNewDeviceKeyInput extends StatefulWidget {
  const RecoverByNewDeviceKeyInput({super.key});

  @override
  State<RecoverByNewDeviceKeyInput> createState() =>
      _RecoverByNewDeviceKeyInputState();
}

class _RecoverByNewDeviceKeyInputState
    extends State<RecoverByNewDeviceKeyInput> {
  late final RecoveryDeviceForm _form;

  @override
  void initState() {
    super.initState();
    _form = RecoveryDeviceForm(
      tokenType: RecoveryDeviceTokenType.newDeviceKey,
      onSubmit: (final token) => context
          .read<ServerInstallationCubit>()
          .tryToRecover(token, ServerRecoveryMethods.newDeviceKey),
    );
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) =>
      BlocListener<ServerInstallationCubit, ServerInstallationState>(
        listener:
            (final BuildContext context, final ServerInstallationState state) {
              if (state is ServerInstallationRecovery &&
                  state.currentStep != RecoveryStep.newDeviceKey) {
                Navigator.of(context).pop();
              }
            },
        child: BrandHeroScreen(
          heroTitle: 'recovering.recovery_main_header'.tr(),
          heroSubtitle: 'recovering.method_device_input_description'.tr(),
          hasBackButton: true,
          hasFlashButton: false,
          ignoreBreakpoints: true,
          children: [RecoveryDeviceFormView(recoveryDeviceForm: _form)],
        ),
      );
}
