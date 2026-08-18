import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/forms/recovery_device_form.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/markdown/brand_md.dart';
import 'package:selfprivacy/ui/forms/recovery_device_form_view.dart';
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
          onBackButtonPressed: context
              .read<ServerInstallationCubit>()
              .revertRecoveryStep,
          children: [
            BrandMarkdown(fileName: instructionFilename),
            const SizedBox(height: 16),
            BrandButton.filled(
              child: Text('recovering.method_device_button'.tr()),
              onPressed: () => context
                  .read<ServerInstallationCubit>()
                  .selectRecoveryMethod(ServerRecoveryMethods.oldToken),
            ),
          ],
        ),
      );

  final String instructionFilename;
}

class RecoverByOldToken extends StatefulWidget {
  const RecoverByOldToken({super.key});

  @override
  State<RecoverByOldToken> createState() => _RecoverByOldTokenState();
}

class _RecoverByOldTokenState extends State<RecoverByOldToken> {
  late final RecoveryDeviceForm _form;

  @override
  void initState() {
    super.initState();
    _form = RecoveryDeviceForm(
      tokenType: RecoveryDeviceTokenType.oldToken,
      onSubmit: (final token) => context
          .read<ServerInstallationCubit>()
          .tryToRecover(token, ServerRecoveryMethods.oldToken),
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
    heroSubtitle: 'recovering.method_device_input_description'.tr(),
    hasBackButton: true,
    hasFlashButton: false,
    ignoreBreakpoints: true,
    children: [RecoveryDeviceFormView(recoveryDeviceForm: _form)],
  );
}
