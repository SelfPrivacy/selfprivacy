import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/backblaze_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/dns_provider_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/domain_setup_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/root_user_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/server_provider_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/user/ssh_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/atoms/progress_indicators/progress_bar.dart';
import 'package:selfprivacy/ui/atoms/timer/brand_timer.dart';
import 'package:selfprivacy/ui/layouts/responsive_layout_with_infobox.dart';
import 'package:selfprivacy/ui/organisms/drawers/progress_drawer.dart';
import 'package:selfprivacy/ui/organisms/drawers/support_drawer.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/broken_domain_outlined_card.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/dns_provider_picker.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/domain_picker.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/server_provider_picker.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/server_type_picker.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_routing.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';
import 'package:selfprivacy/utils/network_utils.dart';

@RoutePage()
class InitializingPage extends StatelessWidget {
  const InitializingPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final cubit = context.watch<ServerInstallationCubit>();

    if (cubit.state is ServerInstallationRecovery) {
      return const RecoveryRoutingPage();
    } else {
      Widget? actualInitializingPage;
      if (cubit.state is! ServerInstallationFinished) {
        actualInitializingPage =
            [
              () => _stepServerProviderToken(cubit),
              () => _stepServerType(cubit),
              () => _stepDnsProviderToken(cubit),
              () => _stepBackblaze(cubit),
              () => _stepDomain(cubit),
              () => _stepUser(cubit),
              () => _stepServer(cubit),
              () => _stepCheck(cubit),
              () => _stepCheck(cubit),
              () => _stepCheck(cubit),
              () => _stepCheck(cubit),
            ][cubit.state.progress.index]();
      }

      const steps = [
        'initializing.steps.hosting',
        'initializing.steps.server_type',
        'initializing.steps.dns_provider',
        'initializing.steps.backups_provider',
        'initializing.steps.domain',
        'initializing.steps.master_account',
        'initializing.steps.server',
        'initializing.steps.dns_setup',
        'initializing.steps.nixos_installation',
        'initializing.steps.server_reboot',
        'initializing.steps.final_checks',
      ];

      return BlocListener<ServerInstallationCubit, ServerInstallationState>(
        listener: (final context, final state) {
          if (cubit.state is ServerInstallationFinished) {
            context.router.popUntilRoot();
          }
        },
        child: Scaffold(
          endDrawer: const SupportDrawer(),
          endDrawerEnableOpenDragGesture: false,
          appBar:
              Breakpoints.large.isActive(context)
                  ? null
                  : AppBar(
                    actions: [
                      if (cubit.state is ServerInstallationFinished)
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            context.router.popUntilRoot();
                          },
                        ),
                      const SizedBox.shrink(),
                    ],
                    title: Text('more_page.configuration_wizard'.tr()),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(28),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: ProgressBar(
                          steps: 8,
                          activeIndex: cubit.state.progressBar,
                        ),
                      ),
                    ),
                  ),
          body: LayoutBuilder(
            builder:
                (final context, final constraints) => Row(
                  children: [
                    if (Breakpoints.large.isActive(context))
                      ProgressDrawer(
                        steps: steps,
                        currentStep: cubit.state.progress.index,
                        title: 'more_page.configuration_wizard'.tr(),
                        constraints: constraints,
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (cubit.state is ServerInstallationEmpty ||
                                cubit.state is ServerInstallationNotFinished &&
                                    cubit.state.progress ==
                                        ServerSetupProgress.nothingYet)
                              Container(
                                alignment: Alignment.center,
                                child: BrandButton.filled(
                                  title: 'basis.connect_to_existing'.tr(),
                                  onPressed: () async {
                                    await context.router.replace(
                                      const RecoveryRoutingRoute(),
                                    );
                                  },
                                ),
                              ),
                            // const SizedBox(height: 8),
                            BrandOutlinedButton(
                              child: Text(
                                cubit.state is ServerInstallationFinished
                                    ? 'basis.close'.tr()
                                    : 'basis.later'.tr(),
                              ),
                              onPressed: () {
                                context.router.popUntilRoot();
                              },
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      width:
                          constraints.maxWidth -
                          (Breakpoints.large.isActive(context) ? 300 : 0),
                      height: constraints.maxHeight,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  Breakpoints.large.isActive(context)
                                      ? const EdgeInsets.all(16)
                                      : const EdgeInsets.fromLTRB(16, 0, 16, 0),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: actualInitializingPage,
                              ),
                            ),
                            if (!Breakpoints.large.isActive(context))
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: BrandButton.text(
                                      title:
                                          cubit.state
                                                  is ServerInstallationFinished
                                              ? 'basis.close'.tr()
                                              : 'basis.later'.tr(),
                                      onPressed: () {
                                        context.router.popUntilRoot();
                                      },
                                    ),
                                  ),
                                  if (cubit.state is ServerInstallationEmpty ||
                                      cubit.state
                                          is ServerInstallationNotFinished)
                                    Container(
                                      alignment: Alignment.center,
                                      child: BrandButton.text(
                                        title: 'basis.connect_to_existing'.tr(),
                                        onPressed: () async {
                                          await context.router.replace(
                                            const RecoveryRoutingRoute(),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          ),
        ),
      );
    }
  }

  Widget _stepServerProviderToken(
    final ServerInstallationCubit serverInstallationCubit,
  ) => BlocProvider(
    create: (final context) => ServerProviderFormCubit(serverInstallationCubit),
    child: Builder(
      builder: (final context) {
        final providerCubit = context.watch<ServerProviderFormCubit>();
        return ServerProviderPicker(
          formCubit: providerCubit,
          serverInstallationCubit: serverInstallationCubit,
        );
      },
    ),
  );

  Widget _stepServerType(
    final ServerInstallationCubit serverInstallationCubit,
  ) => BlocProvider(
    create: (final context) => ServerProviderFormCubit(serverInstallationCubit),
    child: Builder(
      builder:
          (final context) => ServerTypePicker(
            serverInstallationCubit: serverInstallationCubit,
          ),
    ),
  );

  Widget _stepDnsProviderToken(
    final ServerInstallationCubit initializingCubit,
  ) => BlocProvider(
    create: (final context) => DnsProviderFormCubit(initializingCubit),
    child: Builder(
      builder: (final context) {
        final providerCubit = context.watch<DnsProviderFormCubit>();
        return DnsProviderPicker(
          formCubit: providerCubit,
          serverInstallationCubit: initializingCubit,
        );
      },
    ),
  );

  Widget _stepBackblaze(final ServerInstallationCubit initializingCubit) =>
      BlocProvider(
        create: (final context) => BackblazeFormCubit(initializingCubit),
        child: Builder(
          builder: (final context) {
            final formCubitState = context.watch<BackblazeFormCubit>().state;
            return ResponsiveLayoutWithInfobox(
              topChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'initializing.connect_to_server_provider'.tr(
                      namedArgs: {'provider': 'Backblaze'},
                    ),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              primaryColumn: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CubitFormTextField(
                    autofocus: true,
                    formFieldCubit: context.read<BackblazeFormCubit>().keyId,
                    textAlign: TextAlign.center,
                    scrollPadding: const EdgeInsets.only(bottom: 70),
                    decoration: const InputDecoration(hintText: 'KeyID'),
                  ),
                  const SizedBox(height: 16),
                  CubitFormTextField(
                    formFieldCubit:
                        context.read<BackblazeFormCubit>().applicationKey,
                    textAlign: TextAlign.center,
                    scrollPadding: const EdgeInsets.only(bottom: 70),
                    decoration: const InputDecoration(
                      hintText: 'Master Application Key',
                    ),
                  ),
                  const SizedBox(height: 32),
                  BrandButton.filled(
                    onPressed:
                        formCubitState.isSubmitting
                            ? null
                            : () =>
                                context.read<BackblazeFormCubit>().trySubmit(),
                    title: 'basis.connect'.tr(),
                  ),
                  const SizedBox(height: 10),
                  BrandButton.text(
                    onPressed: () {
                      context.read<SupportSystemCubit>().showArticle(
                        article: 'how_backblaze',
                        context: context,
                      );
                      Scaffold.of(context).openEndDrawer();
                    },
                    title: 'initializing.how'.tr(),
                  ),
                ],
              ),
            );
          },
        ),
      );

  Widget _stepDomain(final ServerInstallationCubit initializingCubit) =>
      BlocProvider(
        create: (final context) {
          final cubit = DomainSetupCubit(initializingCubit);
          unawaited(cubit.load());
          return cubit;
        },
        child: const DomainPicker(),
      );

  Widget _stepUser(
    final ServerInstallationCubit initializingCubit,
  ) => BlocProvider(
    create:
        (final context) =>
            RootUserFormCubit(initializingCubit, FieldCubitFactory(context)),
    child: Builder(
      builder: (final context) {
        final formCubitState = context.watch<RootUserFormCubit>().state;

        return ResponsiveLayoutWithInfobox(
          topChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'initializing.create_master_account'.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'initializing.enter_username_and_password'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          primaryColumn: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (formCubitState.isErrorShown) const SizedBox(height: 16),
              if (formCubitState.isErrorShown)
                Text(
                  'users.username_rule'.tr(),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              const SizedBox(height: 32),
              CubitFormTextField(
                autofocus: true,
                formFieldCubit: context.read<RootUserFormCubit>().userName,
                textAlign: TextAlign.center,
                scrollPadding: const EdgeInsets.only(bottom: 70),
                decoration: InputDecoration(hintText: 'basis.username'.tr()),
              ),
              const SizedBox(height: 16),
              BlocBuilder<FieldCubit<bool>, FieldCubitState<bool>>(
                bloc: context.read<RootUserFormCubit>().isVisible,
                builder: (final context, final state) {
                  final bool isVisible = state.value;
                  return CubitFormTextField(
                    obscureText: !isVisible,
                    formFieldCubit: context.read<RootUserFormCubit>().password,
                    textAlign: TextAlign.center,
                    scrollPadding: const EdgeInsets.only(bottom: 70),
                    decoration: InputDecoration(
                      hintText: 'basis.password'.tr(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed:
                            () => context
                                .read<RootUserFormCubit>()
                                .isVisible
                                .setValue(!isVisible),
                      ),
                      suffixIconConstraints: const BoxConstraints(minWidth: 60),
                      prefixIconConstraints: const BoxConstraints(maxWidth: 60),
                      prefixIcon: Container(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              BrandButton.filled(
                onPressed:
                    formCubitState.isSubmitting
                        ? null
                        : () => context.read<RootUserFormCubit>().trySubmit(),
                title: 'basis.connect'.tr(),
              ),
            ],
          ),
        );
      },
    ),
  );

  Widget _stepServer(final ServerInstallationCubit appConfigCubit) {
    final bool isLoading =
        (appConfigCubit.state as ServerInstallationNotFinished).isLoading;
    final bool hasSshKey =
        (appConfigCubit.state as ServerInstallationNotFinished).customSshKey !=
        null;
    return Builder(
      builder:
          (final context) => ResponsiveLayoutWithInfobox(
            topChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'initializing.final'.tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  'initializing.create_server'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            primaryColumn: Column(
              children: [
                BrandButton.filled(
                  onPressed:
                      isLoading
                          ? null
                          : appConfigCubit.createServerAndSetDnsRecords,
                  title:
                      isLoading
                          ? 'basis.loading'.tr()
                          : 'initializing.create_server'.tr(),
                ),
                const SizedBox(height: 16),
                if (TlsOptions.allowCustomSshKeyDuringSetup)
                  Column(
                    children: [
                      Text('developer_settings.title'.tr()),
                      BrandOutlinedButton(
                        title:
                            hasSshKey
                                ? 'developer_settings.root_ssh_key_added'.tr()
                                : 'developer_settings.add_root_ssh_key'.tr(),
                        onPressed: () async {
                          await showModalBottomSheet<String?>(
                            context: context,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            builder:
                                (final BuildContext context) => Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: AddSshKey(appConfigCubit),
                                ),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
    );
  }

  Widget _stepCheck(final ServerInstallationCubit appConfigCubit) {
    assert(
      appConfigCubit.state is ServerInstallationNotFinished,
      'wrong state',
    );
    final state = appConfigCubit.state as TimerState;
    late int doneCount;
    late String? text;
    if (state.isServerResetedSecondTime) {
      text = 'initializing.server_rebooted'.tr();
      doneCount = 3;
    } else if (state.isServerResetedFirstTime) {
      text = 'initializing.one_more_restart'.tr();
      doneCount = 2;
    } else if (state.isServerStarted) {
      text = 'initializing.server_started'.tr();
      doneCount = 1;
    } else if (state.isServerCreated) {
      text = 'initializing.server_created'.tr();
      doneCount = 0;
    }
    return Builder(
      builder:
          (final context) => SizedBox(
            width: double.infinity,
            child: ResponsiveLayoutWithInfobox(
              topChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'initializing.checks'.tr(
                      namedArgs: {'done': doneCount.toString(), 'total': '4'},
                    ),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  if (text != null)
                    Text(text, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              primaryColumn: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 128),
                  const SizedBox(height: 10),
                  if (doneCount == 0 && state.dnsMatches != null)
                    Column(
                      children:
                          state.dnsMatches!.entries.map((final entry) {
                            final String domain = entry.key;
                            if (entry.value == DnsRecordStatus.nonexistent) {
                              return BrokenDomainOutlinedCard(
                                domain: domain,
                                dnsProvider:
                                    ProvidersController.currentDnsProvider!,
                              );
                            }
                            return Row(
                              children: [
                                if (entry.value == DnsRecordStatus.ok)
                                  const Icon(Icons.check, color: Colors.green),
                                if (entry.value == DnsRecordStatus.waiting)
                                  const Icon(
                                    Icons.schedule,
                                    color: Colors.amber,
                                  ),
                                const SizedBox(width: 10),
                                Text(domain),
                              ],
                            );
                          }).toList(),
                    ),
                  const SizedBox(height: 10),
                  if (!state.isLoading)
                    Row(
                      children: [
                        Text(
                          'initializing.until_the_next_check'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        BrandTimer(
                          startDateTime: state.timerStart!,
                          duration: state.duration!,
                        ),
                      ],
                    ),
                  if (state.isLoading)
                    Text(
                      'initializing.check'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ],
              ),
            ),
          ),
    );
  }
}

class AddSshKey extends StatelessWidget {
  const AddSshKey(this.serverInstallationCubit, {super.key});

  final ServerInstallationCubit serverInstallationCubit;
  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => JoblessSshFormCubit(serverInstallationCubit),
    child: Builder(
      builder: (final context) {
        final formCubitState = context.watch<JoblessSshFormCubit>().state;

        return BlocListener<JoblessSshFormCubit, FormCubitState>(
          listener: (final context, final state) {
            if (state.isSubmitted) {
              Navigator.pop(context);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 14),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IntrinsicHeight(
                      child: CubitFormTextField(
                        autofocus: true,
                        formFieldCubit: context.read<JoblessSshFormCubit>().key,
                        decoration: InputDecoration(
                          labelText: 'ssh.input_label'.tr(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    BrandButton.filled(
                      onPressed:
                          formCubitState.isSubmitting
                              ? null
                              : () =>
                                  context
                                      .read<JoblessSshFormCubit>()
                                      .trySubmit(),
                      title: 'ssh.create'.tr(),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
