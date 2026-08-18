import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/forms/recovery_device_form.dart';
import 'package:selfprivacy/ui/forms/recovery_device_form_view.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

class RecoverByRecoveryKey extends StatefulWidget {
  const RecoverByRecoveryKey({super.key});

  @override
  State<RecoverByRecoveryKey> createState() => _RecoverByRecoveryKeyState();
}

class _RecoverByRecoveryKeyState extends State<RecoverByRecoveryKey> {
  late final RecoveryDeviceForm _form;

  @override
  void initState() {
    super.initState();
    _form = RecoveryDeviceForm(
      tokenType: RecoveryDeviceTokenType.recoveryKey,
      onSubmit: (final token) => context
          .read<ServerInstallationCubit>()
          .tryToRecover(token, ServerRecoveryMethods.recoveryKey),
    );
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
    heroTitle: 'recovering.recovery_main_header'.tr(),
    heroSubtitle: 'recovering.method_recovery_input_description'.tr(),
    hasBackButton: true,
    hasFlashButton: false,
    ignoreBreakpoints: true,
    onBackButtonPressed: context
        .read<ServerInstallationCubit>()
        .revertRecoveryStep,
    children: [RecoveryDeviceFormView(recoveryDeviceForm: _form)],
  );
}
