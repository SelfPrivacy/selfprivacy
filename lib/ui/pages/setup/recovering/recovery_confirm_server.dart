import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/recovering/recovery_domain_form_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/FilledButton.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';

class RecoveryConfirmServer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var serverInstallation = context.watch<ServerInstallationCubit>();

    return Builder(
      builder: (context) {
        var formCubitState = context.watch<RecoveryDomainFormCubit>().state;

        return BlocListener<ServerInstallationCubit, ServerInstallationState>(
          listener: (context, state) {
            if (state is ServerInstallationRecovery) {
              if (state.currentStep == RecoveryStep.Selecting) {
                if (state.recoveryCapabilities ==
                    ServerRecoveryCapabilities.none) {
                  context
                      .read<RecoveryDomainFormCubit>()
                      .setCustomError("recovering.domain_recover_error".tr());
                }
              }
            }
          },
          child: BrandHeroScreen(
            heroTitle: "recovering.recovery_main_header".tr(),
            heroSubtitle: "recovering.domain_recovery_description".tr(),
            hasBackButton: true,
            hasFlashButton: false,
            onBackButtonPressed:
                serverInstallation is ServerInstallationRecovery
                    ? () => serverInstallation.clearAppConfig()
                    : null,
            children: [
              CubitFormTextField(
                formFieldCubit:
                    context.read<RecoveryDomainFormCubit>().serverDomainField,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "recovering.domain_recover_placeholder".tr(),
                ),
              ),
              SizedBox(height: 16),
              FilledButton(
                title: "more.continue".tr(),
                onPressed: formCubitState.isSubmitting
                    ? null
                    : () => context.read<RecoveryDomainFormCubit>().trySubmit(),
              )
            ],
          ),
        );
      },
    );
  }
}
