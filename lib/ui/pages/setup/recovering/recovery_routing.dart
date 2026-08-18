import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/forms/checks/recovery_domain_check.dart';
import 'package:selfprivacy/logic/forms/recovery_domain_form.dart';
import 'package:selfprivacy/ui/forms/recovery_domain_form_view.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_new_device_key.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_old_token.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recover_by_recovery_key.dart';
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

class SelectDomainToRecover extends StatefulWidget {
  const SelectDomainToRecover({super.key});

  @override
  State<SelectDomainToRecover> createState() => _SelectDomainToRecoverState();
}

class _SelectDomainToRecoverState extends State<SelectDomainToRecover> {
  late final RecoveryDomainForm _form;

  @override
  void initState() {
    super.initState();
    _form = RecoveryDomainForm(
      validateDomain: checkRecoveryDomain,
      onSubmit: context
          .read<ServerInstallationCubit>()
          .submitDomainForAccessRecovery,
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
        listener: (final context, final state) {
          if (state is ServerInstallationRecovery &&
              state.currentStep == RecoveryStep.selecting &&
              state.recoveryCapabilities == ServerRecoveryCapabilities.none) {
            _form.showDomainNotFoundError();
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
          children: [RecoveryDomainFormView(recoveryDomainForm: _form)],
        ),
      );
}
