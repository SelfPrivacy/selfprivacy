import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/recovering/recovery_domain_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_new_device_key.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_old_token.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_recovery_key.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_confirm_backblaze.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_confirm_dns.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_confirm_server.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_method_select.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_server_provider_connected.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

@RoutePage()
class RecoveryRoutingPage extends StatelessWidget {
  const RecoveryRoutingPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final serverInstallation = context.watch<ServerInstallationCubit>().state;

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
        case RecoveryStep.recoveryKey:
          currentPage = const RecoverByRecoveryKey();
        case RecoveryStep.newDeviceKey:
          currentPage = const RecoverByNewDeviceKeyInstruction();
        case RecoveryStep.oldToken:
          currentPage = const RecoverByOldToken();
        case RecoveryStep.serverProviderToken:
          currentPage = const RecoveryServerProviderConnected();
        case RecoveryStep.serverSelection:
          currentPage = const RecoveryConfirmServer();
        case RecoveryStep.dnsProviderToken:
          currentPage = const RecoveryConfirmDns();
        case RecoveryStep.backblazeToken:
          currentPage = const RecoveryConfirmBackblaze();
      }
    }

    return BlocListener<ServerInstallationCubit, ServerInstallationState>(
      listener: (final context, final state) {
        if (state is ServerInstallationFinished) {
          Navigator.of(context).popUntil((final route) => route.isFirst);
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
  const SelectDomainToRecover({super.key});

  @override
  Widget build(final BuildContext context) {
    final serverInstallation = context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create:
          (final context) => RecoveryDomainFormCubit(
            serverInstallation,
            FieldCubitFactory(context),
          ),
      child: Builder(
        builder: (final context) {
          final formCubitState = context.watch<RecoveryDomainFormCubit>().state;

          return BlocListener<ServerInstallationCubit, ServerInstallationState>(
            listener: (final context, final state) {
              if (state is ServerInstallationRecovery) {
                if (state.currentStep == RecoveryStep.selecting) {
                  if (state.recoveryCapabilities ==
                      ServerRecoveryCapabilities.none) {
                    context.read<RecoveryDomainFormCubit>().setCustomError(
                      'recovering.domain_recover_error'.tr(),
                    );
                  }
                }
              }
            },
            child: BrandHeroScreen(
              heroTitle: 'recovering.recovery_main_header'.tr(),
              heroSubtitle: 'recovering.domain_recovery_description'.tr(),
              hasBackButton: true,
              hasFlashButton: false,
              ignoreBreakpoints: true,
              onBackButtonPressed: () async {
                await Navigator.of(context).pushAndRemoveUntil(
                  materialRoute(const RootPage()),
                  (final predicate) => false,
                );
              },
              children: [
                CubitFormTextField(
                  autofocus: true,
                  formFieldCubit:
                      context.read<RecoveryDomainFormCubit>().serverDomainField,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'recovering.domain_recover_placeholder'.tr(),
                  ),
                ),
                const SizedBox(height: 16),
                BrandButton.filled(
                  onPressed:
                      formCubitState.isSubmitting
                          ? null
                          : () =>
                              context
                                  .read<RecoveryDomainFormCubit>()
                                  .trySubmit(),
                  child: Text('basis.continue'.tr()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
