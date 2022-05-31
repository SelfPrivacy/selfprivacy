import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/recovering/recovery_domain_form_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/filled_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_old_token.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_recovery_key.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_new_device_key.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_confirm_backblaze.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_confirm_cloudflare.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_confirm_server.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_hentzner_connected.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_method_select.dart';

class RecoveryRouting extends StatelessWidget {
  const RecoveryRouting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var serverInstallation = context.watch<ServerInstallationCubit>().state;

    Widget currentPage = const SelectDomainToRecover();

    if (serverInstallation is ServerInstallationRecovery) {
      switch (serverInstallation.currentStep) {
        case RecoveryStep.selecting:
          if (serverInstallation.recoveryCapabilities ==
              ServerRecoveryCapabilities.loginTokens) {
            currentPage = const RecoveryMethodSelect();
          }
          if (serverInstallation.recoveryCapabilities ==
              ServerRecoveryCapabilities.legacy) {
            currentPage = const RecoveryFallbackMethodSelect();
          }
          break;
        case RecoveryStep.recoveryKey:
          currentPage = const RecoverByRecoveryKey();
          break;
        case RecoveryStep.newDeviceKey:
          currentPage = const RecoverByNewDeviceKeyInstruction();
          break;
        case RecoveryStep.oldToken:
          currentPage = const RecoverByOldToken();
          break;
        case RecoveryStep.hetznerToken:
          currentPage = const RecoveryHetznerConnected();
          break;
        case RecoveryStep.serverSelection:
          currentPage = const RecoveryConfirmServer();
          break;
        case RecoveryStep.cloudflareToken:
          currentPage = const RecoveryConfirmCloudflare();
          break;
        case RecoveryStep.backblazeToken:
          currentPage = const RecoveryConfirmBackblaze();
          break;
      }
    }

    return BlocListener<ServerInstallationCubit, ServerInstallationState>(
      listener: (context, state) {
        if (state is ServerInstallationFinished) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: currentPage,
      ),
    );
  }
}

class SelectDomainToRecover extends StatelessWidget {
  const SelectDomainToRecover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var serverInstallation = context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (context) => RecoveryDomainFormCubit(
          serverInstallation, FieldCubitFactory(context)),
      child: Builder(
        builder: (context) {
          var formCubitState = context.watch<RecoveryDomainFormCubit>().state;

          return BlocListener<ServerInstallationCubit, ServerInstallationState>(
            listener: (context, state) {
              if (state is ServerInstallationRecovery) {
                if (state.currentStep == RecoveryStep.selecting) {
                  if (state.recoveryCapabilities ==
                      ServerRecoveryCapabilities.none) {
                    context
                        .read<RecoveryDomainFormCubit>()
                        .setCustomError('recovering.domain_recover_error'.tr());
                  }
                }
              }
            },
            child: BrandHeroScreen(
              heroTitle: 'recovering.recovery_main_header'.tr(),
              heroSubtitle: 'recovering.domain_recovery_description'.tr(),
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
                    border: const OutlineInputBorder(),
                    labelText: 'recovering.domain_recover_placeholder'.tr(),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  title: 'more.continue'.tr(),
                  onPressed: formCubitState.isSubmitting
                      ? null
                      : () =>
                          context.read<RecoveryDomainFormCubit>().trySubmit(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
